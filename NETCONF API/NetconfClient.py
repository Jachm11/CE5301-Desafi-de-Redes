from ncclient import manager
import xmltodict

class NetconfClient:
    def __init__(self, host, port, username, password):
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.device = None

    # ------------Connection methods--------------

    def connect(self) -> bool:
        try:
            # Establish a NETCONF connection
            self.device = manager.connect(
                host=self.host,
                port=self.port,
                username=self.username,
                password=self.password,
                device_params={'name': 'default'},
                timeout=30,
                hostkey_verify=False,
                allow_agent=False
            )
            print("Connected to the device.")
            return True
        
        except Exception as e:
            print(f"Failed to connect to the device. Error: {str(e)}")
            return False


    def disconnect(self) -> bool:
        if self.device:
            self.device.close_session()
            print("Disconnected from the device.")
            return True
        else:
            return False

    # ------------<get-config>--------------

    def get_config(self, source='running', filter_str=None, save_to_file=False, file_name='config.xml') -> str:
        try:
            # Issue a NETCONF <get-config> operation
            config = self.device.get_config(source=source, filter=filter_str)

            config_data = config.data_xml

            # Save to file if the flag is set
            if save_to_file:
                self._save_str_to_file(config_data,file_name)

            return config_data

        except Exception as e:
            error_str = f"Failed to retrieve configuration. Error: {str(e)}"
            print(error_str)
            raise ValueError(error_str)

    def get_capabilities(self, save_to_file=False, file_name='capabilities.txt') -> dict:
        if self.device:
            try:
                capabilities = self.device.server_capabilities

                # Save to file if the flag is set
                if save_to_file:
                    self. _save_dict_to_file(capabilities, file_name)

                return capabilities
            
            except Exception as e:
                print(f"Failed to retrieve capabilities. Error: {str(e)}")
        else:
            print(f"Error: Device not connected")

    def get_schema(self, schema, save_to_file=False, file_name="schema.txt"):
        try:

            schema_str = self.device.get_schema(schema)

            # Save to file if the flag is set
            if save_to_file:
                self._save_str_to_file(str(schema_str), file_name)

            return schema_str

        except Exception as e:
            print(f"Failed to retrieve configuration. Error: {str(e)}")

    def get_serial(self):
        """
        Get system's serial number for a cisco-nx-os-device
        """
        serial_number = """
        <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
            <serial/>
        </System>
        """
        netconf_response = self.device.get(('subtree', serial_number))

        # Parse the XML and print the data
        xml_data = netconf_response.data_ele
        serial =  xml_data.find(".//{http://cisco.com/ns/yang/cisco-nx-os-device}serial").text
        
        return serial

    def get_loopbacks(self) -> str:
        """
        Get the loopbacks of a cisco-nx-os-device
        """

        loopback_filter = """
        <filter>
            <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
                <intf-items>
                    <lb-items></lb-items>
                </intf-items>
            </System>
        </filter>
        """

        ipv4_filter_template = """
        <filter>
            <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
                <ipv4-items>
                    <inst-items>
                        <dom-items>
                            <Dom-list>
                                <name>default</name>
                                <if-items>
                                    <If-list>
                                        <id>{0}</id>
                                    </If-list>
                                </if-items>
                            </Dom-list>
                        </dom-items>
                    </inst-items>
                </ipv4-items>
            </System>
        </filter>
        """

        netconf_response = self.device.get(filter=loopback_filter)
        netconf_data = xmltodict.parse(netconf_response.xml)["rpc-reply"]["data"]

        try:
            loopbacks = netconf_data["System"]["intf-items"]["lb-items"]["LbRtdIf-list"]
        except KeyError:
            print("There are no loopback interfaces currently configured.")

        if not type(loopbacks) is list:
            # Create a list with single object
            loopbacks = [loopbacks]
        
        loopbacks_info = []

        for loopback in loopbacks:
            loopback_info = {
                'interface_id': loopback["id"],
                'admin_state': loopback["adminSt"],
                'oper_state': loopback["lbrtdif-items"]["operSt"],
                'description': loopback.get("descr", ""),
            }

            # Retrieve IPv4 Addresses for Loopback
            ipv4_filter = ipv4_filter_template.format(loopback["id"])
            ipv4_response = self.device.get(filter=ipv4_filter)
            ipv4_data = xmltodict.parse(ipv4_response.xml)["rpc-reply"]["data"]

            # See if IPv4 Addresses exist
            try:
                ipv4_addresses = ipv4_data["System"]["ipv4-items"]["inst-items"]["dom-items"]["Dom-list"]["if-items"]["If-list"]["addr-items"]["Addr-list"]
                # Ensure list of addresses
                if not isinstance(ipv4_addresses, list):
                    ipv4_addresses = [ipv4_addresses]

                # Add IPv4 Addresses Info to loopback_info
                loopback_info['ipv4_addresses'] = [{'addr': addr.get('addr', "")} for addr in ipv4_addresses]
            except KeyError:
                loopback_info['ipv4_addresses'] = []

            loopbacks_info.append(loopback_info)

        return loopbacks_info

    # ------------<edit-config>--------------

    def edit_config(self, config_data, target='running') -> None:
        try:
            # Issue a NETCONF <edit-config> operation
            self.device.edit_config(config_data,target=target)

            print(f"Configuration edited successfully for target: {target}")

        except Exception as e:
            print(f"Failed to edit configuration. Error: {str(e)}")

    def add_loopback(self, loopback_number:int, loopback_ip, description) -> str:
        """
        Add a loopback on a cisco-nx-os-device
        """
        LOOPBACK_IP = { 'loopback': 'lo{}'.format(loopback_number),
                        'ip': loopback_ip,
                        'name': 'Loopback{}'.format(loopback_number),
                        'description': description
                    }

        add_ip_interface = """
        <config>
            <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
                <intf-items>
                    <lb-items>
                        <LbRtdIf-list>
                            <id>{0}</id>
                            <adminSt>up</adminSt>
                            <descr>{2}</descr>
                        </LbRtdIf-list>
                    </lb-items>
                </intf-items>
                <ipv4-items>
                    <inst-items>
                        <dom-items>
                            <Dom-list>
                                <name>default</name>
                                <if-items>
                                    <If-list>
                                        <id>{0}</id>
                                        <addr-items>
                                            <Addr-list>
                                                <addr>{1}</addr>
                                            </Addr-list>
                                        </addr-items>
                                    </If-list>
                                </if-items>
                            </Dom-list>
                        </dom-items>
                    </inst-items>
                </ipv4-items>
            </System>
        </config>
        """
        new_ip = add_ip_interface.format(
                LOOPBACK_IP['loopback'],
                LOOPBACK_IP['ip'],
                LOOPBACK_IP['description']
            )
        
        netconf_response = self.device.edit_config(target='running', config=new_ip)

        return netconf_response

    # ------------<copy-config>--------------

    def copy_config(self, source, target):
        try:
            # Issue a NETCONF <copy-config> operation
            self.device.copy_config(source=source, target=target)

            print(f"Configuration copied from {source} to {target} successfully.")

        except Exception as e:
            print(f"Failed to copy configuration. Error: {str(e)}")


    # ------------<delete-config>--------------

    def delete_loopback(self, loopback_number:int): 
        """
        Delete a loopback on a cisco-nx-os-device
        """
        LOOPBACK = {'loopback': 'lo{}'.format(loopback_number),
                    'name': 'Loopback{}'.format(loopback_number)
                }

        remove_ip_interface = """
        <config>
            <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
                <intf-items>
                    <lb-items>
                        <LbRtdIf-list operation="delete">
                            <id>{0}</id>
                        </LbRtdIf-list>
                    </lb-items>
                </intf-items>
            </System>
        </config>
        """

        data = remove_ip_interface.format(LOOPBACK['loopback'])
        netconf_response = self.device.edit_config(target='running', config=data)

        return netconf_response

    # --------------Misc--------------

    def _save_dict_to_file(self, dictionary, file_name):
        try:
            with open(file_name, 'w') as file:
                for value in dictionary:
                    file.write(value+"\n")
            print(f"Dictionary saved to {file_name}")

        except Exception as e:
            print(f"Failed to save dictionary to {file_name}. Error: {str(e)}")

    def _save_str_to_file(self, string, file_name):
        try:
            with open(file_name, 'w') as file:
                file.write(string)
            print(f"String saved to {file_name}")

        except Exception as e:
            print(f"Failed to save string to {file_name}. Error: {str(e)}")


