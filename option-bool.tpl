<div class="field is-horizontal">
	<div class="field-label"><label class="label">{{name}}</label></div>
	<div class="field-body">
		<div class="field is-narrow"><div class="control">
			<label class="radio">
				<input type="radio" name="{{code}}" value="True" {{checkedif(options[code])}}> Yes
			</label>
			<label class="radio">
				<input type="radio" name="{{code}}" value="False" {{checkedif(not options[code])}}> No
			</label>
			<div class="help">{{!help}}</div>
		</div></div>
	</div>
</div>
