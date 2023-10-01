<!DOCTYPE html>
<html>
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
			<div class="hero-body">
				<div class="container">
					<h1><div class="title">Mojibake Decoder</div></h1>
				</div>
			</div>
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

					TODO continue from here

				</details>
			</form>
		</main>
	</body>
</html>
