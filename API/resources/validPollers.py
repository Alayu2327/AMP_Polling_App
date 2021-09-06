from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from models.validPollers import ValidPollerModel
from models.user import UserModel
import json
from flask_jwt_extended import jwt_required

 
class CanVote(Resource):

    # @jwt_required()
    def get(self, user_id, poll_id):
        can_vote = ValidPollerModel.can_vote(user_id, poll_id)
        
        return {
            'status': 'sucess',
            'message': can_vote}, 200

    
class HasVoted(Resource):
    def get(self, user_id, poll_id):

        print("hasvoted resource")
        has_voted = ValidPollerModel.has_a_user_voted(user_id, poll_id)
        return {
            'status': 'sucess',
            'message': has_voted
            }
        
class PrivateVoter(Resource):
    def post(self):
            valid_poller_obj = ValidPollerModel(poll_id=poll_id, user_id=user_id, has_voted=False)
            valid_poller_obj.save_to_db()  
                  
            return valid_poller_obj.json()