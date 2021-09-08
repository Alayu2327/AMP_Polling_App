from flask_restful import Resource, reqparse
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from models.complaint import ComplaintModel
from models.user import UserModel
import json
from flask_jwt_extended import jwt_required
from db import db

class Complaint(Resource):

    parser = reqparse.RequestParser()
    parser.add_argument('content', type=str, required=True, help="A complaint must have a complaint content!!")
    parser.add_argument('poll_id', type=int, required=True, help="A complaint must have the poll id!!")
    parser.add_argument('user_id', type=int, required=True, help="A complaint must have the user id!!")

    # @jwt_required()
    def get(self, id):
        complaint = ComplaintModel.find_by_id(id)
        if complaint:
            return complaint.json()
        return {
            'status': 'failed',
            'message': 'complaint not found'}, 400

    @jwt_required()
    def delete(self, id):
        complaint = ComplaintModel.find_by_id(id)
        if complaint:
            complaint.delete_from_db()
            return {'message': 'complaint deleted.'}, 201
        return {'message': 'complaint id is invalid.'}, 404

    def put(self, id):
        parser = reqparse.RequestParser()
        
        parser.add_argument('content', type=str)
        
        data = parser.parse_args()
        print({**data})

        for key in list(data):
            if data[key] == None:
                del data[key]
        print({**data})


        current_complaint = ComplaintModel.find_by_id(id)
        if current_complaint:
            current_complaint = ComplaintModel.query.filter_by(_id=id).update(data)

            # current_complaint.save_to_db()
            db.session.commit()
            current_complaint = ComplaintModel.find_by_id(id)

            return current_complaint.json()

        return {'message': 'complaint id is invalid.'}, 404





class ComplaintList(Resource):
    parser = reqparse.RequestParser()

    def get(self):
        return {'complaints': list(map(lambda x: x.json(), ComplaintModel.query.all()))}
    @jwt_required()
    def post(self):
        parser = reqparse.RequestParser()
        
        parser.add_argument('content', type=str, required=True, help="A complaint must have a complaint content!!")
        parser.add_argument('poll_id', type=int, required=True, help="A complaint must have the poll id!!")
        parser.add_argument('user_id', type=int, required=True, help="A complaint must have the user id!!")
        
        data = parser.parse_args()
        print({**data})

        new_complaint = ComplaintModel(**data)


        # try:
        new_complaint.save_to_db()
        print(new_complaint.json())
        return new_complaint.json()
        # except:
            # return {"message": "An error occurred inserting the item."}, 500

        # item = ItemModel(name, **data)

        # try:
        #     item.save_to_db()
        # except:
        #     return {"message": "An error occurred inserting the item."}, 500

        # return item.json(), 201



