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
                device_params={'name': 'iosxr'},
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

    def get_config(self, source='running', filter_str=None) -> str:
        try:
            # Issue a NETCONF <get-config> operation
            config = self.device.get_config(source=source, filter=filter_str)

            return config.data_xml

        except Exception as e:
            print(f"Failed to retrieve configuration. Error: {str(e)}")

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
            self.device.edit_config(target=target, config=config_data)

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


# Example usage:
if __name__ == "__main__":

    # Replace with your device's details
    netconf_instance = NetconfClient(
        host="sandbox-iosxr-1.cisco.com",
        port=830,  # Default NETCONF port
        username="admin",
        password="C1sco12345",
    )

    netconf_instance.connect()

    # Perform NETCONF operations here

    # netconf_instance.get_config()

    # netconf_instance.edit_config(target='running', config_data=edit_data)

    # netconf_instance.show_interfaces()

    # print(netconf_instance.capabilities)
    # for capability in netconf_instance.get_capabilities():
    #     print('*'* 50)
    #     print(capability)

    netconf_instance.copy_config('running','cadidate')

    netconf_instance.disconnect()
