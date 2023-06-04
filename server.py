from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<h1>Hello Man</h1>"

# TODO:
# - use bcrypt to salt, hash and check passwords
# - use SQLAlchemy to connect to database
#       - As an alternative, we can use psycopg2 library to run raw queries
# - use flask-jwt-login for authentication


if __name__ == '__main__':
    app.run()