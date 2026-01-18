import funkin.options.type.TextOption;
import funkin.options.TreeMenuScreen;
import funkin.editors.ui.UIState;
import Sys;
import funkin.editors.ui.UIWarningSubstate;

var num = 0;
var texts:Array<Array<String>> = [
    ["Editor","Enter to the editor","Guide","How to use the editor","Saved shaders","Open the saved shaders folder","Things for this tool","In Progress","The guide is still in progress.\nPlease wait for more updates.\n\n- Edwin","Backups","Open the backups folder","CNE Server","Go to the CNE discord server"],
    ["Editor","Entrar al editor","Guía","Cómo usar el editor","Shaders guardados","Abrir la carpeta de shaders guardados","Herramientas para esta utilidad","En progreso","La guía aún está en desarrollo.\nPor favor espera más actualizaciones.\n\n- Edwin","Copias de seguridad","Abre la carpeta de copias de seguridad","Servidor de CNE","Ve al servidor de discord de CNE"]

];


if (FlxG.save.data.langs == "esp"){
num = 1;
}



function create() {
    var list = [
        new TextOption(texts[num][0], texts[num][1], ' >', () -> {
            FlxG.switchState(new UIState(true, "idk"));
            }),
        new TextOption(texts[num][2], texts[num][3], ' >', () -> {
            nel();
            //openSubState(new ModSubState("test"));
            }),
        new TextOption(texts[num][4], texts[num][5], ' >', () -> {
            Sys.command('explorer', ["addons\\rtxlight\\values\\"]);
        }),
        new TextOption(texts[num][9], texts[num][10], ' >', () -> {
            Sys.command('explorer', ["addons\\rtxlight\\backups\\"]);
        }),
        new TextOption(texts[num][11], texts[num][12], ' >', () -> {
            CoolUtil.openURL('https://discord.gg/NqT8mau5VR');
        })
    ];
        
        addMenu(new TreeMenuScreen('Shadeinator', texts[num][6], '', list));
}

function nel() {
	var buttons:Array<WarningButton> = [{
			label: "Ok",
			color: 0xFFFF00,
			onClick: function(warning) {
				warning.close();
			}}];
	var errorPopup = new UIWarningSubstate(texts[num][7],
		texts[num][8], buttons, false);
	openSubState(errorPopup);
}
