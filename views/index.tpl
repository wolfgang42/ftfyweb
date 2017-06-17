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
</body></html>

