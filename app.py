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
    return render_template('home.html', cinemas=db.cursor().execute('select * from cinema'))

@app.route('/search')
def search():
    results = db.cursor()
    results.prepare('select * from video where description like :terms')
    results.execute(None, {'terms': '*'})
    return render_template('search.html', results=results)

@app.route('/cinema/<int:cinema_id>')
def cinema_projette(cinema_id):
    cursor = db.cursor()
    with open('sql/projection-par-cinema.sql') as f:
        cursor.prepare(f.read().encode('utf-8'))
    return render_template('request.html', name='Projection pour le cinéma',
            cursor=cursor.execute(None, {'cinema_id': cinema_id}))

@app.route('/custom-request/<name>')
def custom_request(name):
    with open(os.path.join('sql', name) + '.sql') as f:
        cursor = db.cursor()
        cursor.execute(f.read())
    return render_template('request.html', name=name, cursor=cursor)

@app.route('/realisateur/<int:realisateur_id>')
def realisateur(realisateur_id):
    films = db.cursor()
    with open('sql/films-par-realisateur.sql') as f:
        films.prepare(f.read())
    return render_template('request.html', name='',
            cursor=films.execute(None, {'realisateur_id': realisateur_id}))

@app.route('/video/<int:video_id>')
def video(video_id):
    video = db.cursor()
    video.prepare('select * from video where video.id=:id')

    # réalisateurs du vidéo
    realisateurs = db.cursor()
    with open('sql/realisateurs-par-video.sql') as f:
        realisateurs.prepare(f.read())

    return render_template('video.html',
        video=video.execute(None, {'id': video_id}).fetchone(),
        realisateurs=realisateurs.execute(None, {'video_id': video_id}))

@app.route('/preferences')
def preferences():
    return render_template('preferences.html')

app.run(debug=True)
