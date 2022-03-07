# ftfyweb integration smoke tests
# This script makes HTTP requests to ftfyweb and makes sure that everything it's getting back looks reasonable.
# It's written as a separate end-to-end test to make sure that all the layers (including bottle etc) aren't mangling things,
# since we can get some pretty weird encoding issues.

from collections import namedtuple
import http.client
import urllib.parse
from html.parser import HTMLParser
import sys

Test = namedtuple('Test', ['input', 'result'])

TESTS=[
	# Some of these tests came from the ftfy docs, others from various places
	# Consider testing https://github.com/LuminosoInsight/python-ftfy/blob/master/tests/test_cases.json as well?
	Test('ＬＯＵＤ\u3000ＮＯＩＳＥＳ', 'LOUD NOISES'),
	Test('ﬂuﬃeﬆ', 'fluffiest'),
	Test('L&AMP;AMP;ATILDE;&AMP;AMP;SUP3;PEZ', 'LóPEZ'),
	Test('â€œ like this â€�', '" like this �'),
	Test('ðŸ¤”', '🤔'),
	Test('voilÃ le travail', 'voilà le travail'),
	Test("\x1b[36;44mI'm blue, da ba dee da ba doo...\x1b[0m", "I'm blue, da ba dee da ba doo..."),
	Test('&macr;\\_(ã\x83\x84)_/&macr;', '¯\\_(ツ)_/¯'),
	Test('&Jscr;ohn &HilbertSpace;ancock', '𝒥ohn ℋancock'),
	Test('&lt;tag&gt;', '<tag>'),
	Test('<&lt;tag&gt;>', '<&lt;tag&gt;>'),
	Test('&ntilde; &Ntilde; &NTILDE; &nTILDE;', 'ñ Ñ Ñ &nTILDE;'),
]

http = http.client.HTTPConnection(sys.argv[1])

class ResultHtmlParser(HTMLParser):
	"""
	Extract the input and result from the HTML response.

	self.input and self.output provide the results.

	Uses `self.inres` to keep track of whether it's just seen the div.result open tag.
	"""
	def __init__(self):
		HTMLParser.__init__(self)
		self.inres = False
		self.input = None
		self.result = None

	def handle_starttag(self, tag, attrlist):
		attrs = dict(attrlist)
		if tag == 'input' and 'name' in attrs and attrs['name'] == 'mojibake':
			self.input = attrs['value']
		elif 'class' in attrs and attrs['class'] == 'result':
			self.inres = True

	def handle_data(self, data):
		if self.inres:
			if self.result:
				raise Exception('Multiple data chunks for result')
			self.result = data

	def handle_endtag(self, tag):
		if self.inres:
			self.inres = False

for test in TESTS:
	req = http.request('GET', f"/?mojibake={urllib.parse.quote(test.input)}")
	res = http.getresponse()
	if res.status != 200:
		raise Exception(f"Got status {res.status} for test \"{test.input}\"")

	parser = ResultHtmlParser()
	parser.feed(res.read().decode('utf-8'))
	if parser.input == None:
		raise Exception('No input found in HTML')
	if parser.result == None:
		raise Exception('No result found in HTML')

	print(f"/?mojibake={urllib.parse.quote(test.input)}")
	print(repr(test.input), repr(test.result))
	print(repr(parser.input), repr(parser.result))
	if parser.input != test.input:
		raise Exception(f'HTML did not mirror input: {repr(parser.input)} != {repr(test.input)}')
	if parser.result != test.result:
		raise Exception(f'HTML did not have correct result: {repr(parser.result)} != {repr(test.result)}')

print()
print('All tests passed')
