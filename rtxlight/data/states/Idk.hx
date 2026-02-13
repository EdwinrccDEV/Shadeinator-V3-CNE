import funkin.editors.ui.UITopMenu;
import funkin.editors.ui.UIState;
import funkin.editors.ui.UIDropDown;
import funkin.editors.ui.UISlider;
import funkin.editors.EditorTreeMenu;
import sys.FileSystem;
import sys.io.File;
import funkin.backend.utils.DiscordUtil;
import funkin.editors.ui.UIFileExplorer;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.notifications.UIBaseNotification;
import StringTools;
import Sys;
import flixel.input.keyboard.FlxKey;
import Reflect;

// Top menu
var topMenuSpr:UITopMenu;

// slider vars
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

// Other
var bff:FlxSprite = null;
var editinn = null;
var slide1 = null;
var slide2 = null;
var slide3 = null;
var slide4 = null;
var flecha:FlxSprite;
var distcn = null;
var verde = null;
var popup = null;
var substate:UISubstateWindow;
var subdelete:UISubstateWindow;
var subscript:UISubstateWindow;
var importing:UISubstateWindow;
var waitingForPreset:Bool = false;
var waitingForDelete:Bool = false;
var waitingForScript:Bool = false;
var resetkey = "R";
var editkey = "E";

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

var codenumber = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";

function makescript(strums:Array<Int>, chars:Array<Int>, file:String) {
	var nombre = "mi_shader_script";
	var round = true;
	var val = (v:Float) -> if (round) Math.round(v * 100) / 100 else v;
	var contenido = "";

	contenido += "var strums = [" + strums.join(", ") + "];\n";
	contenido += "var chars = [" + chars.join(", ") + "];\n\n";

	contenido += "function postCreate() {\n";
	contenido += "\tfor (i in 0...strums.length) {\n";
	contenido += "\t\tvar sprite = strumLines.members[strums[i]].characters[chars[i]];\n";
	contenido += "\t\t\n";
	contenido += "\t\tsprite.shader = new CustomShader(\"RTXLighting\");\n";
	contenido += "\t\tsprite.shader.overlayColor = [" + val(shaderParms.mask_Color_R) + ", " + val(shaderParms.mask_Color_G) + ", "
		+ val(shaderParms.mask_Color_B) + ", " + val(shaderParms.mask_Color_A) + "];\n";
	contenido += "\t\tsprite.shader.satinColor = [" + val(shaderParms.sprite_Color_R) + ", " + val(shaderParms.sprite_Color_G) + ", "
		+ val(shaderParms.sprite_Color_B) + ", " + val(shaderParms.sprite_Color_A) + "];\n";
	contenido += "\t\tsprite.shader.innerShadowColor = [" + val(shaderParms.light_Color_R) + ", " + val(shaderParms.light_Color_G) + ", "
		+ val(shaderParms.light_Color_B) + ", " + val(shaderParms.light_Color_A) + "];\n";
	contenido += "\t\t\n";
	contenido += "\t\tvar fixedAngle = (" + val(shaderParms.light_Angle) + " - sprite.angle);\n";
	contenido += "\t\tif (sprite.flipX) fixedAngle = 360 - fixedAngle;\n";
	contenido += "\t\tif (sprite.flipY) fixedAngle = 180 - fixedAngle;\n";
	contenido += "\t\t\n";
	contenido += "\t\tsprite.shader.innerShadowAngle = (fixedAngle - 90) * Math.PI / 180;\n";
	contenido += "\t\tsprite.shader.innerShadowDistance = " + val(shaderParms.light_Size) + ";\n";
	contenido += "\t\tsprite.shader.layernumbers = " + val(shaderParms.number_Of_Layers) + ";\n";
	contenido += "\t\tsprite.shader.layerseparation = " + val(shaderParms.layer_Separation) + ";\n";
	contenido += "\t}\n";
	contenido += "}\n";

	File.saveContent("addons/rtxlight/scripts maked/" + file + ".hx", contenido);
}

