/* 
THIS FILE CONTAINS THE OLD EDITOR
It's now obsolete—don't even think about trying to make it work!
*/

// import flixel.FlxSprite;
// import flixel.FlxG;
// import flixel.addons.ui.FlxSlider;
// import flixel.FlxState;
// import funkin.backend.utils.DiscordUtil;
// import funkin.editors.ui.UITextBox;
// import funkin.editors.ui.UIState;
// import funkin.editors.ui.UIButton;
// import sys.io.File;
// import funkin.editors.ui.UISlider;
// import funkin.editors.ui.UIDropDown;
// import Sys;
// import funkin.editors.ui.notifications.UIBaseNotification;
// import sys.FileSystem;
// import funkin.editors.ui.UIWarningSubstate;
// import funkin.editors.EditorTreeMenu;
// import Date;

// if (FlxG.save.data.advc == true) {
// 	var rc = Sys.command('cmd /c start "" wscript "addons/rtxlight/"' + FlxG.save.data.langs + '".vbs"');
// 	//        trace("rc: " + rc);
// }
// if (FlxG.save.data.don == false) {
// 	var archivo = "addons/rtxlight/" + FlxG.save.data.langs + ".txt";
// 	var rc = Sys.command('cmd /c start "" "' + archivo + '"');
// }
// // trace("Comando ejecutado, código de salida: " + rc);

// function getValueFiles():Array<String> {
// 	var folder = "addons/rtxlight/values/";
// 	var files = [];

// 	if (FileSystem.exists(folder)) {
// 		for (f in FileSystem.readDirectory(folder)) {
// 			if (StringTools.endsWith(f, ".txt")) {
// 				files.push(f.substr(0, f.length - 4));
// 			}
// 		}
// 	}

// 	return files;
// }

// // Shader Variables
// var shaderParms = {
// 	//  Top mas color
// 	mask_Color_R: 0,
// 	mask_Color_G: 0,
// 	mask_Color_B: 0,
// 	mask_Color_A: 0,
// 	//  Sprite color
// 	sprite_Color_R: 0,
// 	sprite_Color_G: 0,
// 	sprite_Color_B: 0,
// 	sprite_Color_A: 0,
// 	// Light Color
// 	light_Color_R: 0,
// 	light_Color_G: 0,
// 	light_Color_B: 0,
// 	light_Color_A: 0,
// 	// light extra values
// 	light_Angle: 0,
// 	light_Size: 0,
// 	number_Of_Layers: 0,
// 	layer_Separation: 0
// }

// var num = 0;

// var texts:Array<Array<String>> = [
// 	[
// 		" updated!",
// 		"Shader Saved! Reloading in: ",
// 		"Shader Saved! Reload to see changes",
// 		"Failed to save the shader",
// 		"Save shader",
// 		"Keybinds:\nR+1 reset Mask Color\nR+2 reset Sprite Color\nR+3 reset Light Color\nR+4 reset Light Parameters\nR+5 reset ALL\n←↑↓→ Move Character\nWASD Sing Poses",
// 		"Return",
// 		"Leave",
// 		"Exit: Security alert!",
// 		"Do you want to leave?\nMake sure you don't lose you progress.\n\n- Edwin.",
// 		"Show HUD",
// 		"Hide HUD",
// 		"Backup saved successfully"

// 	],
// 	[
// 		" actualizado!",
// 		"Shader Guardado! Recargando en: ",
// 		"Shader Guadado! Recarga para ver los cambios",
// 		"Error al guardar el shader",
// 		"Guardar shader",
// 		"Teclas:\nR+1 reiniciar Color Frontal\nR+2 reiniciar Color del\nSprite\nR+3 reiniciar Color de Luz\nR+4 reiniciar Parametros\nde Luz\nR+5 reiniciar TODO\n←↑↓→ Mover Personaje\nWASD Poses de canto",
// 		"Regresar",
// 		"Salir",
// 		"Salir: Alerta de seguridad!",
// 		"Quieres salir?\nAsegurate de no perder tu progreso.\n\n- Edwin.",
// 		"Mostrar HUD",
// 		"Ocultar HUD",
// 		"Copia de seguridad guardada"
// 	]
// ];

