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
            parser = reqparse.RequestParser()
        

            parser.add_argument('poll_id', type=int, required=True, help="A poll id is required to register private voter!!")
            parser.add_argument('user_id', type=int, required=True, help="A user id is required to register private voter!!")

            # parser.add_argument('image_cover')

            data = parser.parse_args()
            print({**data})
            poll_id = data["poll_id"]
            user_id = data["user_id"]

            valid_poller_obj = ValidPollerModel(poll_id=poll_id, user_id=user_id, has_voted=False)
            valid_poller_obj.save_to_db()  

            return valid_poller_obj.json()

            