from db import db
from models.validPollers import ValidPollerModel


class CandidateModel(db.Model):
    __tablename__ = 'candidates'

    _id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80))
    # image_cover = db.Column(db.String(200))
    description = db.Column(db.String(200))
    vote_result = db.Column(db.Integer, default=0)

    poll_id = db.Column(db.Integer, db.ForeignKey('polls._id'))
    

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
    
    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
        
    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()

    @classmethod
    def get_vote(cls, candidate_id, user_id, poll_id):

        if (not ValidPollerModel.has_a_user_voted(user_id, poll_id)) and ValidPollerModel.can_vote(user_id, poll_id):

            candidate = cls.query.filter_by(_id=candidate_id).first()
            candidate.vote_result += 1
            db.session.add(candidate)
            db.session.commit()


            valid_poller_obj = ValidPollerModel(poll_id=poll_id, user_id=user_id, has_voted=True)
            valid_poller_obj.save_to_db()

            print(candidate.json())
            return candidate.json()

        return {
            "status": "failed",
            "message": "you have already voted or this is private vote"
        }

    @classmethod
    def search_by_keyword(cls, keyword):
        houses = cls.query.filter_by(location_word=keyword).all()
                # print(found_houses)
        # for house in found_houses:
        #     print("house.location_word")
        return {'houses': list(map(lambda x: x.json(), houses))}


    def json(self):
        return {
            '_id': self._id,
            'name': self.name, 
            'poll_id': self.poll_id,
            'description': self.description,
            'vote_result': self.vote_result,
            
         }
