import funkin.backend.utils.NativeAPI;

import lime.graphics.Image;

FlxG.width = 960;
FlxG.height = 720;
FlxG.initialWidth = 960;
FlxG.initialHeight = 720;
window.resize(960, 720);

static var redirectStates:Map<FlxState, String> = [
	TitleState => "TitleScreen",
    MainMenuState => "MainMenuScreen",
    //FreeplayState => "FreeplayScreen",
];

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

function preStateSwitch() {
    window.title = "Super Mario Bros: Funk Mix";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('iconEXE'))));

	for (redirectState in redirectStates.keys())
		if (FlxG.game._requestedState is redirectState)
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function destroy(){
    FlxG.width = 1280;
    FlxG.height = 720;
    FlxG.initialWidth = 1280;
    FlxG.initialHeight = 720;
    window.resize(1280, 720);
  }