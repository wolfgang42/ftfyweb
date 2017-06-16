from bottle import get, post, run, request, view
import ftfy

@get('/')
@view('index')
def index():
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
