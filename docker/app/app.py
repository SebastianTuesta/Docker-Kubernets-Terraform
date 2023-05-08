from flask import Flask
import sqlalchemy as db
import os
import socket

def connect_db():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    IP_ADDRESS = s.getsockname()[0]
    s.close()
    
    try:
        POSTGRES_USER = os.environ['POSTGRES_USER']
        POSTGRES_PASSWORD = os.environ['POSTGRES_PASSWORD']
        POSTGRES_DB = os.environ['POSTGRES_DB']
        
        conn_str = f'postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@postgres:5432/{POSTGRES_DB}'
        
        engine = db.create_engine(conn_str)
        _ = engine.connect()
        return f"Successfull conected BD. Local ip address: {IP_ADDRESS}"

    except Exception as e:
        return f"Local ip address: {IP_ADDRESS}"

app = Flask(__name__)

@app.route("/")
def main():
    return f"<h1>Connection</h1>\n<p>{connect_db()}</p>"
