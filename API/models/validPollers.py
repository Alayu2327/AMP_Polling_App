from db import db
from models.poll import PollModel
 

class ValidPollerModel(db.Model):
    __tablename__ = 'validPollers'

    _id = db.Column(db.Integer, primary_key=True)
    poll_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    has_voted = db.Column(db.Boolean, default=False, nullable=False)
    

    # candidates = db.relationship("CandidateModel",backref="poll")

    # owner_id = db.Column(db.Integer, db.ForeignKey('users._id'))

    
    def save_to_db(self):
        db.session.add(self)
        db.session.commit()


    @classmethod
    def has_a_user_voted(cls, user_id, poll_id):
        print("hasvoted model")
        has_voted_res = cls.query.filter_by(user_id=user_id, poll_id=poll_id).first()
        if has_voted_res:
            return has_voted_res.has_voted
        poll = PollModel.find_by_id(poll_id)
        if poll.is_public == True:
            return False
        return False
    @classmethod
    def can_vote(cls, user_id, poll_id):
        can_vote = cls.query.filter_by(user_id=user_id, poll_id=poll_id).first()
        if can_vote:
            return True

        poll = PollModel.find_by_id(poll_id)
        if poll.is_public == True:
            return True
        return False


    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
        
    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()


    # @classmethod
    # def find_poll_by_user(cls, id):
    #     polls = cls.query.filter_by(owner_id=id).all()
    #     return {'polls': list(map(lambda x: x.json(), polls))}


    

    def json(self):
        return {
            'poll_id': self.poll_id, 
            'user_id': self.user_id,
            'has_voted': self.has_voted
         }