if __name__ == "__main__":

    # Sandbox #1
    netconf_instance = NetconfClient(
        host="sandbox-iosxr-1.cisco.com",
        port=830,
        username="admin",
        password="C1sco12345",
    )

    # Sandbox #2
    netconf_instance = NetconfClient(
        host="sbx-nxos-mgmt.cisco.com",
        port=830,
        username="admin",
        password="Admin_1234!"
    )

    netconf_instance.connect()

    # ------------<get-config>--------------

    filter_str = """
    
    """

    # print(netconf_instance.get_config(save_to_file=True,filter_str=filter_str))
    # netconf_instance.get_config(save_to_file=True)

    # netconf_instance.get_capabilities(save_to_file=True)

    # print(netconf_instance.get_serial())

    print(netconf_instance.get_loopbacks())

    # schema = 'Cisco-NX-OS-device' 
    # print(netconf_instance.get_schema(schema,save_to_file=True))


    # ------------<edit-config>--------------

    edit_data = """
    
    """

    # netconf_instance.edit_config(edit_data, target='running')

    # print(netconf_instance.add_loopback(11,'192.168.0.1/24','JACHM TEST'))

    # ------------<delete-config>--------------

    #print(netconf_instance.delete_loopback(11))

    # ------------<copy-config>--------------

    # netconf_instance.copy_config('running','cadidate')


    netconf_instance.disconnect()
