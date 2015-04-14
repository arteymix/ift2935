#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, render_template, request, url_for, g, redirect, abort, session
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
    cinemas = db.cursor()
    cinemas.execute('select * from cinema where id in (select noCinema from projette)')
    return render_template('home.html', cinemas=cinemas)

@app.route('/register')
def register():
    user = db.cursor()
    user.prepare('insert into compte values (:username, :password, :adresse,:telephone)')
    user.prepare('insert into compte')

    user.executemany(None, )

    return redirect(url_for('home'))

@app.route('/login', methods=['POST'])
def login():
    identification = db.cursor()
    with open('sql/identification-simple.sql') as f:
        identification.prepare(f.read())

    if 'username' not in request.form or 'password' not in request.form:
        return abort(403)

    app.logger.info(request.form.to_dict())

    row = identification.execute(None, request.form.to_dict()).fetchone()

    if row:
        session['compte'] = row
    return redirect(url_for('home'))

@app.route('/logout')
def logout():
    session.pop('compte')
    return redirect(url_for('home'))

@app.route('/search')
def search():
    results = db.cursor()
    results.prepare('select * from video where description like :terms')
    results.execute(None, {'terms': '%' + request.args.get('terms') + '%'})
    return render_template('search.html', results=results)

@app.route('/cinema/<int:cinema_id>')
def cinema(cinema_id):
    cinema = db.cursor()
    cinema.prepare('select * from cinema where id = :id')

    # projections pour le cinéma
    projections = db.cursor()
    with open('sql/projections-par-cinema.sql') as f:
        projections.prepare(f.read())

    return render_template('cinema.html',
            cinema=cinema.execute(None, {'id': cinema_id}).fetchone(),
            projections=projections.execute(None, {'cinema_id': cinema_id}))

@app.route('/custom-request/<name>')
def custom_request(name):
    with open(os.path.join('sql', name) + '.sql') as f:
        cursor = db.cursor()
        statement = f.read()
        cursor.execute(statement)
        return render_template('request.html', name=name,
                statement=unicode(statement, 'utf-8'),
                cursor=cursor)

@app.route('/realisateur/<int:realisateur_id>')
def realisateur(realisateur_id):
    realisateur = db.cursor()
    realisateur.prepare('select id, prenom, nom, biographie from realisateur natural join professionnel natural join personne where id = :id')

    # films du réalisateur
    films = db.cursor()
    with open('sql/films-par-realisateur.sql') as f:
        films.prepare(f.read())

    return render_template('realisateur.html',
            realisateur=realisateur.execute(None, {'id': realisateur_id}).fetchone(),
            films=films.execute(None, {'realisateur_id': realisateur_id}))

@app.route('/video/<int:video_id>')
def video(video_id):
    video = db.cursor()
    video.prepare('select * from video where video.id=:id')

    # réalisateurs du vidéo
    realisateurs = db.cursor()
    with open('sql/realisateurs-par-video.sql') as f:
        realisateurs.prepare(f.read())

    # réalisateurs du vidéo
    acteurs = db.cursor()
    with open('sql/acteurs-par-video.sql') as f:
        acteurs.prepare(f.read())

    return render_template('video.html',
        video=video.execute(None, {'id': video_id}).fetchone(),
        realisateurs=realisateurs.execute(None, {'video_id': video_id}),
        acteurs=acteurs.execute(None, {'video_id': video_id}))

@app.route('/preferences')
def preferences():
    return render_template('preferences.html')

app.run(debug=True)
