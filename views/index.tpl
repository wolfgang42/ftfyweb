<!DOCTYPE html>
<html><head>
	<title>Mojibake Decoder</title>
</head><body>
	<form method="POST">
		<textarea name="mojibake"></textarea>
		<input type="submit" value="Decode"/>
	</form>
	% if decoded:
		<pre>{{decoded}}</pre>
	% end
</body></html>

