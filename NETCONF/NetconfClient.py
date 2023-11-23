from ncclient import manager
from xml.etree import ElementTree as ET

class NetconfClient:
    def __init__(self, host, port, username, password):
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.device = None

    def connect(self) -> None:
        try:
            # Establish a NETCONF connection
            self.device = manager.connect(
                host=self.host,
                port=self.port,
                username=self.username,
                password=self.password,
                device_params={'name': 'nexus'},
                timeout=10,
                hostkey_verify=False
            )
            print("Connected to the device.")
        except Exception as e:
            print(f"Failed to connect to the device. Error: {str(e)}")

    def disconnect(self) -> None:
        if self.device:
            self.device.close_session()
            print("Disconnected from the device.")

    def get_config(self, source='running', filter_str=None, save_to_file=False, file_name='config.xml') -> str:
        try:
            # Issue a NETCONF <get-config> operation
            config = self.device.get_config(source=source, filter=filter_str)

            config_data = config.data_xml

            # Save to file if the flag is set
            if save_to_file:
                self.save_to_file(file_name, config_data)

            return config_data

        except Exception as e:
            print(f"Failed to retrieve configuration. Error: {str(e)}")

    def save_to_file(self, file_name, data):
        try:
            with open(file_name, 'w') as file:
                file.write(data)
            print(f"Configuration saved to {file_name}")

        except Exception as e:
            print(f"Failed to save configuration to {file_name}. Error: {str(e)}")

    def get_capabilities(self) -> dict:
        if self.device:
            try:
                return self.device.server_capabilities
            except Exception as e:
                print(f"Failed to retrieve capabilities. Error: {str(e)}")
        else:
            print(f"Error: Device not connected")

    # UNTESTED (pero deberia funcionar)
    def edit_config(self, config_data, target='running') -> None:
        try:
            # Issue a NETCONF <edit-config> operation
            self.device.edit_config(config_data,target=target)

            print(f"Configuration edited successfully for target: {target}")

        except Exception as e:
            print(f"Failed to edit configuration. Error: {str(e)}")

    # UNTESTED (no creo que funcione)
    def copy_config(self, source, target):
        try:
            # Issue a NETCONF <copy-config> operation
            self.device.copy_config(source=source, target=target)

            print(f"Configuration copied from {source} to {target} successfully.")

        except Exception as e:
            print(f"Failed to copy configuration. Error: {str(e)}")

    def add_interface(self, interface_name, description):
        try:
            # Prepare the XML data for the <edit-config> operation
            edit_data = f"""
                <config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
                    <interface-configurations xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ifmgr-cfg">
                        <interface-configuration>
                            <active>act</active>
                            <interface-name>{interface_name}</name>
                            <description>{description}</description>
                        </interface>
                    </interface-configurations>
                </config>
            """

            # Issue a NETCONF <edit-config> operation
            self.device.edit_config(target='running', config=edit_data)

            print(f"Interface '{interface_name}' added successfully.")

        except Exception as e:
            print(f"Failed to add interface. Error: {str(e)}")


# Example usage:
if __name__ == "__main__":

    # # Replace with your device's details
    # netconf_instance = NetconfClient(
    #     host="sandbox-iosxr-1.cisco.com",
    #     port=830,  # Default NETCONF port
    #     username="admin",
    #     password="C1sco12345",
    # )

    # Replace with your device's details
    netconf_instance = NetconfClient(
        host="sbx-nxos-mgmt.cisco.com",
        port=830,  # Default NETCONF port
        username="admin",
        password="Admin_1234!"
    )

    netconf_instance.connect()

    # Perform NETCONF operations here

    filter_str = f"""
<filter xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
    <interface-configurations xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ifmgr-cfg"/>
</filter>
"""
    edit_data = f"""
<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
    <interface-configurations xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-ifmgr-cfg">
        <interface-configuration>
            <active>act</active>
            <interface-name>JACHM</interface-name>
            <description>test</description>
        </interface-configuration>
    </interface-configurations>
</config>
"""

    edit_data = f"""
<config xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">
   <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
      <interface>
         <name xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0">GigabitEthernet3</name>
         <description>This is a test</description>
         <type xmlns:ianaift="urn:ietf:params:xml:ns:yang:iana-if-type">ianaift:ethernetCsmacd</type>
         <enabled>false</enabled>
         <ipv4 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip">
            <address>
               <ip>87.2.3.4</ip>
               <netmask>255.255.255.0</netmask>
            </address>
         </ipv4>
         <ipv6 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip"/>
      </interface>
   </interfaces>
</config>
"""


    loopback_filter = """
    <filter>
        <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
            <intf-items>
                <lb-items></lb-items>
            </intf-items>
        </System>
    </filter>"""

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
    </filter>"""
    print(netconf_instance.get_config(save_to_file=True,filter_str=loopback_filter))
    #print(netconf_instance.get_config(save_to_file=True))

    
    # netconf_instance.edit_config(edit_data, target='running')
    #print(netconf_instance.get_config(save_to_file=True,filter_str=filter_str))


    # netconf_instance.show_interfaces()

    for capability in netconf_instance.get_capabilities():
        print('*'* 50)
        print(capability)

    # netconf_instance.add_interface("JACHM","test")

    # netconf_instance.copy_config('running','cadidate')

    netconf_instance.disconnect()
