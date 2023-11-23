from ncclient import manager
import sys
from lxml import etree


m = manager.connect(host='sbx-nxos-mgmt.cisco.com', port='830', username='admin',password='Admin_1234!', hostkey_verify=False, device_params={"name":"nexus"}, look_for_keys=False, allow_agent=False)

print(m.connected)
loopback_number = 20
LOOPBACK = {'loopback': 'lo{}'.format(loopback_number),
               'name': 'Loopback{}'.format(loopback_number)
              }

remove_ip_interface = """<config>
    <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
    <intf-items>
        <lb-items>
            <LbRtdIf-list operation="delete">
                <id>{0}</id>
            </LbRtdIf-list>
        </lb-items>
    </intf-items>
</System>
</config>"""

data = remove_ip_interface.format(LOOPBACK['loopback'])

netconf_response = m.edit_config(target='running', config=data)
# Parse the XML response
print(netconf_response)

m.close_session()
