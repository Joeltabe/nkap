


from flask import Blueprint, jsonify, request
from firebase_admin import firestore
from werkzeug.security import check_password_hash, generate_password_hash


login = Blueprint('login', __name__)


db = firestore.client()
user_Ref = db.collection('users')

@login.route('/login', methods=['POST'])
def signin():
    try:
        # Get login data from the request body
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')

        # hash password and compare it with password in db
        user_ref = db.collection('users').document(password)
        user_data = user_ref.get().to_dict()

      
        query = user_Ref.where('email', '==', email).get()
        if len(query) == 0:
            return jsonify({'error': 'Wrong email'}), 401
        
        pswd_hash = generate_password_hash(password)

        query_pwd = user_Ref.where('password', '==', pswd_hash)
        if len(query_pwd)==0:
              return jsonify({'error': 'wrong password'}), 401
        
    except Exception as e:
        return jsonify({'message': 'Login Successful',
                        'email': email,
                        }), 200
             
              
    





        # pwd_hash = generate_password_hash(password)

        # Validate login credentials
    #     if user_data and user_data['password'] == password:
    #         return jsonify({'message': 'Login successful'})
    #     else:
    #         return jsonify({'error': 'Invalid login credentials'}), 401
    # except Exception as e:
    #     return jsonify({'error': str(e)}), 500
        
        # if len(query) == 0:
            
        
        