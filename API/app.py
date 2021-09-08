from flask import Flask
from flask_restful import Api
from sqlalchemy import event
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_jwt_extended import JWTManager
from resources.user import UserRegister, UserLogin, ChangePassword, UserLogout, User
from resources.poll import Poll, PollList, Search_by_keyword, UsersPoll, GetPollBySecretkey
from resources.candidate import Candidate, CandidateList, GivePoll
from resources.validPollers import CanVote, HasVoted, PrivateVoter
from resources.complaint import Complaint, ComplaintList
from flask_cors import CORS

 
app = Flask(__name__)

CORS(app)

app.config['WHOOSH_BASE'] = 'whoosh'
app.config['CORS_HEADERS'] = 'Content-Type'
app.config['MAIL_SERVER']='smtp.mailtrap.io'
app.config['MAIL_PORT'] = 2525
app.config['MAIL_USERNAME'] = '05873cf083fae6'
app.config['MAIL_PASSWORD'] = '2a4b487d0b1ebd'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
# cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
app.config['JWT_COOKIE_CSRF_PROTECT'] = False
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = False
app.config['JWT_TOKEN_LOCATION'] = ['cookies']
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['PROPAGATE_EXCEPTIONS'] = True
app.config["JWT_SECRET_KEY"] = "super-secret jwt key ;laskdjf"
app.config.from_pyfile('config.cfg')

app.secret_key = 'house_rent_project fa;lsdkjf;akj'
jwt = JWTManager(app)
api = Api(app)


@app.before_first_request
def create_tables():
    # db.engine.execute('create extension postgis') 
    db.create_all()


@app.after_request
def creds(response):
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    return response


# api.add_resource(Store, '/store/<string:name>')
# api.add_resource(StoreList, '/stores')
# wa.whoosh_index(app, HouseModel)

api.add_resource(Poll, '/api/v1/polls/<id>')
api.add_resource(PollList, '/api/v1/polls')
api.add_resource(UsersPoll, '/api/v1/users/<id>/polls')
api.add_resource(GivePoll, '/api/v1/vote')
api.add_resource(PrivateVoter, '/api/v1/privatevoter')
api.add_resource(GetPollBySecretkey, '/api/v1/polls/secretkey/<secretkey>')

api.add_resource(CanVote, '/api/v1/canvote/user/<user_id>/poll/<poll_id>')
api.add_resource(HasVoted, '/api/v1/hasvoted/user/<user_id>/poll/<poll_id>')


api.add_resource(Candidate, '/api/v1/candidates/<id>')
api.add_resource(CandidateList, '/api/v1/candidates')

api.add_resource(Complaint, '/api/v1/complaints/<id>')
api.add_resource(ComplaintList, '/api/v1/complaints')

api.add_resource(UserRegister, '/api/v1/users/register')
api.add_resource(UserLogin, '/api/v1/users/login')
# api.add_resource(ConfirmEmail, '/api/v1/users/confirm_email/<token>')
# api.add_resource(ForgotPassword, '/api/v1/users/forgotPassword')
api.add_resource(ChangePassword, '/api/v1/users/changePassword')
api.add_resource(UserLogout, '/api/v1/users/logout/')
api.add_resource(User, '/api/v1/user/<id>')


# api.add_resource(Search_by_keyword, '/api/v1/houses/search/<keyword>')



if __name__ == '__main__':
    from db import db
    from mail import mail
    db.init_app(app)
    mail.init_app(app)

    app.run(port=5000, debug=True)
