import funkin.editors.ui.UITopMenu;
import funkin.editors.ui.UIState;
import funkin.editors.ui.UIDropDown;
import funkin.editors.ui.UISlider;
import funkin.editors.EditorTreeMenu;

// VARIABLES
var topMenuSpr:UITopMenu;
//slider vars
var topMaskR:UISlider = null;
var topMaskG:UISlider = null;
var topMaskB:UISlider = null;
var topMaskA:UISlider = null;
var spriteColR:UISlider = null;
var spriteColG:UISlider = null;
var spriteColB:UISlider = null;
var spriteColA:UISlider = null;
var lightColR:UISlider = null;
var lightColG:UISlider = null;
var lightColB:UISlider = null;
var lightColA:UISlider = null;
var lightnalge:UISlider = null;
var lightSize:UISlider = null;
var numOfLay:UISlider = null;
var laySepa:UISlider = null;
var bff:FlxSprite = null;

// Shader Variables
var shaderParms = {
	//  Top mas color
	mask_Color_R: 0,
	mask_Color_G: 0,
	mask_Color_B: 0,
	mask_Color_A: 0,
	//  Sprite color
	sprite_Color_R: 0,
	sprite_Color_G: 0,
	sprite_Color_B: 0,
	sprite_Color_A: 0,
	// Light Color
	light_Color_R: 0,
	light_Color_G: 0,
	light_Color_B: 0,
	light_Color_A: 0,
	// light extra values
	light_Angle: 0,
	light_Size: 0,
	number_Of_Layers: 0,
	layer_Separation: 0
}



