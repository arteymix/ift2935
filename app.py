from flask import Flask, render_template, url_for, g
import yaml
from cx_Oracle import connect

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html', config=app.config)

# load a yml configuration
with open('config.yml') as f:
    app.config.update(yaml.load(f))

app.run(debug=True)
