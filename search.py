import sys
import logging.config

import bottle
from bottle import get, request, response, hook

import sqlite_utils

# Set up app, logging, and database
#
app = bottle.default_app()
app.config.load_config('./etc/search.ini')

db = sqlite_utils.Database(app.config['sqlite.dbfile'])

logging.config.fileConfig(app.config['logging.config'])


# Return errors in JSON
#
# Adapted from <https://stackoverflow.com/a/39818780>
#
def json_error_handler(res):
    if res.content_type == 'application/json':
        return res.body
    res.content_type = 'application/json'
    if res.body == 'Unknown Error.':
        res.body = bottle.HTTP_CODES[res.status_code]
    return bottle.json_dumps({'error': res.body})


app.default_error_handler = json_error_handler

# Allow CORS
#
# Caution: don't just allow * in production
#
@hook('after_request')
def enable_cors():
    response.headers['Access-Control-Allow-Origin'] = '*'

# Routes

@get('/search')
def home():
    results = []
    if 'q' in request.query and request.query.q:
        posts = db['posts'].search(request.query.q)
        results = list(posts)
    return {'results': results}

