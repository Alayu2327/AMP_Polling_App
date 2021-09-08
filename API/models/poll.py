from db import db

 

class PollModel(db.Model):
    __tablename__ = 'polls'

    _id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80))
    # image_cover = db.Column(db.String(200))
    description = db.Column(db.String(200))
    poll_secret_key = db.Column(db.String(10))
    is_public = db.Column(db.Boolean, default=True, nullable=False)
    starting_date = db.Column(db.String(15))
    deadline = db.Column(db.String(15))

    candidates = db.relationship("CandidateModel",backref="poll")

    complaints = db.relationship("ComplaintModel",backref="complaint")

    owner_id = db.Column(db.Integer, db.ForeignKey('users._id'))

    # user = db.relationship('UserModel')

    
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
    def find_by_secretkey(cls, secretkey):
        return cls.query.filter_by(poll_secret_key=secretkey).first()


    @classmethod
    def find_poll_by_user(cls, id):
        polls = cls.query.filter_by(owner_id=id).all()
        return {'polls': list(map(lambda x: x.json(), polls))}



    def json(self):
        return {
            '_id': self._id,
            'title': self.title, 
            'poll_secret_key': self.poll_secret_key,
            'is_public': self.is_public,
            'description': self.description,
            'starting_date': self.starting_date,
            'deadline': self.deadline,
            "owner_id": self.owner_id,
            'candidates': list(map(lambda x: x.json(), self.candidates)),
            "complaints": list(map(lambda x: x.json(), self.complaints))
         }
