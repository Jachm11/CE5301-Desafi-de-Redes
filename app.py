from flask import Flask, render_template, request, redirect
from ncclient import manager
from pprint import pprint
import xmltodict
import xml.dom.minidom

app = Flask(__name__)

items = []  # This list will store the items
coneccion = {
    'host': "",
    'port': "",
    'username': "",
    'password': ""
}
def conexionConstante():
    m = manager.connect(
                  host= coneccion['host'], 
                  port= coneccion['port'], 
                  username= coneccion['username'],
                  password= coneccion['password'], 
                  hostkey_verify=False,
                  device_params={"name":"nexus"},
                  look_for_keys=False, allow_agent=False)
    print(m.connected)
    return m

@app.route('/capabilities')
def getCapabilities():
    m = conexionConstante()
    capabilities = []
    for capability in m.server_capabilities:
        print('*'* 50)
        capabilities.append(capability)
        print(capability)
    return capabilities

@app.route('/config')
def getConfig():
    m = conexionConstante()
    running_config = m.get_config('running')
    return "nop funciono"

@app.route('/schema')
def getSchema():
    m = conexionConstante()
    schema = m.get_schema('Cisco-NX-OS-device')
    return "convertir de xml a json o un formato mas pequeno"

@app.route('/serial')
def getSerial():
    serial_number = """
    <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
    <serial/>
    </System>"""
    m = conexionConstante()
    netconf_response = m.get(('subtree', serial_number))
        # Parse the XML and print the data
    xml_data = netconf_response.data_ele
    serial =  xml_data.find(".//{http://cisco.com/ns/yang/cisco-nx-os-device}serial").text
    print(serial)
    return serial

@app.route('/loopback')
def getLoopback():
    return items

@app.route('/connect', methods=['POST'])
def create():
    print('test post', request.get_json())
    data = request.get_json()
    print(data)
    coneccion['username'] = data['username']
    coneccion['password'] = data['password']
    coneccion['host'] = data['host']
    coneccion['port'] = data['port']
    res = conexionConstante()
    if(res.connected == True):
        return "True"
    else:
        return 'error'

@app.route('/deleteL', methods=['POST'])
def deleteLoopback():
    name = request.form['name']
    if name in items:
        items.remove(name)
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)