from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from models.poll import PollModel
from models.user import UserModel
import json
from flask_jwt_extended import jwt_required
from random import randint


class Poll(Resource):

    parser = reqparse.RequestParser()
    parser.add_argument('title', type=str)
    parser.add_argument('description', type=str)
    # parser.add_argument('image_cover')
    parser.add_argument('poll_secret_key', type=str)
    parser.add_argument('is_public', type=bool)
    parser.add_argument('starting_date')
    parser.add_argument('deadline')

    # @jwt_required()
    def get(self, id):
        poll = PollModel.find_by_id(id)
        if poll:
            return poll.json()
        return {
            'status': 'failed',
            'message': 'poll not found'}, 400

    @jwt_required()
    def delete(self, id):
        poll = PollModel.find_by_id(id)
        if poll:
            poll.delete_from_db()
            return {'message': 'poll deleted.'}, 201
        return {'message': 'poll id is invalid.'}, 404

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



class PollList(Resource):
    parser = reqparse.RequestParser()

    def get(self):
        return {'polls': list(map(lambda x: x.json(), PollModel.query.all()))}
    @jwt_required()
    def post(self):
        parser = reqparse.RequestParser()
        

        parser.add_argument('title', type=str, required=True, help="A poll must have a title!!")
        parser.add_argument('is_public', type=bool)
        # parser.add_argument('image_cover')
        parser.add_argument('starting_date', type=str)
        parser.add_argument('deadline', type=str)
        parser.add_argument('description', type=str)

        data = parser.parse_args()
        print({**data})


        current_user = UserModel.find_by_id(int(get_jwt_identity()))
        new_poll_secret_key = randint(100000, 999999)
        new_poll = PollModel(**data,owner=current_user, poll_secret_key=new_poll_secret_key)


        # try:
        new_poll.save_to_db()
        print(new_poll.json())
        return new_poll.json()
        # except:
            # return {"message": "An error occurred inserting the item."}, 500

        # item = ItemModel(name, **data)

        # try:
        #     item.save_to_db()
        # except:
        #     return {"message": "An error occurred inserting the item."}, 500

        # return item.json(), 201



class Search_by_keyword(Resource):
    def get(self, keyword):
        print(keyword)
        found_houses = HouseModel.search_by_keyword(keyword)
        # print(found_houses)
        return found_houses
        # return {'houses': list(map(lambda x: x.json(), HouseModel.query.all()))}