var topMenu = [
	{
		label: "Exit",
		childs: [{label: "Leave",
				onSelect: () -> FlxG.switchState(new EditorTreeMenu(null, true, "no")) }]
	},{
		label: "Shader",
		childs: [
			{ label: "Load shader", onSelect: () -> trace("hi") },
			{ label: "Import from", onSelect: () -> trace("hi") },
			{ label: "Save shader as", onSelect: () -> trace("hi") },
			{ label: "Make script", onSelect: () -> trace("hi") }]
	},{
		label: "Character",
		childs: [
			{ label: "BF", onSelect: () -> loadCharacter("bf", 0) },
			{ label: "Dad", onSelect: () -> loadCharacter("Dad", 1) },
			{ label: "Spooky Kids", onSelect: () -> loadCharacter("Spooky Kids", 2) },
			{ label: "Pico", onSelect: () -> loadCharacter("Pico", 3) },
			{ label: "Mom", onSelect: () -> loadCharacter("Mom", 4) },
			{ label: "Tankman", onSelect: () -> loadCharacter("Tankman", 5) }]
	},{
		label: "HUD",
		childs: [
			{ label: "Hide HUD", onSelect: () -> trace("hi") },
			{ label: "Show HUD", onSelect: () -> trace("hi") }]
	},{
    label: "Edit",
    childs: [
        {
            label: "Top Mask Color",
            onSelect: () -> {
                for (s in [topMaskR,topMaskG,topMaskB,topMaskA,spriteColR,spriteColG,spriteColB,spriteColA,lightColR,lightColG,lightColB,lightColA,lightnalge,lightSize,numOfLay,laySepa])
                    if (s != null) { s.visible = false; s.active = false; }

                for (s in [topMaskR, topMaskG, topMaskB, topMaskA])
                    if (s != null) { s.visible = true; s.active = true; }
            }
        },
        {
            label: "Sprite Color",
            onSelect: () -> {
                for (s in [topMaskR,topMaskG,topMaskB,topMaskA,spriteColR,spriteColG,spriteColB,spriteColA,lightColR,lightColG,lightColB,lightColA,lightnalge,lightSize,numOfLay,laySepa])
                    if (s != null) { s.visible = false; s.active = false; }

                for (s in [spriteColR, spriteColG, spriteColB, spriteColA])
                    if (s != null) { s.visible = true; s.active = true; }
            }
        },
        {
            label: "Light Color",
            onSelect: () -> {
                for (s in [topMaskR,topMaskG,topMaskB,topMaskA,spriteColR,spriteColG,spriteColB,spriteColA,lightColR,lightColG,lightColB,lightColA,lightnalge,lightSize,numOfLay,laySepa])
                    if (s != null) { s.visible = false; s.active = false; }

                for (s in [lightColR, lightColG, lightColB, lightColA])
                    if (s != null) { s.visible = true; s.active = true; }
            }
        },
        {
            label: "Light Parameters",
            onSelect: () -> {
                for (s in [topMaskR,topMaskG,topMaskB,topMaskA,spriteColR,spriteColG,spriteColB,spriteColA,lightColR,lightColG,lightColB,lightColA,lightnalge,lightSize,numOfLay,laySepa])
                    if (s != null) { s.visible = false; s.active = false; }

                for (s in [lightnalge, lightSize, numOfLay, laySepa])
                    if (s != null) { s.visible = true; s.active = true; }
            }
        }
    ]
}
,{
    label: "Reset",
    childs: [
        {
            label: "Reset Top Mask Color",
            onSelect: () -> {
                var campos = ["mask_Color_R", "mask_Color_G", "mask_Color_B", "mask_Color_A"];
                var sliders = [topMaskR, topMaskG, topMaskB, topMaskA];
                for (i in 0...campos.length) {
                    Reflect.setField(shaderParms, campos[i], 0);
                    if (sliders[i] != null) sliders[i].value = 0;
                }
            }
        },
        {
            label: "Reset Sprite Color",
            onSelect: () -> {
                var campos = ["sprite_Color_R", "sprite_Color_G", "sprite_Color_B", "sprite_Color_A"];
                var sliders = [spriteColR, spriteColG, spriteColB, spriteColA];
                for (i in 0...campos.length) {
                    Reflect.setField(shaderParms, campos[i], 0);
                    if (sliders[i] != null) sliders[i].value = 0;
                }
            }
        },
        {
            label: "Reset Light Color",
            onSelect: () -> {
                var campos = ["light_Color_R", "light_Color_G", "light_Color_B", "light_Color_A"];
                var sliders = [lightColR, lightColG, lightColB, lightColA];
                for (i in 0...campos.length) {
                    Reflect.setField(shaderParms, campos[i], 0);
                    if (sliders[i] != null) sliders[i].value = 0;
                }
            }
        },
        {
            label: "Reset Light Parameters",
            onSelect: () -> {
                var campos = ["light_Angle", "light_Size", "number_Of_Layers", "layer_Separation"];
                var sliders = [lightnalge, lightSize, numOfLay, laySepa];
                for (i in 0...campos.length) {
                    Reflect.setField(shaderParms, campos[i], 0);
                    if (sliders[i] != null) sliders[i].value = 0;
                }
            }
        },
        {
            label: "Reset ALL",
            onSelect: () -> {
                // Top Mask
                var campos = ["mask_Color_R","mask_Color_G","mask_Color_B","mask_Color_A",
                              "sprite_Color_R","sprite_Color_G","sprite_Color_B","sprite_Color_A",
                              "light_Color_R","light_Color_G","light_Color_B","light_Color_A",
                              "light_Angle","light_Size","number_Of_Layers","layer_Separation"];
                var sliders = [topMaskR, topMaskG, topMaskB, topMaskA,
                               spriteColR, spriteColG, spriteColB, spriteColA,
                               lightColR, lightColG, lightColB, lightColA,
                               lightnalge, lightSize, numOfLay, laySepa];
                for (i in 0...campos.length) {
                    Reflect.setField(shaderParms, campos[i], 0);
                    if (sliders[i] != null) sliders[i].value = 0;
                }
            }
        }
    ]
}
];


// MAKE SLIDER FUNC
function makeUISlider(x:Float, y:Float, width:Int, value:Float, min:Float, max:Float, onChange:Float->Void, centered:Bool = false):UISlider {
	var segs = [{start: min, end: max, size: 1}];
	var slider = new UISlider(x, y, width, value, segs, centered);
	slider.startText.text = "";
	slider.endText.text = "";
	slider.valueStepper.visible = true;
	slider.valueStepper.active = true;
	slider.onChange = onChange;
	return slider;}













