from bottle import install, get, post, run, request, view
from bottle_jade import JadePlugin
from os import path, environ
import ftfy

jade = install(JadePlugin(template_folder=path.dirname(path.abspath(__file__))))

DEFAULTS = {
	'fix_entities': 'auto',
	'remove_terminal_escapes': False,
	'fix_encoding': True,
	'fix_latin_ligatures': True,
	'fix_character_width': True,
	'uncurl_quotes': False,
	'fix_surrogates': True,
	'remove_control_chars': True,
	'normalization': 'NFC',
}

def paramValue(s):
	if s == 'True':
		return True
	elif s == 'False':
		return False
	else:
		return s

@get('/')
def index():
	options = {}
	for key in DEFAULTS:
		if key in request.query:
			options[key] = paramValue(request.query[key])
		else:
			options[key] = DEFAULTS[key]

	if 'mojibake' in request.query:
		return jade.render('index.jade', **{
			'mojibake': request.query.mojibake,
			'decoded': ftfy.fix_text(request.query.mojibake, **options),
			'options': options,
			'piwik': 'ENABLE_PIWIK' in environ,
		})
	else:
		return jade.render('index.jade', **{
			'mojibake': '',
			'decoded': False,
			'options': options,
			'ftfy_version': ftfy.__version__,
			'piwik': 'ENABLE_PIWIK' in environ,
		})
