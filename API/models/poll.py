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

    owner_id = db.Column(db.Integer, db.ForeignKey('users._id'))

    # user = db.relationship('UserModel')

    # def __init__(self, name, price, store_id):
    #     self.name = name
    #     self.price = price
    #     self.store_id = store_id
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
    def search_by_keyword(cls, keyword):
        houses = cls.query.filter_by(location_word=keyword).all()
                # print(found_houses)
        # for house in found_houses:
        #     print("house.location_word")
        return {'houses': list(map(lambda x: x.json(), houses))}


    @classmethod
    def housesWithInRadius(cls, distance, lon, lat):
        DISTANCE = distance #100 meters
        houseWithIn = db.session.execute("select * from houses where ST_DWithin(houses.coordinates,ST_MakePoint(9.0436513,38.7590634)::geography,1000);")
        # houseWithIn = db.session.query(cls).filter(func.ST_DWithin(cls.coordinates, cast(func.ST_SetSRID(func.ST_MakePoint(float(lon), float(lat)), 1609), Geography), DISTANCE)).all()
        for house in houseWithIn:
            print(house)
        # print(houseWithIn)
        return houseWithIn




    def json(self):
        return {
            '_id': self._id,
            'title': self.title, 
            'poll_secret_key': self.poll_secret_key,
            'is_public': self.is_public,
            'description': self.description,
            'starting_date': self.starting_date,
            'deadline': self.deadline,
            'candidates': self.candidates
            "owner_id": self.owner_id
         }
