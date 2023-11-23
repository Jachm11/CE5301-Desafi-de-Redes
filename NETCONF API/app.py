from flask import Flask, request, jsonify, Response
from NetconfClient import NetconfClient

nc_clients = {}
system_session_id = 0

app = Flask(__name__)

@app.route('/connect', methods=['POST'])
def connect():
    try:
        # Expected JSON:  
        # { 
        #   "host": "example.com", 
        #   "port": 830, 
        #   "username": "your_username", 
        #   "password": "your_password" 
        # } 
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

            # Expected JSON data:
            # {
            #   "filter": "<get-config-filter-xml-here>",
            #   "target": "running"  # Optional, defaults to "running"
            # }
            # Check if the request has a JSON payload

            data = request.get_json(silent=True)

            # If there is no JSON payload, treat it as an empty filter
            if data is None:
                filter_str = None
                target = 'running'
            else:
                filter_str = data.get('filter', None)
                target = data.get('target', 'running')

            config_data = nc_client.get_config(filter_str=filter_str, source=target)
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
    
@app.route('/get_serial/<int:session_id>', methods=['GET'])
def get_serial(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            serial_number = nc_client.get_serial()

            return jsonify({'serial_number': serial_number}), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/get_loopbacks/<int:session_id>', methods=['GET'])
def get_loopbacks(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            loopbacks_info = nc_client.get_loopbacks()

            return jsonify({'loopbacks_info': loopbacks_info}), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/edit_config/<int:session_id>', methods=['PUT'])
def edit_config(session_id):
    try:
        if session_id in nc_clients:
            nc_client = nc_clients[session_id]

            # Expected JSON data:
            # {
            #   "config_data": "<edit-config-xml-here>",
            #   "target": "running"  # Optional, defaults to "running"
            # }
            data = request.get_json()
            config_data = data.get('config')
            target = data.get('target', 'running')

            nc_client.edit_config(config_data, target=target)

            return jsonify({'message': f'Configuration edited successfully for target: {target}'}), 200

        else:
            return jsonify({'error': f'Session with ID {session_id} not found'}), 404

    except Exception as e:
        return jsonify({'error': str(e)}), 500

# @app.route('/deleteL', methods=['POST'])
# def deleteLoopback():
#     name = request.form['name']
#     if name in items:
#         items.remove(name)
#     return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)