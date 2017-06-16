from bottle import get, post, run, request, template, view
import ftfy

@get('/')
def index():
	return template('index')

@post('/')
@view('decoded')
def convert():
	return {'decoded': ftfy.fix_text(request.forms.mojibake)}

run(host='0.0.0.0', port=8080, debug=True, reloader=True)
