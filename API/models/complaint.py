from db import db


class ComplaintModel(db.Model):
    __tablename__ = 'complaints'

    _id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(80))
    user_id = db.Column(db.String(200))

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
    def find_by_id_and_edit(cls, id, new_complaint):
        prev_complaint = cls.query.filter_by(_id=id).first()
        prev_complaint.content = new_complaint
        prev_complaint.save_to_db()

        return cls.query.filter_by(_id=id).first()

   
    def json(self):
        return {
            '_id': self._id,
            'content': self.content, 
            'poll_id': self.poll_id,
            'user_id': self.user_id,            
         }
