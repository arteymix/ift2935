from flask import Flask, render_template, url_for, g
import yaml
from cx_Oracle import connect, makedsn

app = Flask(__name__)

# load a YAML configuration
with open('config.yml') as f:
    app.config.update(yaml.load(f))

# génère le dsn avec makedsn
app.config['database']['dsn'] = makedsn(**app.config['database']['dsn'])

db = connect(**app.config['database'])

@app.route('/')
def home():
    return render_template('home.html', config=app.config)

app.run(debug=True)
