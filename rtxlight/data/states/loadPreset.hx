import flixel.math.FlxMath;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UIButton;
import sys.io.File;
import sys.FileSystem;
import funkin.editors.ui.UIDropDown;
import flixel.tweens.FlxTween;

var sectionStartStepper = null;
var numb = 0;

function getValueFiles():Array<String> {
	var folder = "addons/rtxlight/values/";
	var files = [];
	if (FileSystem.exists(folder)) {
		for (f in FileSystem.readDirectory(folder)) {
			if (StringTools.endsWith(f, ".txt")) {
				files.push(f.substr(0, f.length - 4));
			}}}
	return files;
}

var fileNames = getValueFiles();
var colorDropdown = new UIDropDown(50, 100, 300, 32, fileNames, 0);

function loadValuesFromFile(name:String) {
	var folder = "addons/rtxlight/values/";
	var path = folder + name + ".txt";
	//trace(" archivo: " + path);
}
var saveb = null;

function postCreate() {

	add(new UIText(50, 75, 500, "Load Shader",20));

	colorDropdown.onChange = function(index:Int) {
	var selectedFile = fileNames[index];
	numb = index;
	// trace("Archivo seleccionado: " + selectedFile);
	loadValuesFromFile(selectedFile);
	};
	add(colorDropdown);

    var closeButton = new UIButton(180, 160, "Close", function() {
	File.saveContent("addons/rtxlight/other/loadpreset.txt","false");
	close();
	}, 125);
	add(closeButton);
	closeButton.color = 0xFFFF0000;
	closeButton.x -= closeButton.bWidth;

	saveb = new UIButton(320, 160, "Load", function() {
	File.saveContent("addons/rtxlight/other/toload.txt",fileNames[numb]);
	if (numb != 0){
	File.saveContent("addons/rtxlight/other/loadpreset.txt","true");
	close();
	}
	}, 125);
	add(saveb);
	saveb.x -= saveb.bWidth;



}


