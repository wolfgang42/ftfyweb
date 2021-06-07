from bottle import install, get, post, run, request, view
from bottle_jade import JadePlugin
from os import path, environ
import ftfy

jade = install(JadePlugin(template_folder=path.dirname(path.abspath(__file__))))

# Bugfix for python-jade: pyjade/ext/html.py:TYPE_CODE has a typo and incorrectly declares 'elsif' instead of 'elif'
# Upstream seems to have been abandoned so we just hack it here
import pyjade, operator
pyjade.ext.html.TYPE_CODE['elif'] = operator.truth


OPTIONS = [
	'unescape_html',
	'remove_terminal_escapes',
	'fix_encoding',
	'fix_latin_ligatures',
	'fix_character_width',
	'uncurl_quotes',
	'fix_surrogates',
	'remove_control_chars',
	'normalization',
]
DEFAULTS = {}
for opt in OPTIONS:
	DEFAULTS[opt] = getattr(ftfy.TextFixerConfig(), opt)

# Get explanations for each fix
# (this also gets docstrings for other stuff in ftfy.fixes, but we don't care about that)
FIX_EXPLANATIONS={}
from inspect import getmembers, isfunction
for fix, fixfn in getmembers(ftfy.fixes, isfunction):
	FIX_EXPLANATIONS[fix] = (fixfn.__doc__ or '').split('\n\n')[0]

def paramValue(s):
	if s == 'True':
		return True
	elif s == 'False':
		return False
	else:
		return s

@get('/')
def index():
	# 'fix_entities' was renamed to 'unescape_html'
	if 'fix_entities' in request.query and 'unescape_html' not in request.query:
		request.query['unescape_html'] = request.query['fix_entities']

	options = {}
	for key in DEFAULTS:
		if key in request.query:
			options[key] = paramValue(request.query[key])
		else:
			options[key] = DEFAULTS[key]

	if options['normalization'] == 'None': options['normalization'] = None

	if 'mojibake' in request.query:
		decoded, explanation = ftfy.fix_and_explain(request.query.mojibake, **options, explain=True)
		return jade.render('index.jade', **{
			'mojibake': request.query.mojibake,
			'decoded': decoded,
			'explanation': explanation,
			'FIX_EXPLANATIONS': FIX_EXPLANATIONS,
			'options': options,
			'ftfy_version': ftfy.__version__,
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
