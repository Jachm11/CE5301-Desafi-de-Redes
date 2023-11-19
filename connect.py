from ncclient import manager
from pprint import pprint
import xmltodict
import xml.dom.minidom

m = manager.connect(host='sandbox-iosxr-1.cisco.com', port='830', username='admin',
                    password='C1sco12345', hostkey_verify=False)

print(m.connected)

#for capability in m.server_capabilities:
#   print('*'* 50)
#   print(capability)

netconf_filter = """
<filter>
   <interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">
      <interface>
         <name>GigabitEthernet1</name>
      </interface>
   </interfaces>
</filter>
"""
running_config = m.get_config('running')

interfaces = xmltodict.parse(running_config.xml)["rpc-reply"]["data"]
interface = interfaces["interfaces"][0]["interface"][0]
print(interface)
print('Interface name: { ', interface["interface-name"])
print('Interface description: {  }', interface["description"])
print('Interface IP address: {  }', interface["ipv4"]["addresses"]["address"]["address"])
print('Interface IP netmask: {  }', interface["ipv4"]["addresses"]["address"]["netmask"])
""" 

print(f'Interface name: { interface["name"]["#text"] }')
print(f'Interface description: { interface["description"] }')
print(f'Interface IP address: {  interface["ipv4"]["address"]["ip"] }')
print(f'Interface IP netmask: {  interface["ipv4"]["address"]["netmask"] }') """



m.close_session()