// if (FlxG.save.data.langs == "esp") {
// 	num = 1;
// }

// // Events value texts
// var nalgle = 0;
// var topMasCol = "0,0,0,0";
// var spriteCol = "0,0,0,0";
// var lightCol = "0,0,0,0";
// var keybinds = "0,0,0,0";
// var sizex = 0;
// var numLay = 0;
// var laySep = 0;
// var valueID:UITextBox;
// var contenido:String = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
// var zoomSlider:UISlider;
// var topMaskR:UISlider = null;
// var topMaskG:UISlider = null;
// var topMaskB:UISlider = null;
// var topMaskA:UISlider = null;
// var spriteColR:UISlider = null;
// var spriteColG:UISlider = null;
// var spriteColB:UISlider = null;
// var spriteColA:UISlider = null;
// var lightColR:UISlider = null;
// var lightColG:UISlider = null;
// var lightColB:UISlider = null;
// var lightColA:UISlider = null;
// var lightnalge:UISlider = null;
// var lightSize:UISlider = null;
// var numOfLay:UISlider = null;
// var laySepa:UISlider = null;
// var speed:Float = 200;
// var notif:UIBaseNotification;
// var bff = null;
// var fileNames = getValueFiles();
// var colorDropdown = new UIDropDown(50, 440, 200, 32, fileNames, 0);
// var hideHud = new UIDropDown(50, 480, 200, 32, [texts[num][10], texts[num][11]], 0);
// var flecha:FlxSprite;
// var verde:FlxSprite;
// var addin = -75;

// var textos:Array<String> = [
// 	"My Awesome Shader",
// 	"The Best Shader ",
// 	"Coolest Shader Ever",
// 	"Shader Name",
// 	"Insert Shader Name"
// ];

// FlxG.mouse.visible = true;
// FlxG.mouse.enabled = true;
// function onButtonKey() {
// 	var contenido = Math.round(shaderParms.mask_Color_R * 100) / 100 + "," + Math.round(shaderParms.mask_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.mask_Color_B * 100) / 100 + "," + Math.round(shaderParms.mask_Color_A * 100) / 100 + ","
// 		+ Math.round(shaderParms.sprite_Color_R * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.sprite_Color_B * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_A * 100) / 100 + ","
// 		+ Math.round(shaderParms.light_Color_R * 100) / 100 + "," + Math.round(shaderParms.light_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.light_Color_B * 100) / 100 + "," + Math.round(shaderParms.light_Color_A * 100) / 100 + ","
// 		+ Math.floor(shaderParms.light_Angle) + "," + Math.floor(shaderParms.light_Size) + "," + Math.floor(shaderParms.number_Of_Layers) + ","
// 		+ Math.floor(shaderParms.layer_Separation);

// 	try {
// 		File.saveContent("addons/rtxlight/values/" + valueID.label.text + ".txt", contenido);

// 		if (fileNames.contains(valueID.label.text)) {
// 			var notif = new UIBaseNotification("Shader: " + valueID.label.text + texts[num][0], 2, 2);
// 			add(notif);
// 			notif.appearAnimation();
// 		} else {
// 			if (FlxG.save.data.dros == false) {
// 				var notif = new UIBaseNotification(texts[num][1] + FlxG.save.data.numr, 2, 2);
// 				add(notif);
// 				notif.appearAnimation();
// 				new FlxTimer().start(FlxG.save.data.numr, function(tmr:FlxTimer) {
// 					FlxG.switchState(new UIState(true, "idk"));
// 				});
// 			} else {
// 				var notif = new UIBaseNotification(texts[num][2], 2, 2);
// 				add(notif);
// 				notif.appearAnimation();
// 			}
// 		}
// 	} catch (e:Dynamic) {
// 		// trace("Error al guardar archivo: " + e);
// 		var notif = new UIBaseNotification(texts[num][3], 2, 2);
// 		add(notif);
// 		notif.appearAnimation();
// 	}
// }

