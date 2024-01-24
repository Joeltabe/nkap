
import uuid
from flask import Blueprint, request, jsonify
from firebase_admin import firestore

db = firestore.client()
user_Ref = db.collection('users')

userAPI = Blueprint('userAPI', __name__)


@userAPI.route('/add', methods=['POST'])
def create():
    try:
        id = uuid.uuid4()
        user_Ref.document(id.hex).set(request.json)
        return jsonify({'success': True}), 200
    except Exception as e:
        return f"An error occured: {e}"