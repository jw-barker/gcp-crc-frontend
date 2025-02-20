from flask import Flask, jsonify
from google.cloud import datastore
import logging

app = Flask(__name__)

# Add the namespace when creating the client
client = datastore.Client(namespace="visitorcounter")

@app.route('/visit', methods=['GET'])
def visit():
    kind = "visitorCounter"
    entity_id = "counter"

    try:
        # Fetch the current counter from Firestore
        key = client.key(kind, entity_id)
        entity = client.get(key)

        if not entity:
            logging.error('Counter not found in Firestore.')
            return jsonify({'error': 'Counter not found in Firestore'}), 404

        # Increment the count
        logging.info(f"Current count: {entity['count']}")
        entity['count'] += 1

        # Update the entity in Firestore
        client.put(entity)
        logging.info(f"New count: {entity['count']}")

        return jsonify({'count': entity['count']})

    except Exception as e:
        logging.error(f"Error in /visit endpoint: {e}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