function resetFields(campos:Array<String>, sliders:Array<Dynamic>):Void {
	for (i in 0...campos.length) {
		Reflect.setField(shaderParms, campos[i], 0);
		if (sliders[i] != null)
			sliders[i].value = 0;
	}
}

function resetTopMaskColor():Void {
	var campos = ["mask_Color_R", "mask_Color_G", "mask_Color_B", "mask_Color_A"];
	var sliders = [topMaskR, topMaskG, topMaskB, topMaskA];
	resetFields(campos, sliders);
}

function resetSpriteColor():Void {
	var campos = ["sprite_Color_R", "sprite_Color_G", "sprite_Color_B", "sprite_Color_A"];
	var sliders = [spriteColR, spriteColG, spriteColB, spriteColA];
	resetFields(campos, sliders);
}

function resetLightColor():Void {
	var campos = ["light_Color_R", "light_Color_G", "light_Color_B", "light_Color_A"];
	var sliders = [lightColR, lightColG, lightColB, lightColA];
	resetFields(campos, sliders);
}

function resetLightParameters():Void {
	var campos = ["light_Angle", "light_Size", "number_Of_Layers", "layer_Separation"];
	var sliders = [lightnalge, lightSize, numOfLay, laySepa];
	resetFields(campos, sliders);
}

function resetAll():Void {
	resetTopMaskColor();
	resetSpriteColor();
	resetLightColor();
	resetLightParameters();
}

function getAllSliders():Array<Dynamic> {
	return [
		  topMaskR,   topMaskG,   topMaskB,   topMaskA,
		spriteColR, spriteColG, spriteColB, spriteColA,
		 lightColR,  lightColG,  lightColB,  lightColA,
		lightnalge,  lightSize,   numOfLay,    laySepa
	];
}

function hideAllSliders():Void {
	for (s in getAllSliders()) {
		if (s != null) {
			s.visible = false;
			s.active = false;
		}
	}
}

function showSliders(sliders:Array<Dynamic>):Void {
	for (s in sliders) {
		if (s != null) {
			s.visible = true;
			s.active = true;
		}
	}
}

function updateSlideLabels(label1:String, label2:String, label3:String, label4:String):Void {
	slide1.text = label1;
	slide2.text = label2;
	slide3.text = label3;
	slide4.text = label4;
}

function switchEditMode(sliders:Array<Dynamic>, title:String, labels:Array<String>):Void {
	hideAllSliders();
	showSliders(sliders);
	editinn.text = title;
	updateSlideLabels(labels[0], labels[1], labels[2], labels[3]);
}

function editTopMaskColor():Void {
	switchEditMode([topMaskR, topMaskG, topMaskB, topMaskA], "Editing Top Mask Color", ["Alpha", "Red", "Green", "Blue"]);
}

function editSpriteColor():Void {
	switchEditMode([spriteColR, spriteColG, spriteColB, spriteColA], "Editing Sprite Color", ["Alpha", "Red", "Green", "Blue"]);
}

function editLightColor():Void {
	switchEditMode([lightColR, lightColG, lightColB, lightColA], "Editing Light Color", ["Alpha", "Red", "Green", "Blue"]);
}

function editLightParameters():Void {
	switchEditMode([lightnalge, lightSize, numOfLay, laySepa], "Light Parameters", ["Angle", "Size", "Layer Count", "Layer Spacing"]);
}

