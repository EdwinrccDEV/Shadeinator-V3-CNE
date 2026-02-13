import flixel.math.FlxMath;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UITextBox;
import funkin.editors.ui.UIButton;
import sys.io.File;

var sectionStartStepper = null;

function postCreate() {

	  var path = "addons/rtxlight/other/saveAs.txt";
        var content = File.getContent(path);
        //trace("Contenido del preset: " + content);

	add(new UIText(50, 75, 500, "Shader Name",20));
       // new(x, y, text, width:Int = 320, height:Int = 32, multiline:Bool = false, small:Bool = false
	sectionStartStepper = new UITextBox(50, 100, "Name", 290, 32, false, false);
	add(sectionStartStepper);

    var closeButton = new UIButton(180, 160, "Close", function() {
	close();
	}, 125);
	add(closeButton);
	closeButton.color = 0xFFFF0000;
	closeButton.x -= closeButton.bWidth;

	var saveb = new UIButton(320, 160, "Save", function() {
	File.saveContent("addons/rtxlight/values/" + sectionStartStepper.label.text + ".txt", content);
	close();
	}, 125);
	add(saveb);
	//saveb.color = 0xFFFF0000;
	saveb.x -= saveb.bWidth;

}