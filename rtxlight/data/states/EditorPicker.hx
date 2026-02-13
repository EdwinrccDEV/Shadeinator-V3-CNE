import funkin.editors.EditorTreeMenu;
import flixel.effects.FlxFlicker;
import funkin.backend.utils.TranslationUtil;
import funkin.backend.utils.translations.FormatUtil;
import funkin.backend.MusicBeatState;
import funkin.editors.ui.UIState;
import funkin.backend.utils.DiscordUtil;

var index = -1;

function create() {
    DiscordUtil.changePresence("Shadeinater V3 (Chossing option)");
	options.push({
		name: "Shadeinator V3",
        id: "rtxeditorv3",
        onClick: enter
	});
	index = options.length - 1;
    TranslationUtil.alternativeStringMap.set("editor."+options[index].id+".name", FormatUtil.get(options[index].name));
}

function enter() {
    selected = true;
    CoolUtil.playMenuSFX(1);

    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;

    if (FlxG.sound.music != null) FlxG.sound.music.fadeOut(0.7, 0, () -> FlxG.sound.music.stop());

    sprites[curSelected].flicker(function() {
        subCam.fade(0xFF000000, 0.25, false, function() {
            FlxG.switchState(new EditorTreeMenu(null, true, "no"));
           //FlxG.switchState(new UIState(true, "no"));

        });
    });
}