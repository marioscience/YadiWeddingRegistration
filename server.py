import os
import psycopg2
from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# TODO: setting for production deployment. set env variables for creds
def get_db_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="yadidb",
        user="postgres",
        password="SuperPass123"
    )
    return conn


def execute_sql_read(query):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute(query)
    data = cur.fetchall()
    cur.close()
    conn.close()
    return data


@app.route("/gifts")
def gifts():
    return execute_sql_read("SELECT * FROM gifts;")


@app.route("/users")
def users():
    return execute_sql_read("SELECT * FROM users;")


@app.route("/selections")
def selections():
    query = """SELECT gifts.giftid, 
           users.first_name, 
           users.last_name,
           users.invitation_sent,
           users.phone,
           users.email,
           gifts.name, 
           gifts.description, 
           gifts.picture,
           selections.note,
           selections.date_selected,
           users.last_seen 
    FROM gifts
    INNER JOIN selections ON gifts.giftid = selections.giftid
    INNER JOIN users ON users.userid = selections.userid
    ORDER BY gifts.giftid;"""
    return execute_sql_read(query)

# TODO:
# - use bcrypt to salt, hash and check passwords
# - use SQLAlchemy to connect to database
#       - As an alternative, we can use psycopg2 library to run raw queries
# - use flask-jwt-login for authentication


if __name__ == '__main__':
    app.run()