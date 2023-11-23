from flask import Flask, request, jsonify, Response
from NetconfClient import NetconfClient

nc_clients = {}
system_session_id = 0

app = Flask(__name__)

@app.route('/connect', methods=['POST'])
def connect():
    try:
        
        data = request.get_json()
        host = data.get('host')
        port = data.get('port')
        username = data.get('username')
        password = data.get('password')

        new_ncclient = NetconfClient(
            host=host,
            port=port,
            username=username,
            password=password
        )

        global system_session_id

        if new_ncclient.connect():
            session_id = system_session_id
            nc_clients[system_session_id] = new_ncclient
            system_session_id += 1
            return jsonify({'session_id': session_id}), 200
        else:
            return jsonify({'error': "Unable to connect"}), 500

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/disconnect/<int:session_id>', methods=['POST'])
def disconnect(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]
            if nc_client.disconnect():
                del nc_clients[session_id]
                return jsonify({'message': f'Disconnected session with ID {session_id}'}), 200
            else:
                return jsonify({'error': f'Unable to disconnect session with ID {session_id}'}), 500
        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_config/<int:session_id>', methods=['GET'])
def get_config(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            # XML filter could be on the request body
            filter_str = request.data.decode('utf-8')

            if filter_str == "":
                filter_str = None

            config_data = nc_client.get_config(filter_str=filter_str)
            return Response(config_data, content_type='application/xml'), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_capabilities/<int:session_id>', methods=['GET'])
def get_capabilities(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            capabilities = nc_client.get_capabilities()
            capabilities_list = list(capabilities)

            return jsonify({'capabilities': capabilities_list}), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/get_schema/<int:session_id>', methods=['GET'])
def get_schema(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            data = request.get_json()
            schema = data.get('schema')

            if schema is None:
                return jsonify({'error': 'Schema not provided in the request body'}), 400

            schema_data = nc_client.get_schema(schema)

            return Response(str(schema_data), content_type='application/xml'), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# @app.route('/serial')
# def getSerial():
#     serial_number = """
#     <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device">
#     <serial/>
#     </System>"""
#     m = conexionConstante()
#     netconf_response = m.get(('subtree', serial_number))
#         # Parse the XML and print the data
#     xml_data = netconf_response.data_ele
#     serial =  xml_data.find(".//{http://cisco.com/ns/yang/cisco-nx-os-device}serial").text
#     print(serial)
#     return serial

# @app.route('/loopback')
# def getLoopback():
#     return items

# @app.route('/deleteL', methods=['POST'])
# def deleteLoopback():
#     name = request.form['name']
#     if name in items:
#         items.remove(name)
#     return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)