//
// POST CREATE
//
function postCreate(){

	//BG
	var stge:FlxSprite = new FlxSprite(0, 0);
	stge.loadGraphic(Paths.image("menuEditors"));
	stge.camera = FlxG.camera;
	add(stge);

	//UP BAR
	topMenuSpr = new UITopMenu(topMenu);
	topMenuSpr.cameras = FlxG.camera;
	add(topMenuSpr);

	//CHARACTER
	bff = new FlxSprite(700, 200);
	bff.camera = FlxG.camera;
	add(bff);
	loadCharacter("bf", 0); 
	bff.shader = new CustomShader("RTXLighting");
	bff.shader.overlayColor = [0, 0, 0, 0];
	bff.shader.satinColor = [0, 0, 0, 0];
	bff.shader.innerShadowColor = [1, 0, 0, 1];
	bff.shader.innerShadowAngle = (shaderParms.nalge - 90) * Math.PI / 180;
	bff.shader.innerShadowDistance = 10;
	bff.shader.layernumbers = 5;
	bff.shader.layerseparation = 1;



	//
	//x, y, width, value, min, max, onChange, centered
	//
	// TOP MASK COLOR SLIDERS
	topMaskA = makeUISlider(100, 200, 350, 0, -1, 1, function(val:Float) {
	shaderParms.mask_Color_A = val; });
	topMaskA.camera = FlxG.camera;
	add(topMaskA);
	topMaskA.visible = true;
	//
	topMaskR = makeUISlider(100, 300, 350, 0, 0, 1, function(val:Float) {
	shaderParms.mask_Color_R = val; });
	topMaskR.camera = FlxG.camera;
	add(topMaskR);
	topMaskR.visible = true;
	//
	topMaskG = makeUISlider(100, 400, 350, 0, 0, 1, function(val:Float) {
	shaderParms.mask_Color_G = val; });
	topMaskG.camera = FlxG.camera;
	add(topMaskG);
	topMaskG.visible = true;
	//
	topMaskB = makeUISlider(100, 500, 350, 0, 0, 1, function(val:Float) {
	shaderParms.mask_Color_B = val; });
	topMaskB.camera = FlxG.camera;
	add(topMaskB);
	topMaskB.visible = true;
	//
	//
	//
	spriteColA = makeUISlider(100, 200, 350, 0, -1, 1, function(val:Float) {
	shaderParms.sprite_Color_A = val; });
	spriteColA.camera = FlxG.camera;
	add(spriteColA);
	spriteColA.visible = false;
	//
	spriteColR = makeUISlider(100, 300, 350, 0, 0, 1, function(val:Float) {
	shaderParms.sprite_Color_R = val; });
	spriteColR.camera = FlxG.camera;
	add(spriteColR);
	spriteColR.visible = false;
	//
	spriteColG = makeUISlider(100, 400, 350, 0, 0, 1, function(val:Float) {
	shaderParms.sprite_Color_G = val; });
	spriteColG.camera = FlxG.camera;
	add(spriteColG);
	spriteColG.visible = false;
	//
	spriteColB = makeUISlider(100, 500, 350, 0, 0, 1, function(val:Float) {
	shaderParms.sprite_Color_B = val; });
	spriteColB.camera = FlxG.camera;
	add(spriteColB);
	spriteColB.visible = false;
	//
	//
	//
	//
	lightColA = makeUISlider(100, 200, 350, 0, -1, 1, function(val:Float) {
	shaderParms.light_Color_A = val; });
	lightColA.camera = FlxG.camera;
	add(lightColA);
	lightColA.visible = false;
	//
	lightColR = makeUISlider(100, 300, 350, 0, 0, 1, function(val:Float) {
	shaderParms.light_Color_R = val; });
	lightColR.camera = FlxG.camera;
	add(lightColR);
	lightColR.visible = false;
	//
	lightColG = makeUISlider(100, 400, 350, 0, 0, 1, function(val:Float) {
	shaderParms.light_Color_G = val; });
	lightColG.camera = FlxG.camera;
	add(lightColG);
	lightColG.visible = false;
	//
	lightColB = makeUISlider(100, 500, 350, 0, 0, 1, function(val:Float) {
	shaderParms.light_Color_B = val; });
	lightColB.camera = FlxG.camera;
	add(lightColB);
	lightColB.visible = false;
	//
	//
	//

	lightnalge = makeUISlider(100, 200, 350, 0, 0, 360, function(val:Float) {
	shaderParms.light_Angle = val; });
	lightnalge.camera = FlxG.camera;
	add(lightnalge);
	lightnalge.visible = false;

	lightSize = makeUISlider(100, 300, 350, 0, 0, 100, function(val:Float) {
	shaderParms.light_Size = val; });
	lightSize.camera = FlxG.camera;
	add(lightSize);
	lightSize.visible = false;

	numOfLay = makeUISlider(100, 400, 350, 0, 0, 100, function(val:Float) {
	shaderParms.number_Of_Layers = val; });
	numOfLay.camera = FlxG.camera;
	add(numOfLay);
	numOfLay.visible = false;

	laySepa = makeUISlider(100, 500, 350, 0, 0, 100, function(val:Float) {
	shaderParms.layer_Separation = val; });
	laySepa.camera = FlxG.camera;
	add(laySepa);
	laySepa.visible = false;

}


