from bottle import install, get, post, run, request, view
from bottle_jade import JadePlugin
from os import path
import ftfy

jade = install(JadePlugin(template_folder=path.dirname(path.abspath(__file__))))

@get('/')
def index():
	if 'mojibake' in request.query:
		return jade.render('index.jade', **{
			'mojibake': request.query.mojibake,
			'decoded': ftfy.fix_text(request.query.mojibake),
		})
	else:
		return jade.render('index.jade', **{
			'mojibake': '',
			'decoded': False,
		})
