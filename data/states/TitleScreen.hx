import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;

var disclaimerTime = 0;

var nextFlash:Float = 0.75;

function create(){
		
    disclaimer = new FlxSprite().loadGraphic(Paths.image('menus/pixel/intro/disclaimer'));
	disclaimer.setGraphicSize(Std.int(disclaimer.width * 6));
	disclaimer.updateHitbox();
	disclaimer.antialiasing = false;
	add(disclaimer);
}

function startIntro(){
		persistentUpdate = true;

		disclaimer.visible = false;

		bg = new FlxSprite().loadGraphic(Paths.image('menus/pixel/intro/bg'));
		bg.setGraphicSize(Std.int(bg.width * 6));
		bg.updateHitbox();
		bg.antialiasing = false;
		add(bg);

		bg2 = new FlxSprite().loadGraphic(Paths.image('menus/pixel/intro/bg'));
		bg2.setGraphicSize(Std.int(bg2.width * 6));
		bg2.updateHitbox();
		bg2.antialiasing = false;
		add(bg2);

		//bgPos = new FlxPoint();

		var infoText:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/pixel/intro/spare-me-ninjas'));
		infoText.setGraphicSize(Std.int(infoText.width * 6));
		infoText.updateHitbox();
		infoText.antialiasing = false;
		add(infoText);

		titleText = new FlxSprite().loadGraphic(Paths.image('menus/pixel/intro/title-text'));
		titleText.setGraphicSize(Std.int(titleText.width * 6));
		titleText.updateHitbox();
		titleText.antialiasing = false;
		titleText.alpha = 0;
		titleText.visible = false;
		add(titleText);

		logo = new FlxSprite(14 * 6, 7 * 6);
		logo.frames = Paths.getSparrowAtlas('menus/pixel/intro/logo');
		logo.animation.addByPrefix('flash', 'flash', 18, true);
		logo.animation.addByPrefix('idle', 'idle', 24, true);

		//logo.animation.add("flash", [0, 1, 2, 1], 18);
		logo.setGraphicSize(Std.int(logo.width * 6));
		logo.updateHitbox();
		logo.antialiasing = false;
		add(logo);

		logoY = -76;
		bounces = 6;

		deluxe = new FlxSprite(74 * 6, 44 * 6).loadGraphic(Paths.image('menus/pixel/intro/deluxe'), true, 80, 28);
		deluxe.animation.add('write', [0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 14, false);

		deluxe.setGraphicSize(Std.int(deluxe.width * 6));
		deluxe.updateHitbox();
		deluxe.antialiasing = false;
		add(deluxe);

		sparkle = new FlxSprite(91 * 6, 31 * 6).loadGraphic(Paths.image('menus/pixel/intro/sparkle'), true, 16, 24);
		sparkle.animation.add('sparkle', [1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 16, true);

		sparkle.setGraphicSize(Std.int(sparkle.width * 6));
		sparkle.updateHitbox();
		sparkle.antialiasing = false;
		add(sparkle);
	}

function update(elapsed:Float){
    if (disclaimerTime > 2.5)
			startIntro();
    else
        disclaimerTime += elapsed;
    

    //trace(disclaimerTime);
}