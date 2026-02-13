import flixel.math.FlxMath;
import funkin.editors.ui.UISubstateWindow;
import funkin.editors.ui.UIText;
import funkin.editors.ui.UITextBox;
import funkin.editors.ui.UIButton;
import funkin.editors.ui.UIFileExplorer;
import funkin.editors.ui.UIDropDown;
//import funkin.editors.ui.UICheckbox;
import sys.io.File;
import haxe.io.Bytes;

var sectionStartStepper:UITextBox;
var fileExplorer:UIFileExplorer;
var dropdown:UIDropDown;
var errorText:UIText;
var fileNameInput:UITextBox;
//var useAfterImportCheckbox:UICheckbox;

function postCreate() {
    createLabels();
    createTextInput();
    createDropdown();
    createFileExplorer();
    createErrorText();
    createFileNameInput();
    //createCheckbox();
    createButtons();
}

function createLabels() {
    add(new UIText(175, 55, 500, "From:", 20));
    add(new UIText(165, 150, 500, "Input: ", 20));
    add(new UIText(115, 250, 500, "Import As:", 20));
}

function createTextInput() {
    sectionStartStepper = new UITextBox(240, 150,"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",290, 32,false, false);
    add(sectionStartStepper);
}

function createDropdown() {
    dropdown = new UIDropDown(240, 50,320, 32,["Text", "File"],0);
    dropdown.onChange = function(nuevoIndice:Int) {
        //trace("Seleccionaste: " + dropdown.key);
        //trace("Índice: " + nuevoIndice);
        var esTexto = (nuevoIndice == 0);
        sectionStartStepper.visible = sectionStartStepper.selectable = esTexto;
        fileExplorer.visible = fileExplorer.selectable = !esTexto;
        errorText.text = "";	};
    add(dropdown);
}

function createFileExplorer() {
    fileExplorer = new UIFileExplorer(240, 145,320, 48,"txt",onFileSelected);
    fileExplorer.visible = fileExplorer.selectable = false;
    add(fileExplorer);
}

function createErrorText() {
    errorText = new UIText(250, 210, 500, "", 16);
    errorText.color = 0xFFFF0000;
    add(errorText);
}

function createFileNameInput() {
    fileNameInput = new UITextBox(240, 245,"my_preset",290, 32,false, false);
    add(fileNameInput);
}

// function createCheckbox() {
//     useAfterImportCheckbox = new UICheckbox(
//         240, 290,
//         "Use after import?",
//         false,
//         250,
//         false
//     );
    
//     useAfterImportCheckbox.checked = function(isChecked:Bool) {
//         //("Use after import: " + isChecked);
//         // Aquí puedes agregar tu lógica
//     };
    
//     add(useAfterImportCheckbox);
// }

function createButtons() {
   
    var closeButton = new UIButton(380, 350,"Close",onCloseClick,125);
    closeButton.color = 0xFFFF0000;
    closeButton.x -= closeButton.bWidth;
    add(closeButton);

    var importButton = new UIButton(520, 350,"Import",onImportClick,125);
    importButton.x -= importButton.bWidth;
    add(importButton);
}

function validateNumbers(text:String):Bool {
    text = StringTools.trim(text);
    var parts = text.split(",");
    if (parts.length != 16) {
        errorText.text = "Error: Invalid Input";
        return false;	}
    for (i in 0...parts.length) {
        var part = StringTools.trim(parts[i]);
        var num = Std.parseFloat(part);
        if (Math.isNaN(num)) {
            errorText.text = "Error: Invalid Input";
            return false;
        }}
    
    errorText.text = "";
    return true;
}

function validateFileName(fileName:String):Bool {
    fileName = StringTools.trim(fileName);
    if (fileName.length == 0) {
        errorText.text = "Name cannot be empty";
        return false;	}
    var invalidChars = ['/', '\\', ':', '*', '?', '"', '<', '>', '|'];
    for (char in invalidChars) {
        if (fileName.indexOf(char) != -1) {
            errorText.text = "Name contains invalid characters";
            return false;	}}
    return true;
}

function onFileSelected(path:String, bytes:Bytes) {
    if (path != null && bytes != null) {
        //trace("Archivo seleccionado: " + path);
        var contenido = bytes.toString();
        if (validateNumbers(contenido)) {
            //trace("Archivo válido: 16 números detectados");
        }} else {
        errorText.text = "";	}}

function onCloseClick() {
    close();
}

function onImportClick() {
    var contenido:String = "";
    if (dropdown.index == 0) {
        contenido = sectionStartStepper.label.text;
    } else {
        if (fileExplorer.file != null) {
            contenido = fileExplorer.file.toString();
        } else {
            errorText.text = "No File Selected";
            return;
        }}
    
    if (!validateNumbers(contenido)) {
        return;
    }
    
    var fileName = StringTools.trim(fileNameInput.label.text);
    if (!validateFileName(fileName)) {
        return;
    }
    
    var fullPath = "addons/rtxlight/values/" + fileName + ".txt";
    File.saveContent(fullPath, contenido);

    // if (useAfterImportCheckbox.checked) {
    //     var otherFilePath = "addons/rtxlight/other/useifimport.txt";
    //     var useStatus = useAfterImportCheckbox.checked ? "true" : "false";
    //     var otherContent = fileName + "," + useStatus;
    //     File.saveContent(otherFilePath, otherContent);
    // }
    
    close();
}