function onEvent(event) {
	if (event.event.name == "Rtx lightning") {
		if (!event.event.params[0]) return;

		inline function randomColor():Array<Float> {
			return [for (i in 0...4) Math.fround((Math.random() * 2 - 1) * 100) / 100];
		}

		var msk:Array<Float>;
		var sat:Array<Float>;
		var lght:Array<Float>;
		var angl:Float;
		var lghtsz:Int;
		var numly:Int;
		var lysep:Int;

		// ---------------- REMOVE SHADER ----------------
		if (event.event.params[2]) {
			msk = [0, 0, 0, 0];
			sat = [0, 0, 0, 0];
			lght = [0, 0, 0, 0];
			angl = 0;
			lghtsz = 1;
			numly = 1;
			lysep = 1;
		}
		// ---------------- RANDOM ----------------
		else if (event.event.params[1]) {
			msk = randomColor();
			sat = randomColor();
			lght = randomColor();
			angl = Math.floor(Math.random() * 360);
			lghtsz = Math.floor(Math.random() * 20) + 1;
			numly = Math.floor(Math.random() * 10) + 1;
			lysep = Math.floor(Math.random() * 5) + 1;

			trace("\n\n - - -[[ RANDOM SHADER VALUES ]] - - - ");
			trace("Top Mask Color :" + msk);
			trace("Sprite Color :" + sat);
			trace("Light Color :" + lght);
			trace("Light Angle :" + angl);
			trace("Light Size :" + lghtsz);
			trace("Layer Count :" + numly);
			trace("Layer Spacing :" + lysep);
			trace("\n\n");
		}
		// ---------------- MANUAL ----------------
		else {
			msk = event.event.params[6].split(",").map(s -> Std.parseFloat(s));
			sat = event.event.params[7].split(",").map(s -> Std.parseFloat(s));
			lght = event.event.params[8].split(",").map(s -> Std.parseFloat(s));
			angl = event.event.params[9];
			lghtsz = event.event.params[10];
			numly = event.event.params[11];
			lysep = event.event.params[12];
		}

		var strum = event.event.params[3];
		var mode = event.event.params[4];

		// ================= APPLY =================
		if (mode == "All in strumline") {

			var currnum = 0;
			var char = strumLines.members[strum].characters[currnum];

			while (char != null) {
				applyShader(char, angl, msk, sat, lght, lghtsz, numly, lysep);
				currnum++;
				char = strumLines.members[strum].characters[currnum];
			}

		} else { 

			var idx = event.event.params[5];
			var char = strumLines.members[strum].characters[idx];
			if (char != null) {
				applyShader(char, angl, msk, sat, lght, lghtsz, numly, lysep);
			}
		}
	}
}

inline function applyShader(
	char,
	angl:Float,
	msk:Array<Float>,
	sat:Array<Float>,
	lght:Array<Float>,
	lghtsz:Int,
	numly:Int,
	lysep:Int
) {
	char.shader = new CustomShader("RTXLighting");
	char.shader.overlayColor = msk;
	char.shader.satinColor = sat;
	char.shader.innerShadowColor = lght;

var fixedAngle = (angl - char.angle);

if (char.flipX)
    fixedAngle = 360 - fixedAngle;

if (char.flipY)
    fixedAngle = 180 - fixedAngle;

char.shader.innerShadowAngle = (fixedAngle - 90) * Math.PI / 180;

	char.shader.innerShadowDistance = lghtsz;
	char.shader.layernumbers = numly;
	char.shader.layerseparation = lysep;
}
