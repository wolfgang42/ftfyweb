% def checkedif(bool):
% 	return 'checked' if bool else ''
% end
% def selectedif(bool):
% 	return 'selected' if bool else ''
% end
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Mojibake Decoder</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.9.2/css/bulma.min.css" integrity="sha512-byErQdWdTqREz6DLAA9pCnLbdoGGhXfU6gm1c8bkf7F51JVmUBlayGe2A31VpXWQP+eiJ3ilTAZHCR3vmMyybA==" crossorigin="anonymous">
		<style type="text/css">
			.result {
				line-height: 1.5;
				padding-bottom: calc(0.375em - 1px);
				padding-left: calc(0.625em - 1px);
				padding-right: calc(0.625em - 1px);
				padding-top: calc(0.375em - 1px);
				background-color: whitesmoke;
				color: #4a4a4a;
				font-size: 1rem;
			}
			summary { cursor: pointer }
			#fix_encoding_options>.field {margin-bottom: 0.5rem}
			.footer { font-size: 85%; padding-bottom: 3rem; }
				/* https://philipwalton.github.io/solved-by-flexbox/demos/sticky-footer/ */
				html {height: 100%; overflow: visible;}
				body {
				display: -webkit-box;
				display: -webkit-flex;
				display: flex;
				-webkit-box-orient: vertical;
				-webkit-box-direction: normal;
				-webkit-flex-direction: column;
				flex-direction: column;
				height: 100%;
			}
			header, footer {
				-webkit-box-flex: 0;
				-webkit-flex: none;
				flex: none;
			}
			main {
				-webkit-box-flex: 1;
				-webkit-flex: 1 0 auto;
				flex: 1 0 auto;
			}
		</style>
	</head>
	<body>
		<header class="hero is-primary is-bold">
			<div class="hero-body"><div class="container">
				<h1>
					<div class="title">Mojibake Decoder</div>
				</h1>
			</div></div>
		</header>
		<main class="section container content">
			<form method="GET" id="form">
				<label class="label" for="mojibake">Mojibake:</label>
				<div class="field has-addons">
					<p class="control is-expanded">
						<input class="input" type="text" name="mojibake" value="{{mojibake}}" autofocus>
					</p>
					<p class="control">
						<input class="button is-primary" type="submit" value="Decode">
					</p>
				</div>
				% if decoded:
					<strong>Decoded:</strong>
					<div class="result">{{decoded}}</div>
					<details class="mb-5">
						<summary>Decoding steps</summary>
						% if len(explanation) == 0:
							<p><em>No decoding (string is same as original)</em></p>
						% else:
							<ol class="mt-0">
								% for step in explanation:
									% if step[0] == 'encode':
										<li>
											encode (string→bytes) as
											% if step[1].startswith('sloppy-'):
												<a href="https://ftfy.readthedocs.io/en/latest/bad_encodings.html#module-ftfy.bad_codecs.sloppy">{{step[1]}}</a>
											% elif step[1] == 'utf-8-variants':
												<a href="https://ftfy.readthedocs.io/en/latest/bad_encodings.html#module-ftfy.bad_codecs.utf8_variants">{{step[1]}}</a>
											% else:
												{{step[1]}}
											% end
										</li>
									% elif step[0] == 'decode':
										<li>
											decode (bytes→string) as
											% if step[1].startswith('sloppy-'):
												<a href="https://ftfy.readthedocs.io/en/latest/bad_encodings.html#module-ftfy.bad_codecs.sloppy">{{step[1]}}</a>
											% elif step[1] == 'utf-8-variants':
												<a href="https://ftfy.readthedocs.io/en/latest/bad_encodings.html#module-ftfy.bad_codecs.utf8_variants">{{step[1]}}</a>
											% else:
												{{step[1]}}
											% end
										</li>
									% elif step[0] == 'apply':
										<li>
											apply (string→string)
											<a href="https://ftfy.readthedocs.io/en/latest/fixes.html#ftfy.fixes.{{step[1]}}">{{step[1]}}</a>
											<p class="help mt-0">{{FIX_EXPLANATIONS[step[1]]}}</p>
										</li>
									% elif step[0] == 'transcode':
										<li>
											transcode (bytes→bytes) with
											<a href="https://ftfy.readthedocs.io/en/latest/fixes.html#ftfy.fixes.{{step[1]}}">{{step[1]}}</a>
											<p class="help">{{FIX_EXPLANATIONS[step[1]]}}</p>
										</li>
									% else:
										<li>{{step}}</li>
									% end
								% end
							</ol>
						% end
					</details>
				% end
				<div class="field is-horizontal">
					<div class="field-label is-normal"><label class="label">Unescape HTML</label></div>
					<div class="field-body">
						<div class="control"><div class="field">
							<div class="select"><select name="unescape_html">
								<option value="True" {{selectedif(options['unescape_html']==True)}}>Yes</option>
								<option value="False" {{selectedif(options['unescape_html']==False)}}>No</option>
								<option value="auto" {{selectedif(options['unescape_html']=='auto')}}>Auto</option>
							</select></div>
							<div class="help">
								Yes: Replace HTML entities (e.g. <code>&amp;amp;</code>) with their values.<br>
								No: Do not replace HTML entities.<br>
								Auto: Replace HTML entities in text that doesn’t contain a literal <code>&lt;</code> indicating that the input is actual HTML.
							</div>
						</div></div>
					</div>
				</div>

				% include('option-bool.tpl', code='remove_terminal_escapes', name="Remove terminal escapes", help="Remove “ANSI” terminal control sequences, like codes to change the text color.")

				<div class="field is-horizontal mb-0">
					<div class="field-label"><label class="label">Fix encoding</label></div>
					<div class="field-body">
						<div class="field is-narrow"><div class="control">
							<label class="radio">
								<input type="radio" name="fix_encoding" value="True" {{checkedif(options['fix_encoding'])}}> Yes
							</label>
							<label class="radio">
								<input type="radio" name="fix_encoding" value="False" {{checkedif(not options['fix_encoding'])}}> No
							</label>
							<div class="help">Attempt to repair mistakes caused by misinterpreting Unicode data, by decoding the text in a different encoding standard.</div>
							<div id="fix_encoding_options" class="mt-2">
								% include('option-bool.tpl', code='restore_byte_a0', name='Restore byte A0', help="Allow a literal space (U+20) to be interpreted as a non-breaking space (U+A0) when that would make it part of a fixable mojibake string.")
								% include('option-bool.tpl', code='replace_lossy_sequences', name='Replace lossy sequences', help="Detect mojibake that has been partially replaced by the characters ‘�’ or ‘?’. If the mojibake could be decoded otherwise, replace the detected sequence with ‘�’.")
								% include('option-bool.tpl', code='decode_inconsistent_utf8', name='Decode inconsistent UTF-8', help="When we see sequences that distinctly look like UTF-8 mojibake, but there’s no consistent way to reinterpret the string in a new encoding, replace the mojibake with the appropriate UTF-8 characters anyway. This helps to decode strings that are concatenated from different encodings.")
								% include('option-bool.tpl', code='fix_c1_controls', name='Fix C1 controls', help="Replace C1 control characters (the useless characters U+80 - U+9B that come from Latin-1) with their Windows-1252 equivalents, like HTML5 does, even if the whole string doesn’t decode as Latin-1.")
							</div>
						</div></div>
					</div>
				</div>

				% include('option-bool.tpl', code='fix_latin_ligatures', name="Separate Latin ligatures", help="Separate ligatures (such as ﬁ) into individual letters.")
				% include('option-bool.tpl', code='fix_character_width', name="Fix character width", help="Replace fullwidth Latin characters and halfwidth Katakana with their more standard widths.")
				% include('option-bool.tpl', code='uncurl_quotes', name="Uncurl quotes", help="Replace various forms of ‘curly’ “quotes” with plain ASCII 'straight' \"quotes\".")
				% include('option-bool.tpl', code='fix_surrogates', name="Fix surrogates", help="Replace sequences of UTF-16 surrogate codepoints with the character they were meant to encode. This fixes text that was decoded with the obsolete UCS-2 standard, and allows it to support high-numbered codepoints such as emoji.")
				% include('option-bool.tpl', code='remove_control_chars', name="Remove control characters", help='Remove certain control characters that have no displayed effect on text. This includes most of the ASCII control characters, plus some Unicode controls such as the byte order mark (U+FEFF). Useful control characters, such as Tab, Line Feed, and bidirectional marks, are left as they are. See the <a href="https://ftfy.readthedocs.io/en/latest/fixes.html#ftfy.fixes.remove_control_chars">ftfy docs</a> for the full list.')
				<div class="field is-horizontal">
					<div class="field-label is-normal"><label class="label">Normalization</label></div>
					<div class="field-body">
						<div class="control"><div class="field">
							<div class="select"><select name="normalization">
								% for opt in ['NFC', 'NFD', 'NFKC', 'NFKD', 'None']:
									<option {{selectedif(options['normalization'] == opt)}}>{{opt}}</option>
								% end
							</select></div>
							<div class="help">
								Which <a href="https://en.wikipedia.org/wiki/Unicode_equivalence#Normal_forms">Unicode normal form</a>
								to use for normalizing the string.
							</div>
						</div></div>
					</div>
				</div>
			</form>
		</main>

		<footer class="footer">
			<div class="container">
				<div class="content has-text-centered">
					Built by <a href="https://www.linestarve.com/">Wolfgang Faust</a>
					&bull;
					<a href="https://github.com/wolfgang42/ftfyweb"><img width="16" height="16" alt="GitHub:" style="vertical-align:middle" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABAAQMAAACQp+OdAAAABlBMVEUAAAAAAAClZ7nPAAAAAXRSTlMAQObYZgAAAMxJREFUKFOt0rFtBCEURdE7IiCkBEqhNCZzWyO5EbYDNiNAXAesPCvboYmOxH/iIQDIAwCCXgAk7QBUXQCovkb2UFRtQFYdQFGdO7RjumPHxnkjrKKzXsSVtNVGXEGv2kgToHTyD4wbZQHUeaPurfWGAZDfsO+UvuE/I4vjhfv038V250URwEnxguAk2yE5yB8LqoP86RW0kx6eh3bi0/PQRuyCNsIooBfHAPTkmC+wnwGogAsoD3Dulrt4FGxAEPYPEIQdmwAk6PyxvgA2bdfnuuNAlAAAAABJRU5ErkJggg=="> wolfgang42/ftfyweb</a>
					<div style="padding-top: .5em">Powered by <a href="https://ftfy.readthedocs.io/en/latest/">ftfy</a> v{{ftfy_version}}</div>
				</div>
			</div>
		</footer>
		<script>
			var fix_encoding_input = document.getElementById('form').elements['fix_encoding']
			function fix_encoding_subopts() {
				var enabled = fix_encoding_input.value === 'True'
				Array.from(document.querySelectorAll('#fix_encoding_options input')).forEach(function(e) {e.disabled = !enabled})
			}
			Array.from(fix_encoding_input).forEach(function(e) {e.addEventListener('input', fix_encoding_subopts)})
			fix_encoding_subopts()
		</script>
		% if piwik:
			script(type="text/javascript").
				var pkBaseURL = (("https:" == document.location.protocol) ? "https://analytics.linestarve.com/" : "http://analytics.linestarve.com/");
				document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
			script(type="text/javascript").
				try {
				var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
				piwikTracker.trackPageView();
				piwikTracker.enableLinkTracking();
				} catch( err ) {}
			<noscript><p><img src="https://analytics.linestarve.com/piwik.php?idsite=1&rec=1" style="border:0" alt="" /></p></noscript>
		% end
	</body>
</html>