// var buttonKey = new UIButton(300, 450, texts[num][4], onButtonKey);

// // var opensha = new UIButton(250, 400, "Open Saved shaders folder", openfol);

// function makeUISlider(x:Float, y:Float, width:Int, value:Float, min:Float, max:Float, onChange:Float->Void, centered:Bool = false):UISlider {
// 	var segs = [{start: min, end: max, size: 1}];
// 	var slider = new UISlider(x, y, width, value, segs, centered);
// 	slider.startText.text = "";
// 	slider.endText.text = "";
// 	slider.valueStepper.visible = true;
// 	slider.valueStepper.active = true;
// 	slider.onChange = onChange;
// 	return slider;
// }

// //
// // POST CREATE
// //
// function postCreate() {

// 	new FlxTimer().start(FlxG.save.data.autott * 60, function(tmr:FlxTimer) { 


// 		var contenido = Math.round(shaderParms.mask_Color_R * 100) / 100 + "," + Math.round(shaderParms.mask_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.mask_Color_B * 100) / 100 + "," + Math.round(shaderParms.mask_Color_A * 100) / 100 + ","
// 		+ Math.round(shaderParms.sprite_Color_R * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.sprite_Color_B * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_A * 100) / 100 + ","
// 		+ Math.round(shaderParms.light_Color_R * 100) / 100 + "," + Math.round(shaderParms.light_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.light_Color_B * 100) / 100 + "," + Math.round(shaderParms.light_Color_A * 100) / 100 + ","
// 		+ Math.floor(shaderParms.light_Angle) + "," + Math.floor(shaderParms.light_Size) + "," + Math.floor(shaderParms.number_Of_Layers) + ","
// 		+ Math.floor(shaderParms.layer_Separation);

//     if(FlxG.save.data.autos){
// 		File.saveContent("addons/rtxlight/backups/" + "Backup_" + Date.now().getTime() + ".txt",contenido);
// 		var notif = new UIBaseNotification(texts[num][12], 5, 2);
// 			add(notif);
// 			notif.appearAnimation();
// 	}
// 	}, 0);



//         // var currentDate = Date.now();
//         // trace(currentDate); // Outputs the current date and time



// 	// trace(FlxG.save.data.don);
// 	// trace(FlxG.save.data.wn);
// 	// trace(FlxG.save.data.slide);

// 	// Util
// 	// FlxG.sound.play(Paths.sound("music.ogg"), 1, true);
// 	DiscordUtil.changePresence("Shadeinater 2000 (Editor)");

// 	// Things
// 	var stge:FlxSprite = new FlxSprite(-600, -220);
// 	stge.loadGraphic("images/" + FlxG.save.data.langs + ".png");
// 	add(stge);
// 	stge.scale.set(0.69, 0.69); // 0.69
// 	stge.camera = FlxG.camera;

// 	flecha = new FlxSprite(-300, -500);
// 	flecha.loadGraphic("images/arrow.png");
// 	add(flecha);
// 	flecha.scale.set(0.1, 0.1);
// 	flecha.camera = FlxG.camera;
// 	flecha.alpha = 1;

// 	var playerSprite:FlxSprite = new FlxSprite(950, 0);
// 	playerSprite.loadGraphic("images/event.png");
// 	add(playerSprite);
// 	playerSprite.scale.set(1, 1);
// 	playerSprite.camera = FlxG.camera;

// 	// unimportant things
// 	colorDropdown.onChange = function(index:Int) {
// 		var selectedFile = fileNames[index];
// 		// trace("Archivo seleccionado: " + selectedFile);
// 		loadValuesFromFile(selectedFile);
// 	};
// 	colorDropdown.camera = FlxG.camera;
// 	add(colorDropdown);

// 	valueID = new UITextBox(400, 30, textos[Math.floor(Math.random() * textos.length)], 300, 50);
// 	valueID.screenCenter(0x11);
// 	valueID.x -= 590;
// 	valueID.y -= -300;
// 	add(valueID);

