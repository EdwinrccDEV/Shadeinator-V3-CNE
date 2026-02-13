import flixel.math.FlxMath;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UITextBox;
import funkin.editors.ui.UIButton;
import sys.io.File;

var sectionStartStepper = null;
var characterID = null;
var filename = null;

function postCreate() {


	add(new UIText(30, 75, 500, "StrumLines ID",20));
	add(new UIText(230, 75, 500, "Characters ID",20));
	add(new UIText(430, 75, 500, "File Name",20));
       
	sectionStartStepper = new UITextBox(30, 100, "0,1,2", 150, 32, false, false);
	add(sectionStartStepper);

	characterID = new UITextBox(230, 100, "0,0,0", 150, 32, false, false);
	add(characterID);

	filename = new UITextBox(430, 100, "My Script", 200, 32, false, false);
	add(filename);

    var closeButton = new UIButton(300, 160, "Close", function() {
	close();
	}, 125);
	add(closeButton);
	closeButton.color = 0xFFFF0000;
	closeButton.x -= closeButton.bWidth;

	var saveb = new UIButton(500, 160, "Make", function() {
	File.saveContent("addons/rtxlight/other/strums.txt", sectionStartStepper.label.text);
	File.saveContent("addons/rtxlight/other/chars.txt", characterID.label.text);
	File.saveContent("addons/rtxlight/other/filename.txt", filename.label.text);
	close();
	}, 125);
	add(saveb);
	
	saveb.x -= saveb.bWidth;

}