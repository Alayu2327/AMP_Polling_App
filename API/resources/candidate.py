from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from models.candidate import CandidateModel
from models.user import UserModel
import json
from flask_jwt_extended import jwt_required


class Candidate(Resource):

    parser = reqparse.RequestParser()
    parser.add_argument('name', type=str, required=True, help="A candidate must have a name!!")
    parser.add_argument('poll_id', type=int, required=True, help="A candidate must have the vote id!!")
    # parser.add_argument('image_cover')
    parser.add_argument('description', type=str)

    # @jwt_required()
    def get(self, id):
        candidate = CandidateModel.find_by_id(id)
        if candidate:
            return candidate.json()
        return {
            'status': 'failed',
            'message': 'candidate not found'}, 400

    @jwt_required()
    def delete(self, id):
        candidate = CandidateModel.find_by_id(id)
        if candidate:
            candidate.delete_from_db()
            return {'message': 'candidate deleted.'}, 201
        return {'message': 'candidate id is invalid.'}, 404

    def put(self, id):
        
        data = Poll.parser.parse_args()

        poll = PollModel.find_by_id(id)
        # print(data)

        # for row in data.keys():s
        #     if data[row] = None:
        #         print (row, data[row])
        #     else:
        #         house.

        # if house:
        #     HouseModel.update_by_id(id, data)

        #     return{
        #         'status': 'success',
        #         'data': house.json()
        #     }

        return {'message': 'poll id is invalid.'}, 404



class CandidateList(Resource):
    parser = reqparse.RequestParser()

    def get(self):
        return {'candidates': list(map(lambda x: x.json(), CandidateModel.query.all()))}
    @jwt_required()
    def post(self):
        parser = reqparse.RequestParser()
        

        parser.add_argument('name', type=str, required=True, help="A candidate must have a name!!")
        parser.add_argument('poll_id', type=int, required=True, help="A candidate must have the vote id!!")
        # parser.add_argument('image_cover')
        parser.add_argument('description', type=str)

        data = parser.parse_args()
        print({**data})


        new_candidate = CandidateModel(**data)


        # try:
        new_candidate.save_to_db()
        print(new_candidate.json())
        return new_candidate.json()
        # except:
            # return {"message": "An error occurred inserting the item."}, 500

        # item = ItemModel(name, **data)

        # try:
        #     item.save_to_db()
        # except:
        #     return {"message": "An error occurred inserting the item."}, 500

        # return item.json(), 201

class GivePoll(Resource):
    parser = reqparse.RequestParser()

    @jwt_required()
    def post(self, id):
        parser = reqparse.RequestParser()
        parser.add_argument('candidate_id', type=int, required=True, help="A candidate id is required to vote!!")
        data = parser.parse_args()
        candidate_id = data['candidate_id']

        return CandidateModel.get_vote(candidate_id)


class Search_by_keyword(Resource):
    def get(self, keyword):
        print(keyword)
        found_houses = HouseModel.search_by_keyword(keyword)
        # print(found_houses)
        return found_houses
        # return {'houses': list(map(lambda x: x.json(), HouseModel.query.all()))}