// 	buttonKey.screenCenter(0x01);
// 	buttonKey.x -= 270;
// 	buttonKey.y -= -215;
// 	buttonKey.scale.set(2, 2);
// 	add(buttonKey);

// 	// opensha.screenCenter(0x01);
// 	// opensha.x -= 570;
// 	// opensha.y -= -100;
// 	// opensha.scale.set(2, 2);
// 	// add(opensha);

// 	//
// 	//
// 	// Sliders
// 	//
// 	//
// 	topMaskR = makeUISlider(80, 160, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.mask_Color_R = val;
// 	});
// 	topMaskR.camera = FlxG.camera;
// 	add(topMaskR);
// 	//
// 	topMaskG = makeUISlider(80, 130, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.mask_Color_G = val;
// 	});
// 	topMaskG.camera = FlxG.camera;
// 	add(topMaskG);
// 	//
// 	topMaskB = makeUISlider(80, 100, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.mask_Color_B = val;
// 	});
// 	topMaskB.camera = FlxG.camera;
// 	add(topMaskB);
// 	//
// 	topMaskA = makeUISlider(80, 70, 200, 0, -1, 1, function(val:Float) {
// 		shaderParms.mask_Color_A = val;
// 	});
// 	topMaskA.camera = FlxG.camera;
// 	add(topMaskA);
// 	//
// 	//
// 	spriteColR = makeUISlider(80 + 300, 160, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.sprite_Color_R = val;
// 	});
// 	spriteColR.camera = FlxG.camera;
// 	add(spriteColR);
// 	//
// 	spriteColG = makeUISlider(80 + 300, 130, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.sprite_Color_G = val;
// 	});
// 	spriteColG.camera = FlxG.camera;
// 	add(spriteColG);
// 	//
// 	spriteColB = makeUISlider(80 + 300, 100, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.sprite_Color_B = val;
// 	});
// 	spriteColB.camera = FlxG.camera;
// 	add(spriteColB);
// 	//
// 	spriteColA = makeUISlider(80 + 300, 70, 200, 0, -1, 1, function(val:Float) {
// 		shaderParms.sprite_Color_A = val;
// 	});
// 	spriteColA.camera = FlxG.camera;
// 	add(spriteColA);
// 	//
// 	//
// 	lightColR = makeUISlider(80 + 600, 160, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.light_Color_R = val;
// 	});
// 	lightColR.camera = FlxG.camera;
// 	add(lightColR);
// 	//
// 	lightColG = makeUISlider(80 + 600, 130, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.light_Color_G = val;
// 	});
// 	lightColG.camera = FlxG.camera;
// 	add(lightColG);
// 	//
// 	lightColB = makeUISlider(80 + 600, 100, 200, 0, 0, 1, function(val:Float) {
// 		shaderParms.light_Color_B = val;
// 	});
// 	lightColB.camera = FlxG.camera;
// 	add(lightColB);
// 	//
// 	lightColA = makeUISlider(80 + 600, 70, 200, 0, -1, 1, function(val:Float) {
// 		shaderParms.light_Color_A = val;
// 	});
// 	lightColA.camera = FlxG.camera;
// 	add(lightColA);
// 	//
// 	//
// 	lightnalge = makeUISlider(80, 270, 400, 0, 0, 360, function(val:Float) {
// 		shaderParms.light_Angle = val;
// 	});
// 	lightnalge.camera = FlxG.camera;
// 	add(lightnalge);

// 	lightSize = makeUISlider(80, 320, 400, 0, 0, 100, function(val:Float) {
// 		shaderParms.light_Size = val;
// 	});
// 	lightSize.camera = FlxG.camera;
// 	add(lightSize);

// 	numOfLay = makeUISlider(80, 370, 400, 0, 0, 100, function(val:Float) {
// 		shaderParms.number_Of_Layers = val;
// 	});
// 	numOfLay.camera = FlxG.camera;
// 	add(numOfLay);

