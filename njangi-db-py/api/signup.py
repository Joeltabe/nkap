

import uuid
from flask import Blueprint, request, jsonify
from firebase_admin import firestore, initialize_app, credentials
from werkzeug.security import check_password_hash,generate_password_hash
import validators

db = firestore.client()
user_Ref = db.collection('users')

signup = Blueprint('signup', __name__)


@signup.route('/register', methods=['POST'])
def register():
    try:
        firstname = request.json['firstname']
        lastname = request.json['lastname']
        phone = request.json['phone']
        email = request.json['email']
        address = request.json['address']
        password = request.json['password']
        uname = request.json['uname']


        # checks and authentication to make sure that informatio that is inputed by the user is valid
        
        if len(password) < 6:
            return jsonify({'error': 'password too short'}),400
        
        if not validators.email(email):
            return jsonify({'error': 'Email is not valid'}),400
        
        query = user_Ref.where('email', '==', email).get()
        if  len(query) > 0:
            return jsonify({'error': 'Email is already taken'}), 409
        
        query_name = user_Ref.where('uname', '==', uname).get()
        if len(query_name) > 0:
            return jsonify({'error': 'Username already taken'}),409

        pwd_hash = generate_password_hash(password)

        
        id = uuid.uuid4()
        user_Ref.document(id.hex).set({
            'firstname': firstname,
            'lastname': lastname,
            'phone': phone,
            'email' : email,
            'address': address,
            'password': pwd_hash,
            'uname' : uname
        })
        return jsonify({'success': True}), 200
    
    except Exception as e:
        return f"An error occured: {e}"
    

# this function is still under construction
    
# def is_email_taken():
#     # Check if the email is already in use
#     query = user_Ref.where('email', '==', email).get()
#     return len(query) > 0


def is_name_taken(uname):
    # print("Check if the email is already in use") 
    query = user_Ref.where('uname', '==', uname).get()
    return query
    # return jsonify({'message': 'Check if the email is already in use'})
    

    