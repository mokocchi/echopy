from flask import request, Blueprint
from flask_restful import Api, Resource

echo_v1_0_bp = Blueprint('echo_v1_0_bp', __name__)

class EchoResource(Resource):
    def get(self):
        data = request.args
        res = {
            "echo": request.args
        }
        return res, 200

api = Api(echo_v1_0_bp)
api.add_resource(EchoResource, '/api/v1.0/echo/', endpoint='echo')