// 	laySepa = makeUISlider(80, 420, 400, 0, 0, 100, function(val:Float) {
// 		shaderParms.layer_Separation = val;
// 	});
// 	laySepa.camera = FlxG.camera;
// 	add(laySepa);
// 	//
// 	//

// 	//
// 	// TEXTS
// 	//
// 	topMasCol = new FunkinText(960, 105 + addin, 250, "0,0,0,0", 20);
// 	topMasCol.alignment = "left";
// 	add(topMasCol);
// 	spriteCol = new FunkinText(960, 163 + addin, 250, "0,0,0,0", 20);
// 	spriteCol.alignment = "left";
// 	add(spriteCol);
// 	lightCol = new FunkinText(960, 163 + 58 + addin, 250, "0,0,0,0", 20);
// 	lightCol.alignment = "left";
// 	add(lightCol);
// 	nalgle = new FunkinText(960, 278 + addin, 100, "0", 20);
// 	nalgle.alignment = "left";
// 	add(nalgle);
// 	sizex = new FunkinText(960, 337 + addin, 100, "0", 20);
// 	sizex.alignment = "left";
// 	add(sizex);
// 	numLay = new FunkinText(960, 437 + addin, 100, "0", 20);
// 	numLay.alignment = "left";
// 	add(numLay);
// 	laySep = new FunkinText(960, 495 + addin, 100, "0", 20);
// 	laySep.alignment = "left";
// 	add(laySep);

// 	// keybinds text
// 	keybinds = new FunkinText(955, 500, 1000, texts[num][5], 20);
// 	keybinds.alignment = "left";
// 	add(keybinds);

// 	verde = new FlxSprite(0, 0);
// 	verde.loadGraphic("images/qwertyuiop.png");
// 	add(verde);
// 	verde.scale.set(5, 5);
// 	verde.camera = FlxG.camera;
// 	verde.alpha = 0;

// 	bff = new FlxSprite(500, 300);
// 	bff.loadGraphic("images/chars/bf.png");
// 	add(bff);
// 	bff.scale.set(1, 1); // 1
// 	bff.camera = FlxG.camera;
// 	bff.frames = Paths.getSparrowAtlas('chars/bf');
// 	bff.animation.addByPrefix('idle', 'idle0', 16, true);
// 	bff.animation.addByPrefix('up', 'up0', 16, false);
// 	bff.animation.addByPrefix('left', 'left0', 16, false);
// 	bff.animation.addByPrefix('down', 'down0', 16, false);
// 	bff.animation.addByPrefix('right', 'right0', 16, false);
// 	bff.animation.play('idle');

// 	bff.shader = new CustomShader("RTXLighting");
// 	bff.shader.overlayColor = [0, 0, 0, 0];
// 	bff.shader.satinColor = [0, 0, 0, 0];
// 	bff.shader.innerShadowColor = [1, 0, 0, 1];
// 	bff.shader.innerShadowAngle = (shaderParms.nalge - 90) * Math.PI / 180;
// 	bff.shader.innerShadowDistance = 10;
// 	bff.shader.layernumbers = 5;
// 	bff.shader.layerseparation = 1;

// 	var curchar:UIDropDown;
// 	curchar = new UIDropDown(250, 440, 200, 32, ["bf", "Dad", "Spooky Kids", "Pico", "Mom", "Tankman"], 0);
// 	curchar.camera = FlxG.camera;
// 	curchar.onChange = function(index:Int) {
// 		// trace("Seleccionado: " + curchar.key);
// 		// trace("Valor: " + curchar.value);
// 		bff.loadGraphic("images/chars/" + curchar.key + ".png");
// 		bff.frames = Paths.getSparrowAtlas('chars/' + curchar.key);
// 		bff.animation.addByPrefix('idle', 'idle0', 16, true);
// 		bff.animation.addByPrefix('up', 'up0', 16, false);
// 		bff.animation.addByPrefix('left', 'left0', 16, false);
// 		bff.animation.addByPrefix('down', 'down0', 16, false);
// 		bff.animation.addByPrefix('right', 'right0', 16, false);
// 		bff.animation.play('idle');

