from flask import Flask, render_template, request, url_for, g
import yaml
from cx_Oracle import connect, makedsn

app = Flask(__name__)

# load a YAML configuration
with open('config.yml') as f:
    app.config.update(yaml.load(f))

# génère le dsn avec makedsn
app.config['database']['dsn'] = makedsn(**app.config['database']['dsn'])

db = connect(**app.config['database'])

@app.before_first_request
def initialize_database():
    with db:
        with open('sql/schema.sql') as f:
            db.cursor().executemany(f.read().encode('utf-8'), [])

@app.route('/')
def home():
    with db:
        cursor = db.cursor()
        cursor.execute('select * from ALL_TABLES')
    return render_template('home.html', config=app.config,
            header=cursor.description,
            tables=cursor.fetchall())

@app.route('/search')
def search():
    return render_template('search.html')
    with db:
        results = db.cursor()
        query = {'order_by': ''}
        query.update(request.args)
        cursor.execute('select * from order by ? limit 10', **query)
        return render_template('search.html', results=results)

@app.route('/preferences')
def preferences():
    return render_template('preferences.html')

app.run(debug=True)
