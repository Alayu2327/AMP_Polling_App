from db import db


class UserModel(db.Model):
    __tablename__ = 'users'

    _id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(25))
    email = db.Column(db.String(80))
    password = db.Column(db.String(80))
    phone_number = db.Column(db.String(20))
    polls = db.relationship("PollModel",backref="owner")
    

    

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    @classmethod
    def find_by_email(cls, email):
        return cls.query.filter_by(email=email).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(_id=id).first()

    @classmethod
    def generatePasswordResetToken(cls):
        # generate token here

        # password_reset_token = 
        self.password_reset_token = password_reset_token
        db.session.add(self)
        db.session.commit()        


    def json(self):
        return {
            "id" : self._id,
            "username" : self.username,
            "email" : self.email,
            "phone_number" :self.phone_number
        }