// 		if (index == 1 || index == 4) {
// 			bff.scale.set(0.75, 0.75);
// 		} else {
// 			bff.scale.set(1, 1);
// 		}
// 	};
// 	add(curchar);

// 	hideHud.onChange = function(index:Int) {
// 		if (index == 1) {
// 			verde.alpha = 1;
// 			curchar.y = 635;
// 			hideHud.y = 675;
// 			hideHud.x = 10;
// 			curchar.x = 10;
// 		} else {
// 			verde.alpha = 0;
// 			curchar.y = 440;
// 			hideHud.y = 480;
// 			hideHud.x = 50;
// 			curchar.x = 250;
// 		}
// 	}

// 	hideHud.camera = FlxG.camera;
// 	add(hideHud);
// }

// // load dp data
// function loadValuesFromFile(name:String) {
// 	var folder = "addons/rtxlight/values/";
// 	var path = folder + name + ".txt";
// 	// trace(" archivo: " + path);
// 	if (!FileSystem.exists(path)) {
// 		// trace("Archivo no existe.");
// 		return;
// 	}
// 	try {
// 		var raw = File.getContent(path);
// 		if (raw == null) {
// 			// trace("ERROR: getContent null");
// 			return;
// 		}
// 		var content = StringTools.trim(raw);
// 		var parts = content.split(",");
// 		var values:Array<Float> = [];
// 		for (part in parts) {
// 			var trimmed = StringTools.trim(part);
// 			if (trimmed.length > 0) {
// 				values.push(Std.parseFloat(trimmed));
// 			}
// 		}
// 		// trace("Valores cargados: " + values);

// 		var sliders = [
// 			topMaskR,
// 			topMaskG,
// 			topMaskB,
// 			topMaskA,
// 			spriteColR,
// 			spriteColG,
// 			spriteColB,
// 			spriteColA,
// 			lightColR,
// 			lightColG,
// 			lightColB,
// 			lightColA,
// 			lightnalge,
// 			lightSize,
// 			numOfLay,
// 			laySepa
// 		];
// 		for (i in 0...values.length) {
// 			sliders[i].value = values[i];
// 		}
// 		valueID.label.text = name;
// 		shaderParms.mask_Color_R = values[0];
// 		shaderParms.mask_Color_G = values[1];
// 		shaderParms.mask_Color_B = values[2];
// 		shaderParms.mask_Color_A = values[3];

// 		shaderParms.sprite_Color_R = values[4];
// 		shaderParms.sprite_Color_G = values[5];
// 		shaderParms.sprite_Color_B = values[6];
// 		shaderParms.sprite_Color_A = values[7];

// 		shaderParms.light_Color_R = values[8];
// 		shaderParms.light_Color_G = values[9];
// 		shaderParms.light_Color_B = values[10];
// 		shaderParms.light_Color_A = values[11];

// 		shaderParms.light_Angle = values[12];
// 		shaderParms.light_Size = values[13];
// 		shaderParms.number_Of_Layers = values[14];
// 		shaderParms.layer_Separation = values[15];
// 	} catch (e:Dynamic) {
// 		// trace("ERROR LEYENDO ARCHIVO:");
// 		// trace(e);
// 	}
// }

// function postUpdate(elapsed:Float):Void {
// 	// leave
// 	if (FlxG.keys.pressed.ESCAPE)
// 		if (FlxG.save.data.wn == false) {
// 			exitconfirm();
// 		} else {
// 			// FlxG.switchState(new MainMenuState());
// 			// CoolUtil.playMenuSFX(2);
// 			// DiscordUtil.changePresence("In the Menus");

// 			FlxG.switchState(new EditorTreeMenu(null, true, "no"));
// 		}

// // Variable de clase
// var animationTimer:FlxTimer = null;

// // Función helper
// function playAnimationWithTimer(animName:String):Void {
//     if (animationTimer != null) animationTimer.cancel();
    
//     bff.animation.play(animName);
//     animationTimer = new FlxTimer().start(1, function(tmr:FlxTimer) {
//         bff.animation.play('idle');
//         animationTimer = null;
//     });
// }

