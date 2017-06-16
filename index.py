from bottle import get, post, run, request, view
import ftfy

@get('/')
@view('index')
def index():
	return {'decoded': False}

@post('/')
@view('index')
def convert():
	return {'decoded': ftfy.fix_text(request.forms.mojibake)}

run(host='0.0.0.0', port=8080, debug=True, reloader=True)
