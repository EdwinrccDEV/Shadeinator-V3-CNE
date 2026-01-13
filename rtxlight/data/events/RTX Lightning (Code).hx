var char = null;

var overlay = null;
var satin = null;
var light = null;
var angle = null;
var distance = null;
var layers = null;
var separation = null;

function onEvent(event) {
    if (event.event.name != "RTX Lightning (Code)") return;

    var execute = event.event.params[0];
    var removeShader = event.event.params[1];
    var strumLineIndex = event.event.params[2];
    var mode = event.event.params[3]; 
    var charIndex = event.event.params[4];
    var shaderCode = event.event.params[5];

    if (!execute) return;

    var values = shaderCode
        .split(",")
        .map(s -> Std.parseFloat(s));

    if (values.length < 16) {
        trace("ERROR: ShaderCode necesita 16 valores.");
        return;
    }

    overlay = values.slice(0, 4);
    satin = values.slice(4, 8);
    light = values.slice(8, 12);
    angle = values[12];
    distance = Std.int(values[13]);
    layers = Std.int(values[14]);
    separation = Std.int(values[15]);

    if (removeShader) {
        overlay = [0, 0, 0, 0];
        satin = [0, 0, 0, 0];
        light = [0, 0, 0, 0];
        angle = 0;
        distance = 1;
        layers = 1;
        separation = 1;
    }

    var characters = strumLines.members[strumLineIndex].characters;

    if (mode == "All in strumline") {

        var curr = 0;
        while (curr < characters.length) {
            applyShader(characters[curr], angle, overlay, satin, light, distance, layers, separation);
            curr++;
        }
    } else {
        
        if (charIndex < characters.length) {
            applyShader(characters[charIndex], angle, overlay, satin, light, distance, layers, separation);
        }
    }
}

inline function applyShader(
    char,
    angle:Float,
    overlay:Array<Float>,
    satin:Array<Float>,
    light:Array<Float>,
    distance:Int,
    layers:Int,
    separation:Int
) {
    char.shader = new CustomShader("RTXLighting");
    char.shader.overlayColor = overlay;
    char.shader.satinColor = satin;
    char.shader.innerShadowColor = light;

var fixedAngle = (angle - char.angle);

if (char.flipX)
    fixedAngle = 360 - fixedAngle;

if (char.flipY)
    fixedAngle = 180 - fixedAngle;

char.shader.innerShadowAngle = (fixedAngle - 90) * Math.PI / 180;


    char.shader.innerShadowDistance = distance;
    char.shader.layernumbers = layers;
    char.shader.layerseparation = separation;
}
