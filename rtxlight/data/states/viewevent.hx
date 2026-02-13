import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;

var nalgle = 0;
var topMasCol = "0,0,0,0";
var spriteCol = "0,0,0,0";
var lightCol = "0,0,0,0";
var sizex = 0;
var numLay = 0;
var laySep = 0;
var addin = -75;


function postCreate() {

	var playerSprite:FlxSprite = new FlxSprite(950, 0);
	playerSprite.loadGraphic("images/event.png");
	add(playerSprite);
	playerSprite.scale.set(1, 1);
	playerSprite.camera = FlxG.camera;

	topMasCol = new FunkinText(960, 105 + addin, 250, "0,0,0,0", 20);
	topMasCol.alignment = "left";
	add(topMasCol);
	spriteCol = new FunkinText(960, 163 + addin, 250, "0,0,0,0", 20);
	spriteCol.alignment = "left";
	add(spriteCol);
	lightCol = new FunkinText(960, 163 + 58 + addin, 250, "0,0,0,0", 20);
	lightCol.alignment = "left";
	add(lightCol);
	nalgle = new FunkinText(960, 278 + addin, 100, "0", 20);
	nalgle.alignment = "left";
	add(nalgle);
	sizex = new FunkinText(960, 337 + addin, 100, "0", 20);
	sizex.alignment = "left";
	add(sizex);
	numLay = new FunkinText(960, 437 + addin, 100, "0", 20);
	numLay.alignment = "left";
	add(numLay);
	laySep = new FunkinText(960, 495 + addin, 100, "0", 20);
	laySep.alignment = "left";
	add(laySep);

}