var topMenu = [
	{
		label: "Exit",
		childs: [
			{
				label: "Leave",
				onSelect: () -> {
					File.saveContent("addons/rtxlight/other/rembem.txt", codenumber);
					FlxG.switchState(new EditorTreeMenu(null, true, "no"));
				}
			},
			null,
			{
				label: "Reload State",
				onSelect: () -> {
					File.saveContent("addons/rtxlight/other/rembem.txt", codenumber);
					FlxG.switchState(new UIState(true, "Idk"));
				}
			}
		]
	},
	{
		label: "Shader",
		childs: [
			{
				label: "Load shader",
				onSelect: function() {
					substate = new UISubstateWindow(true, 'loadPreset');
					substate.winTitle = 'Load Preset';
					substate.winWidth = 420;
					substate.winHeight = 220;
					FlxG.state.openSubState(substate);
					// trace(substate);
					waitingForPreset = true;
				}
			},
			{
				label: "Import from",
				onSelect: function() {
					importing = new UISubstateWindow(true, 'importfrom');
					importing.winTitle = 'Import From';
					importing.winWidth = 800;
					importing.winHeight = 400;
					FlxG.state.openSubState(importing);
				}
			},
			{
				label: "Save shader as",
				onSelect: function() {
					File.saveContent("addons/rtxlight/other/saveAs.txt", codenumber);
					var susstate = new UISubstateWindow(true, 'saveAs');
					susstate.winTitle = 'Save Shader as';
					susstate.winWidth = 420;
					susstate.winHeight = 220;
					FlxG.state.openSubState(susstate);
				}
			},
			{
				label: "Delete shader",
				onSelect: function() {
					subdelete = new UISubstateWindow(true, 'deletp');
					subdelete.winTitle = 'Delete preset';
					subdelete.winWidth = 420;
					subdelete.winHeight = 220;
					FlxG.state.openSubState(subdelete);
					waitingForDelete = true;
				}
			},
						{
				label: "Make script",
				onSelect: () -> {
					subscript = new UISubstateWindow(true, 'makeScr');
					subscript.winTitle = 'Make Script';
					subscript.winWidth = 700;
					subscript.winHeight = 220;
					FlxG.state.openSubState(subscript);
					waitingForScript = true;
				}
			},
			null,
			{label: "Event Parameters (USE SCRIPT AND CODE EVENT)", onSelect: () -> trace("hi")},
			{label: "Export Spritesheet with shader (JOKE)", onSelect: () -> trace("hi")}
		]
	},
	{
		label: "Character",
		childs: [
			{label: "BF", onSelect: () -> loadCharacter("bf", 0)},
			{label: "Dad", onSelect: () -> loadCharacter("Dad", 1)},
			{label: "Spooky Kids", onSelect: () -> loadCharacter("Spooky Kids", 2)},
			{label: "Pico", onSelect: () -> loadCharacter("Pico", 3)},
			{label: "Mom", onSelect: () -> loadCharacter("Mom", 4)},
			{label: "Tankman", onSelect: () -> loadCharacter("Tankman", 5)}
		]
	},
	{
		label: "HUD",
		childs: [
			{label: "Hide HUD", onSelect: () -> verde.alpha = 1},
			{label: "Show HUD", onSelect: () -> verde.alpha = 0}
		]
	},
	{
		label: "Edit",
		childs: [
			{
				label: "Top Mask Color",
				keybind: [FlxKey.E, FlxKey.ONE],
				onSelect: editTopMaskColor
			},
			{
				label: "Sprite Color",
				keybind: [FlxKey.E, FlxKey.TWO],
				onSelect: editSpriteColor
			},
			{
				label: "Light Color",
				keybind: [FlxKey.E, FlxKey.THREE],
				onSelect: editLightColor
			},
			{
				label: "Light Parameters",
				keybind: [FlxKey.E, FlxKey.FOUR],
				onSelect: editLightParameters
			}
		]
	},
	{
		label: "Reset",
		childs: [
			{
				label: "Reset Top Mask Color",
				keybind: [FlxKey.R, FlxKey.ONE],
				onSelect: resetTopMaskColor
			},
			{
				label: "Reset Sprite Color",
				keybind: [FlxKey.R, FlxKey.TWO],
				onSelect: resetSpriteColor
			},
			{
				label: "Reset Light Color",
				keybind: [FlxKey.R, FlxKey.THREE],
				onSelect: resetLightColor
			},
			{
				label: "Reset Light Parameters",
				keybind: [FlxKey.R, FlxKey.FOUR],
				onSelect: resetLightParameters
			},
			null,
			{
				label: "Reset ALL",
				keybind: [FlxKey.R, FlxKey.FIVE],
				onSelect: resetAll
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
	return slider;
}

function recoverdata() {
	var path = "addons/rtxlight/other/rembem.txt";
	var rawContent:String = File.getContent(path);
	var raw:Array<Float> = rawContent.split(",").map(StringTools.trim).filter(s -> s.length > 0).map(Std.parseFloat);
	var sliders = [
		  topMaskR,   topMaskG,   topMaskB,   topMaskA,
		spriteColR, spriteColG, spriteColB, spriteColA,
		 lightColR,  lightColG,  lightColB,  lightColA,
		lightnalge,  lightSize,   numOfLay,    laySepa
	];
	for (i in 0...raw.length) {
		sliders[i].value = raw[i];
	}
	shaderParms.mask_Color_R = raw[0];
	shaderParms.mask_Color_G = raw[1];
	shaderParms.mask_Color_B = raw[2];
	shaderParms.mask_Color_A = raw[3];
	shaderParms.sprite_Color_R = raw[4];
	shaderParms.sprite_Color_G = raw[5];
	shaderParms.sprite_Color_B = raw[6];
	shaderParms.sprite_Color_A = raw[7];
	shaderParms.light_Color_R = raw[8];
	shaderParms.light_Color_G = raw[9];
	shaderParms.light_Color_B = raw[10];
	shaderParms.light_Color_A = raw[11];
	shaderParms.light_Angle = raw[12];
	shaderParms.light_Size = raw[13];
	shaderParms.number_Of_Layers = raw[14];
	shaderParms.layer_Separation = raw[15];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// POST CREATE
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function postCreate() {
	// stuff
	DiscordUtil.changePresence("Shadeinater V3 (Editor)");

	if (!FlxG.save.data.nobgmus) {
		FlxG.sound.playMusic(Paths.sound("music" + FlxG.save.data.bgsong), Std.parseFloat(FlxG.save.data.volum), true);
	}

	// BG
	var stge:FlxSprite = new FlxSprite(0, 0);
	stge.loadGraphic(Paths.image("menuEditors"));
	stge.camera = FlxG.camera;
	add(stge);

	// ARROW
	if (FlxG.save.data.whrsbf) {
		flecha = new FlxSprite(-100, -600);
		flecha.loadGraphic("images/arrow.png");
		add(flecha);
		flecha.scale.set(0.1, 0.1);
		flecha.camera = FlxG.camera;
		flecha.alpha = 0.5;

		// DISTANCE NUMBER
		distcn = new FunkinText(425, 400, 1000, "0.0", 40);
		distcn.alignment = "center";
		distcn.cameras = FlxG.camera;
		distcn.alpha = 0.5;
		add(distcn);
	}

	// EDITING TEXT
	editinn = new FunkinText(100, 100, 1000, "Editing Top Mask Color", 40);
	editinn.alignment = "center";
	editinn.cameras = FlxG.camera;
	add(editinn);

	// SLIDER 1
	slide1 = new FunkinText(100, 165, 100, "Alpha", 30);
	slide1.alignment = "left";
	slide1.cameras = FlxG.camera;
	add(slide1);

	// SLIDER 2
	slide2 = new FunkinText(100, 265, 100, "Red", 30);
	slide2.alignment = "left";
	slide2.cameras = FlxG.camera;
	add(slide2);

	// SLIDER 3
	slide3 = new FunkinText(100, 365, 300, "Green", 30);
	slide3.alignment = "left";
	slide3.cameras = FlxG.camera;
	add(slide3);

	// SLIDER 4
	slide4 = new FunkinText(100, 465, 300, "Blue", 30);
	slide4.alignment = "left";
	slide4.cameras = FlxG.camera;
	add(slide4);

	//
	//
	//
	//
	// x, y, width, value, min, max, onChange, centered
	//
	// TOP MASK COLOR SLIDERS
	topMaskA = makeUISlider(100, 200, 450, 0, -1, 1, function(val:Float) {
		shaderParms.mask_Color_A = val;
	});
	topMaskA.camera = FlxG.camera;
	add(topMaskA);
	topMaskA.visible = true;
	//
	topMaskR = makeUISlider(100, 300, 450, 0, 0, 1, function(val:Float) {
		shaderParms.mask_Color_R = val;
	});
	topMaskR.camera = FlxG.camera;
	add(topMaskR);
	topMaskR.visible = true;
	//
	topMaskG = makeUISlider(100, 400, 450, 0, 0, 1, function(val:Float) {
		shaderParms.mask_Color_G = val;
	});
	topMaskG.camera = FlxG.camera;
	add(topMaskG);
	topMaskG.visible = true;
	//
	topMaskB = makeUISlider(100, 500, 450, 0, 0, 1, function(val:Float) {
		shaderParms.mask_Color_B = val;
	});
	topMaskB.camera = FlxG.camera;
	add(topMaskB);
	topMaskB.visible = true;
	//
	//
	//
	spriteColA = makeUISlider(100, 200, 450, 0, -1, 1, function(val:Float) {
		shaderParms.sprite_Color_A = val;
	});
	spriteColA.camera = FlxG.camera;
	add(spriteColA);
	spriteColA.visible = false;
	//
	spriteColR = makeUISlider(100, 300, 450, 0, 0, 1, function(val:Float) {
		shaderParms.sprite_Color_R = val;
	});
	spriteColR.camera = FlxG.camera;
	add(spriteColR);
	spriteColR.visible = false;
	//
	spriteColG = makeUISlider(100, 400, 450, 0, 0, 1, function(val:Float) {
		shaderParms.sprite_Color_G = val;
	});
	spriteColG.camera = FlxG.camera;
	add(spriteColG);
	spriteColG.visible = false;
	//
	spriteColB = makeUISlider(100, 500, 450, 0, 0, 1, function(val:Float) {
		shaderParms.sprite_Color_B = val;
	});
	spriteColB.camera = FlxG.camera;
	add(spriteColB);
	spriteColB.visible = false;
	//
	//
	//
	lightColA = makeUISlider(100, 200, 450, 0, -1, 1, function(val:Float) {
		shaderParms.light_Color_A = val;
	});
	lightColA.camera = FlxG.camera;
	add(lightColA);
	lightColA.visible = false;
	//
	lightColR = makeUISlider(100, 300, 450, 0, 0, 1, function(val:Float) {
		shaderParms.light_Color_R = val;
	});
	lightColR.camera = FlxG.camera;
	add(lightColR);
	lightColR.visible = false;
	//
	lightColG = makeUISlider(100, 400, 450, 0, 0, 1, function(val:Float) {
		shaderParms.light_Color_G = val;
	});
	lightColG.camera = FlxG.camera;
	add(lightColG);
	lightColG.visible = false;
	//
	lightColB = makeUISlider(100, 500, 450, 0, 0, 1, function(val:Float) {
		shaderParms.light_Color_B = val;
	});
	lightColB.camera = FlxG.camera;
	add(lightColB);
	lightColB.visible = false;
	//
	//
	//
	lightnalge = makeUISlider(100, 200, 450, 0, 0, 360, function(val:Float) {
		shaderParms.light_Angle = val;
	});
	lightnalge.camera = FlxG.camera;
	add(lightnalge);
	lightnalge.visible = false;

	lightSize = makeUISlider(100, 300, 450, 0, 0, 100, function(val:Float) {
		shaderParms.light_Size = val;
	});
	lightSize.camera = FlxG.camera;
	add(lightSize);
	lightSize.visible = false;

	numOfLay = makeUISlider(100, 400, 450, 0, 0, 100, function(val:Float) {
		shaderParms.number_Of_Layers = val;
	});
	numOfLay.camera = FlxG.camera;
	add(numOfLay);
	numOfLay.visible = false;

	laySepa = makeUISlider(100, 500, 450, 0, 0, 100, function(val:Float) {
		shaderParms.layer_Separation = val;
	});
	laySepa.camera = FlxG.camera;
	add(laySepa);
	laySepa.visible = false;

	// GREEN BG
	verde = new FlxSprite(0, 0);
	verde.loadGraphic("images/qwertyuiop.png");
	add(verde);
	verde.scale.set(5, 5);
	verde.camera = FlxG.camera;
	verde.alpha = 0;

	// CHARACTER
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

	// TOP MENU
	topMenuSpr = new UITopMenu(topMenu);
	topMenuSpr.cameras = FlxG.camera;
	add(topMenuSpr);

	var credit = new FunkinText(-365, 685, 1000, "Shadeinator by Edwin", 20);
	credit.alignment = "center";
	credit.cameras = FlxG.camera;
	add(credit);

	var verga = new FunkinText(730, 685, 1000, "V3.1", 20);
	verga.alignment = "center";
	verga.cameras = FlxG.camera;
	add(verga);

	if (FlxG.save.data.livepre) {
		var liveprev = new FunkinText(100, 150, 1000, "{[ LIVE PREVIEW ON ]}", 30);
		liveprev.alignment = "center";
		liveprev.cameras = FlxG.camera;
		add(liveprev);
	}

	recoverdata();

	if (FlxG.save.data.livepre) {
		new FlxTimer().start(0.5, function(timer:FlxTimer) {
			File.saveContent("addons/rtxlight/data/test.txt", codenumber);
		}, 0);
	}
}

// LOAD CHARACTER
function loadCharacter(charKey:String, index:Int) {
	if (bff == null)
		return;
	// LOAD CHAR ANIMS
	bff.loadGraphic(Paths.image('chars/$index'));
	bff.antialiasing = true;
	bff.frames = Paths.getSparrowAtlas('chars/' + charKey);
	bff.animation.addByPrefix('idle', 'idle0', 16, true);
	bff.animation.addByPrefix('up', 'up0', 16, false);
	//bff.animation.addByPrefix('hey', 'BF HEY!!0', 1, false);
	bff.animation.addByPrefix('left', 'left0', 16, false);
	bff.animation.addByPrefix('down', 'down0', 16, false);
	bff.animation.addByPrefix('right', 'right0', 16, false);
	bff.animation.play('idle');
	if (index == 1 || index == 4)
		bff.scale.set(0.75, 0.75);
	else
		bff.scale.set(1, 1);
}

// LOAD PRESET FUNCION
function loadpresst() {
	var fileToLoad = "addons/rtxlight/other/toload.txt";
	var name = StringTools.trim(File.getContent(fileToLoad));
	if (name.length == 0)
		return;
	var path = "addons/rtxlight/values/" + name + ".txt";
	var rawContent:String = File.getContent(path);
	var raw:Array<Float> = rawContent.split(",").map(StringTools.trim).filter(s -> s.length > 0).map(Std.parseFloat);
	// aply data
	var sliders = [
		  topMaskR,   topMaskG,   topMaskB,   topMaskA,
		spriteColR, spriteColG, spriteColB, spriteColA,
		 lightColR,  lightColG,  lightColB,  lightColA,
		lightnalge,  lightSize,   numOfLay,    laySepa
	];
	for (i in 0...raw.length) {
		sliders[i].value = raw[i];
	}
	shaderParms.mask_Color_R = raw[0];
	shaderParms.mask_Color_G = raw[1];
	shaderParms.mask_Color_B = raw[2];
	shaderParms.mask_Color_A = raw[3];
	shaderParms.sprite_Color_R = raw[4];
	shaderParms.sprite_Color_G = raw[5];
	shaderParms.sprite_Color_B = raw[6];
	shaderParms.sprite_Color_A = raw[7];
	shaderParms.light_Color_R = raw[8];
	shaderParms.light_Color_G = raw[9];
	shaderParms.light_Color_B = raw[10];
	shaderParms.light_Color_A = raw[11];
	shaderParms.light_Angle = raw[12];
	shaderParms.light_Size = raw[13];
	shaderParms.number_Of_Layers = raw[14];
	shaderParms.layer_Separation = raw[15];
}

// DELETE PRESET FUNCTION
function deletepreset() {
	var fileToLoad = "addons/rtxlight/other/todelete.txt";
	var name = StringTools.trim(File.getContent(fileToLoad));
	var path = "addons/rtxlight/values/" + name + ".txt";
	FileSystem.deleteFile(path);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// POST UPDATE
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function postUpdate(elapsed:Float):Void {
	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.ONE) {
		resetTopMaskColor();
	}
	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.TWO) {
		resetSpriteColor();
	}
	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.THREE) {
		resetLightColor();
	}
	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.FOUR) {
		resetLightParameters();
	}
	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.FIVE) {
		resetAll();
	}

	if (FlxG.keys.pressed.E && FlxG.keys.justPressed.ONE) {
		editTopMaskColor();
	}
	if (FlxG.keys.pressed.E && FlxG.keys.justPressed.TWO) {
		editSpriteColor();
	}
	if (FlxG.keys.pressed.E && FlxG.keys.justPressed.THREE) {
		editLightColor();
	}
	if (FlxG.keys.pressed.E && FlxG.keys.justPressed.FOUR) {
		editLightParameters();
	}

	// LOADPRESET SUBSTATE
	if (waitingForPreset && this.subState == null) {
		waitingForPreset = false;
		var path = "addons/rtxlight/other/loadpreset.txt";
		var raw = File.getContent(path);
		var content = StringTools.trim(raw);
		if (content == "true") {
			loadpresst();
		}
	}

	// DELETE SUBSTATE
	if (waitingForDelete && this.subdelete == null) {
		waitingForDelete = false;
		var path = "addons/rtxlight/other/delete.txt";
		var raw = File.getContent(path);
		var content = StringTools.trim(raw);
		if (content == "true") {
			deletepreset();
		}
	}

	if (importing && this.subState == null) {
		importing = false;
		var path = "addons/rtxlight/other/loadpreset.txt";
		var raw = File.getContent(path);
		var content = StringTools.trim(raw);
		if (content == "true") {
			loadpresst();
		}

		// Check useifimport.txt
		var useImportPath = "addons/rtxlight/other/useifimport.txt";
		if (FileSystem.exists(useImportPath)) {
			var useImportRaw = File.getContent(useImportPath);
			var useImportContent = StringTools.trim(useImportRaw);
			var parts = useImportContent.split(",");

			if (parts.length == 2) {
				var fileName = StringTools.trim(parts[0]);
				var shouldUse = StringTools.trim(parts[1]) == "true";

				if (shouldUse) {
					loadPresetByName(fileName);
				}
			}
		}
	}

	if (waitingForScript && this.subdelete == null) {
		waitingForScript = false;
		var fileNamePath = "addons/rtxlight/other/filename.txt";
		var charsPath = "addons/rtxlight/other/chars.txt";
		var strumsPath = "addons/rtxlight/other/strums.txt";
		var fileName = StringTools.trim(File.getContent(fileNamePath));
		var charsRaw = File.getContent(charsPath);
		var charsContent = StringTools.trim(charsRaw);
		var charsParts = charsContent.split(",");
		var chars = [for (c in charsParts) Std.parseInt(c)];
		var strumsRaw = File.getContent(strumsPath);
		var strumsContent = StringTools.trim(strumsRaw);
		var strumsParts = strumsContent.split(",");
		var strums = [for (s in strumsParts) Std.parseInt(s)];
		new FlxTimer().start(1, function(tmr:FlxTimer) {
			makescript(strums, chars, fileName);
		});
	}

	// UPTADE VARIABLE
	codenumber = Math.round(shaderParms.mask_Color_R * 100) / 100 + "," + Math.round(shaderParms.mask_Color_G * 100) / 100 + ","
		+ Math.round(shaderParms.mask_Color_B * 100) / 100 + "," + Math.round(shaderParms.mask_Color_A * 100) / 100 + ","
		+ Math.round(shaderParms.sprite_Color_R * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_G * 100) / 100 + ","
		+ Math.round(shaderParms.sprite_Color_B * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_A * 100) / 100 + ","
		+ Math.round(shaderParms.light_Color_R * 100) / 100 + "," + Math.round(shaderParms.light_Color_G * 100) / 100 + ","
		+ Math.round(shaderParms.light_Color_B * 100) / 100 + "," + Math.round(shaderParms.light_Color_A * 100) / 100 + ","
		+ Math.floor(shaderParms.light_Angle) + "," + Math.floor(shaderParms.light_Size) + "," + Math.floor(shaderParms.number_Of_Layers) + ","
		+ Math.floor(shaderParms.layer_Separation);

	// ARROW AND DISTANTE NUMBER
	if (FlxG.save.data.whrsbf) {
		var fx = flecha.x + flecha.width * 0.5;
		var fy = flecha.y + flecha.height * 0.5;
		var bx = bff.x + bff.width * 0.5;
		var by = bff.y + bff.height * 0.5;
		var dx = bx - fx;
		var dy = by - fy;
		flecha.angle = Math.atan2(dy, dx) * 180 / Math.PI;
		distcn.text = Math.ceil(Math.sqrt(dx * dx + dy * dy));
	}

	// PLAY AND UPTADE THE SHADER
	bff.shader.overlayColor = [
		shaderParms.mask_Color_R,
		shaderParms.mask_Color_G,
		shaderParms.mask_Color_B,
		shaderParms.mask_Color_A
	];
	bff.shader.satinColor = [
		shaderParms.sprite_Color_R,
		shaderParms.sprite_Color_G,
		shaderParms.sprite_Color_B,
		shaderParms.sprite_Color_A
	];
	bff.shader.innerShadowColor = [
		shaderParms.light_Color_R,
		shaderParms.light_Color_G,
		shaderParms.light_Color_B,
		shaderParms.light_Color_A
	];
	bff.shader.innerShadowAngle = (shaderParms.light_Angle - 90) * Math.PI / 180;
	bff.shader.innerShadowDistance = shaderParms.light_Size;
	bff.shader.layernumbers = shaderParms.number_Of_Layers;
	bff.shader.layerseparation = shaderParms.layer_Separation;

	// PLAY CHAR ANIMS
	var animationTimer:FlxTimer = null;
	function playAnimationWithTimer(animName:String):Void {
		if (animationTimer != null)
			animationTimer.cancel();
		bff.animation.play(animName);
		animationTimer = new FlxTimer().start(1, function(tmr:FlxTimer) {
			bff.animation.play('idle');
			animationTimer = null;
		});
	}

	if (FlxG.keys.pressed.A)
		playAnimationWithTimer('left');
	else if (FlxG.keys.pressed.S)
		playAnimationWithTimer('down');
	else if (FlxG.keys.pressed.D)
		playAnimationWithTimer('right');
	else if (FlxG.keys.pressed.W)
		playAnimationWithTimer('up');
	// else if (FlxG.keys.pressed.SPACE)
	// 	playAnimationWithTimer('hey');

	// MOVE CHARACTER WITH SLIDE
	var speed:Float = 200;
	var mult:Float = FlxG.keys.pressed.SHIFT ? 3 : 1;

	if (FlxG.save.data.enaslide) {
		bff.drag.set(1000 - (FlxG.save.data.slide * 100), 1000 - (FlxG.save.data.slide * 100));
	} else {
		bff.drag.set(10000, 10000);
	}
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
	} else if (!FlxG.save.data.enaslide) {
		bff.velocity.set(0, 0);
	}
}
