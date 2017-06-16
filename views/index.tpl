<!DOCTYPE html>
<html><head>
	<meta charset="utf-8">
	<title>Mojibake Decoder</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.3.1/css/bulma.css" integrity="sha256-E3NFAdoEdCZvMUGANNJ8cM/gRzIO+9Tx9QGCCzYHquw=" crossorigin="anonymous">
</head><body>
	<header class="hero is-primary is-bold">
		<div class="hero-body"><h1>
			<div class="title">Mojibake decoder</title>
			<!--div class="subtitle">L&amp;amp;Atilde;&amp;amp;sup3;pez?</div-->
		</h1></div>
	</header>
	<main class="section container content">
		<form method="GET">
			<div class="field"><div class="control">
				<input type="text" class="input" name="mojibake" value="{{mojibake}}"/>
			</div></div>
			<div class="field"><div class="control">
				 <input type="submit" class="button is-primary" value="Decode"/>
			</div></div>
		</form>
		% if decoded:
			<pre>{{decoded}}</pre>
		% end
	</main>
</body></html>