// // En tu código
// if (FlxG.keys.pressed.A) playAnimationWithTimer('left');
// else if (FlxG.keys.pressed.S) playAnimationWithTimer('down');
// else if (FlxG.keys.pressed.D) playAnimationWithTimer('right');
// else if (FlxG.keys.pressed.W) playAnimationWithTimer('up');

// 	// move character
// 	// Velocidad base del movimiento
// 	var speed:Float = 200;
// 	// Multiplicador si mantienes SHIFT
// 	var mult:Float = FlxG.keys.pressed.SHIFT ? 3 : 1;

// 	// --- CONFIGURACIÓN DEL DESLIZ (HIELO) ---
// 	// Cuanto más grande el valor, MÁS rápido se frena
// 	// Cuanto más chico, MÁS se desliza
// 	bff.drag.set(1000 - (FlxG.save.data.slide * 100), 1000 - (FlxG.save.data.slide * 100));

// 	// Si quieres MÁS hielo usa:
// 	//// bff.drag.set(200, 200);

// 	// Si quieres MENOS hielo usa:
// 	//// bff.drag.set(800, 800);

// 	// -----------------------------------------

// 	// NO reseteamos la velocidad aquí.
// 	// Dejamos que el drag haga su magia.
// 	var vx = 0.0;
// 	var vy = 0.0;

// 	// Movimiento normal
// 	if (FlxG.keys.pressed.LEFT)
// 		vx -= speed * mult;
// 	if (FlxG.keys.pressed.RIGHT)
// 		vx += speed * mult;
// 	if (FlxG.keys.pressed.UP)
// 		vy -= speed * mult;
// 	if (FlxG.keys.pressed.DOWN)
// 		vy += speed * mult;

// 	// Solo aplicamos velocidad si se está presionando algo
// 	// Para que al soltar, se deslice
// 	if (vx != 0 || vy != 0) {
// 		bff.velocity.set(vx, vy);
// 	}

// 	var fx = flecha.x + flecha.width * 0.5;
// 	var fy = flecha.y + flecha.height * 0.5;

// 	var bx = bff.x + bff.width * 0.5;
// 	var by = bff.y + bff.height * 0.5;

// 	var dx = bx - fx;
// 	var dy = by - fy;

// 	flecha.angle = Math.atan2(dy, dx) * 180 / Math.PI;

// 	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.ONE) {
// 		var campos = ["mask_Color_R", "mask_Color_A", "mask_Color_B", "mask_Color_G"];
// 		var sliders = [topMaskR, topMaskA, topMaskB, topMaskG];
// 		for (i in 0...campos.length) {
// 			Reflect.setField(shaderParms, campos[i], 0);
// 			sliders[i].value = 0;
// 		}
// 	}

// 	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.TWO) {
// 		var campos = ["sprite_Color_R", "sprite_Color_G", "sprite_Color_B", "sprite_Color_A"];
// 		var sliders = [spriteColR, spriteColG, spriteColB, spriteColA];
// 		for (i in 0...campos.length) {
// 			Reflect.setField(shaderParms, campos[i], 0);
// 			sliders[i].value = 0;
// 		}
// 	}

// 	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.THREE) {
// 		var campos = ["light_Color_R", "light_Color_G", "light_Color_B", "light_Color_A"];
// 		var sliders = [lightColR, lightColG, lightColB, lightColA];
// 		for (i in 0...campos.length) {
// 			Reflect.setField(shaderParms, campos[i], 0);
// 			sliders[i].value = 0;
// 		}
// 	}

// 	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.FOUR) {
// 		var campos = ["light_Angle", "light_Size", "number_Of_Layers", "layer_Separation"];
// 		var sliders = [lightnalge, lightSize, numOfLay, laySepa];
// 		for (i in 0...campos.length) {
// 			Reflect.setField(shaderParms, campos[i], 0);
// 			sliders[i].value = 0;
// 		}
// 	}

