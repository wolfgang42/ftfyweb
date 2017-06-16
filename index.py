from bottle import get, post, run, request, view
import ftfy

@get('/')
@view('index')
def index():
	print(request.query)
	if 'mojibake' in request.query:
		return {
			'mojibake': request.query.mojibake,
			'decoded': ftfy.fix_text(request.query.mojibake),
		}
	else:
		return {
			'mojibake': '',
			'decoded': False,
		}

run(host='0.0.0.0', port=8080, debug=True, reloader=True)
