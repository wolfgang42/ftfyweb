<!DOCTYPE html>
<html><head>
	<meta charset="utf-8">
	<title>Mojibake Decoder</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.2/css/bulma.css" integrity="sha256-tzp6mtxeugpv7nF5uY4rqr1ZxZynL8F7G5MCwYxJkmY=" crossorigin="anonymous" />
	<style>
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
</head><body>
	<header class="hero is-primary is-bold">
		<div class="hero-body"><h1>
			<div class="title">Mojibake Decoder</title>
			<!--div class="subtitle">L&amp;amp;Atilde;&amp;amp;sup3;pez?</div-->
		</h1></div>
	</header>
	<main class="section container content">
		<form method="GET">
			<label class="label" for="mojibake">Mojibake:</label>
			<div class="field has-addons">
				<p class="control is-expanded">
					<input type="text" class="input" name="mojibake" value="{{mojibake}}"/>
				</p>
				<p class="control">
					<input type="submit" class="button is-primary" value="Decode"/>
				</p>
			</div>
		</form>
		% if decoded:
			<strong>Decoded:</strong>
			<div class="result">{{decoded}}</div>
		% end
	</main>
	<footer class="footer"><div class="container"><div class="content has-text-centered">
		Built by <a href="https://www.linestarve.com/">Wolfgang Faust</a> &bull;
		<a href="https://github.com/wolfgang42/ftfyweb"><img width="16" height="16" alt="GitHub:" style="vertical-align:middle;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABAAQMAAACQp+OdAAAABlBMVEUAAAAAAAClZ7nPAAAAAXRSTlMAQObYZgAAAMxJREFUKFOt0rFtBCEURdE7IiCkBEqhNCZzWyO5EbYDNiNAXAesPCvboYmOxH/iIQDIAwCCXgAk7QBUXQCovkb2UFRtQFYdQFGdO7RjumPHxnkjrKKzXsSVtNVGXEGv2kgToHTyD4wbZQHUeaPurfWGAZDfsO+UvuE/I4vjhfv038V250URwEnxguAk2yE5yB8LqoP86RW0kx6eh3bi0/PQRuyCNsIooBfHAPTkmC+wnwGogAsoD3Dulrt4FGxAEPYPEIQdmwAk6PyxvgA2bdfnuuNAlAAAAABJRU5ErkJggg=="> wolfgang42/ftfyweb</a>
		<div style="padding-top:.5em;">Powered by <a href="https://ftfy.readthedocs.io/en/latest/">ftfy</a></div>
	</div></div></footer>
</body></html>
