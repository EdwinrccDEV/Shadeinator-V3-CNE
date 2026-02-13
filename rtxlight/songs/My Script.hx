import sys.io.File;

if (FlxG.save.data.livepre) { 

function postCreate() {

	var liveprev = new FunkinText(150, 600, 1000, "{[ LIVE PREVIEW ON ]}", 30);
	liveprev.alignment = "center";
	liveprev.cameras = [camHUD];
	add(liveprev);

	new FlxTimer().start(0.5, function(timer:FlxTimer){
	var shaderData = parseShaderData("assets/data/test.txt");
	
	var i = 0;
	while (i < strumLines.members.length && strumLines.members[i].characters[0] != null) {
		var sprite = strumLines.members[i].characters[0];
		
		sprite.shader = new CustomShader("RTXLighting");
		sprite.shader.overlayColor = [shaderData[0], shaderData[1], shaderData[2], shaderData[3]];
		sprite.shader.satinColor = [shaderData[4], shaderData[5], shaderData[6], shaderData[7]];
		sprite.shader.innerShadowColor = [shaderData[8], shaderData[9], shaderData[10], shaderData[11]];
		
		var fixedAngle = (shaderData[12] - sprite.angle);
		if (sprite.flipX) fixedAngle = 360 - fixedAngle;
		if (sprite.flipY) fixedAngle = 180 - fixedAngle;
		
		sprite.shader.innerShadowAngle = (fixedAngle - 90) * Math.PI / 180;
		sprite.shader.innerShadowDistance = shaderData[13];
		sprite.shader.layernumbers = Std.int(shaderData[14]);
		sprite.shader.layerseparation = shaderData[15];
		
		i++;
	}
	}, 0);
}

function parseShaderData(path:String):Array<Float> {
	var rawContent = Assets.getText(path);
	
	var raw:Array<Float> = rawContent.split(",")
		.map(StringTools.trim)
		.filter(s -> s.length > 0)
		.map(Std.parseFloat);
	
	return raw;
}
}