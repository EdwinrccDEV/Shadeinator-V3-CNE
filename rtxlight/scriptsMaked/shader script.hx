var strums = [0, 1, 2];
var chars = [0, 0, 0];

function postCreate() {
	for (i in 0...strums.length) {
		var sprite = strumLines.members[strums[i]].characters[chars[i]];
		
		if (sprite.animateAtlas != null) {
			sprite.useRenderTexture = true;
		}
		
		sprite.shader = new CustomShader("RTXLighting");
		sprite.shader.overlayColor = [0, 0, 0, 0];
		sprite.shader.satinColor = [0.21, 0.18, 0.18, 0.54];
		sprite.shader.innerShadowColor = [0.93, 0.51, 0, 0.2];
		
		var fixedAngle = (325 - sprite.angle);
		if (sprite.flipX) fixedAngle = 360 - fixedAngle;
		if (sprite.flipY) fixedAngle = 180 - fixedAngle;
		
		sprite.shader.innerShadowAngle = (fixedAngle - 90) * Math.PI / 180;
		sprite.shader.innerShadowDistance = 14;
		sprite.shader.layernumbers = 19;
		sprite.shader.layerseparation = 3;
	}
}