//
// LOAD CHARACTER
//
function loadCharacter(charKey:String, index:Int){
	if (bff == null) return;
	bff.loadGraphic(Paths.image('chars/$charKey'));
	bff.frames = Paths.getSparrowAtlas('chars/' + charKey);
	bff.animation.addByPrefix('idle', 'idle0', 16, true);
	bff.animation.addByPrefix('up', 'up0', 16, false);
	bff.animation.addByPrefix('left', 'left0', 16, false);
	bff.animation.addByPrefix('down', 'down0', 16, false);
	bff.animation.addByPrefix('right', 'right0', 16, false);
	bff.animation.play('idle');
	if (index == 1 || index == 4) bff.scale.set(0.75, 0.75);
	else bff.scale.set(1, 1);} 



//
// POST UPDATE
//
function postUpdate(elapsed:Float):Void {


	// Aply and uptade the shader
	bff.shader.overlayColor = [
		shaderParms.mask_Color_R,
		shaderParms.mask_Color_G,
		shaderParms.mask_Color_B,
		shaderParms.mask_Color_A ];
	bff.shader.satinColor = [
		shaderParms.sprite_Color_R,
		shaderParms.sprite_Color_G,
		shaderParms.sprite_Color_B,
		shaderParms.sprite_Color_A ];
	bff.shader.innerShadowColor = [
		shaderParms.light_Color_R,
		shaderParms.light_Color_G,
		shaderParms.light_Color_B,
		shaderParms.light_Color_A ];
	bff.shader.innerShadowAngle = (shaderParms.light_Angle - 90) * Math.PI / 180;
	bff.shader.innerShadowDistance = shaderParms.light_Size;
	bff.shader.layernumbers = shaderParms.number_Of_Layers;
	bff.shader.layerseparation = shaderParms.layer_Separation;

//
// PLAY CHAR ANIMS
//
var animationTimer:FlxTimer = null;
function playAnimationWithTimer(animName:String):Void {
    if (animationTimer != null) animationTimer.cancel();
    bff.animation.play(animName);
    animationTimer = new FlxTimer().start(1, function(tmr:FlxTimer) {
        bff.animation.play('idle');
        animationTimer = null; 	});}

if (FlxG.keys.pressed.A) playAnimationWithTimer('left');
else if (FlxG.keys.pressed.S) playAnimationWithTimer('down');
else if (FlxG.keys.pressed.D) playAnimationWithTimer('right');
else if (FlxG.keys.pressed.W) playAnimationWithTimer('up');


//
// MOVE CHARACTER
//
	var speed:Float = 200;
	var mult:Float = FlxG.keys.pressed.SHIFT ? 3 : 1;
	bff.drag.set(1000 - (FlxG.save.data.slide * 100), 1000 - (FlxG.save.data.slide * 100));
	var vx = 0.0;
	var vy = 0.0;
	if (FlxG.keys.pressed.LEFT)
		vx -= speed * mult;
	if (FlxG.keys.pressed.RIGHT)
		vx += speed * mult;
	if (FlxG.keys.pressed.UP)
		vy -= speed * mult;
	if (FlxG.keys.pressed.DOWN)
		vy += speed * mult;
	if (vx != 0 || vy != 0) {
		bff.velocity.set(vx, vy);
	}

}