// 	if (FlxG.keys.pressed.R && FlxG.keys.justPressed.FIVE) {
// 		var campos = [
// 			"sprite_Color_R", "sprite_Color_G",   "sprite_Color_B", "sprite_Color_A",
// 			  "mask_Color_R",   "mask_Color_A",     "mask_Color_B",   "mask_Color_G",
// 			 "light_Color_R",  "light_Color_G",    "light_Color_B",  "light_Color_A",
// 			   "light_Angle",     "light_Size", "number_Of_Layers", "layer_Separation"
// 		];
// 		var sliders = [
// 			lightnalge,
// 			lightSize,
// 			numOfLay,
// 			laySepa,
// 			lightColR,
// 			lightColG,
// 			lightColB,
// 			lightColA,
// 			spriteColR,
// 			spriteColG,
// 			spriteColB,
// 			spriteColA,
// 			topMaskR,
// 			topMaskA,
// 			topMaskB,
// 			topMaskG
// 		];
// 		for (i in 0...campos.length) {
// 			Reflect.setField(shaderParms, campos[i], 0);
// 			sliders[i].value = 0;
// 		}
// 	}

// 	// Aply and uptade the shader
// 	bff.shader.overlayColor = [
// 		shaderParms.mask_Color_R,
// 		shaderParms.mask_Color_G,
// 		shaderParms.mask_Color_B,
// 		shaderParms.mask_Color_A
// 	];
// 	bff.shader.satinColor = [
// 		shaderParms.sprite_Color_R,
// 		shaderParms.sprite_Color_G,
// 		shaderParms.sprite_Color_B,
// 		shaderParms.sprite_Color_A
// 	];
// 	bff.shader.innerShadowColor = [
// 		shaderParms.light_Color_R,
// 		shaderParms.light_Color_G,
// 		shaderParms.light_Color_B,
// 		shaderParms.light_Color_A
// 	];
// 	bff.shader.innerShadowAngle = (shaderParms.light_Angle - 90) * Math.PI / 180;
// 	bff.shader.innerShadowDistance = shaderParms.light_Size;
// 	bff.shader.layernumbers = shaderParms.number_Of_Layers;
// 	bff.shader.layerseparation = shaderParms.layer_Separation;

// 	// Uptade the texts of the shader values on the event
// 	topMasCol.text = Math.round(shaderParms.mask_Color_R * 100) / 100 + "," + Math.round(shaderParms.mask_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.mask_Color_B * 100) / 100 + "," + Math.round(shaderParms.mask_Color_A * 100) / 100;
// 	spriteCol.text = Math.round(shaderParms.sprite_Color_R * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.sprite_Color_B * 100) / 100 + "," + Math.round(shaderParms.sprite_Color_A * 100) / 100;
// 	lightCol.text = Math.round(shaderParms.light_Color_R * 100) / 100 + "," + Math.round(shaderParms.light_Color_G * 100) / 100 + ","
// 		+ Math.round(shaderParms.light_Color_B * 100) / 100 + "," + Math.round(shaderParms.light_Color_A * 100) / 100;
// 	nalgle.text = Math.floor(shaderParms.light_Angle);
// 	sizex.text = Math.floor(shaderParms.light_Size);
// 	numLay.text = Math.floor(shaderParms.number_Of_Layers);
// 	laySep.text = Math.floor(shaderParms.layer_Separation);
// }

// // warning thing
// function exitconfirm() {
// 	var buttons:Array<WarningButton> = [
// 		{
// 			label: texts[num][6],
// 			color: 0xFFFF00,
// 			onClick: function(warning) {
// 				warning.close();
// 			}
// 		},
// 		{
// 			label: texts[num][7],
// 			color: 0xFFFF00,
// 			onClick: function(warning) {
// 				warning.close();
// 				FlxG.switchState(new EditorTreeMenu(null, true, "no"));
// 				CoolUtil.playMenuSFX(2);
// 				DiscordUtil.changePresence("In the Menus");
// 			}
// 		}
// 	];
// 	var errorPopup = new UIWarningSubstate(texts[num][8], texts[num][9], buttons, false);
// 	openSubState(errorPopup);
// }

