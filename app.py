#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, render_template, request, url_for, g
import yaml
from cx_Oracle import connect, makedsn
import os

app = Flask(__name__)

# load a YAML configuration
with open('config.yml') as f:
    app.config.update(yaml.load(f))

# génère le dsn avec makedsn
app.config['database']['dsn'] = makedsn(**app.config['database']['dsn'])

db = connect(**app.config['database'])

@app.route('/')
def home():
    cursor = db.cursor()
    cursor.execute('select * from ALL_TABLES')
    for row in cursor:
        app.logger.info(row)
    return render_template('home.html')

@app.route('/search')
def search():
    return render_template('search.html')
    with db:
        results = db.cursor()
        query = {'order_by': ''}
        query.update(request.args)
        cursor.execute('select * from order by ? limit 10', **query)
        return render_template('search.html', results=results)

@app.route('/custom-request/<name>')
def custom_request(name):
    with open(os.path.join('sql', name) + '.sql') as f:
        cursor = db.cursor()
        cursor.execute(f.read())
    return render_template('request.html', cursor=cursor)

@app.route('/preferences')
def preferences():
    return render_template('preferences.html')

app.run(debug=True)
