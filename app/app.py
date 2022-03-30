from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def hello_world():
    return {
            "echo": request.args
    }

app.run(debug=True, host='0.0.0.0')