import funkin.backend.utils.NativeAPI;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;
import flixel.FlxCamera;
import funkin.backend.utils.DiscordUtil;

FlxG.width = 960;
FlxG.height = 720;
FlxG.initialWidth = 960;
FlxG.initialHeight = 720;
window.resize(960, 720);

function destroy(){
  FlxG.width = 1280;
  FlxG.height = 720;
  FlxG.initialWidth = 1280;
  FlxG.initialHeight = 720;
  window.resize(1280, 720);
}

static var initialized:Bool = false;



function new(){
    //window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon'))));
}


static var redirectStates:Map<FlxState, String> = [
	TitleState => "TitleScreen",
    //MainMenuState => "MainMenuScreen",
    //FreeplayState => "FreeplayScreen",
];

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

function preStateSwitch() {
    window.title = "SMBF - DELUXE";
    FlxG.camera.bgColor = 0xFF000000;

	if (!initialized){
		initialized = true;
    }	else
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
