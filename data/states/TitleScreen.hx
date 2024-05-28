import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;

function create(){
		
    disclaimer = new FlxSprite().loadGraphic(Paths.image('menus/intro/disclaimer'));
	disclaimer.setGraphicSize(Std.int(disclaimer.width * 6));
	disclaimer.updateHitbox();
	disclaimer.antialiasing = false;
	disclaimer.visible = true;
	add(disclaimer);

	new FlxTimer().start(0.2, ()->{ startIntro(); }, 1);
}

function startIntro()
{
	disclaimer.visible = false;

    var bg = new FlxBackdrop(Paths.image('menus/intro/bg'), 0, 0, true, false, 0, 0);
    bg.velocity.set(-25, 0);
    bg.setGraphicSize(Std.int(bg.width * 6));
	bg.updateHitbox();
	bg.antialiasing = false;
    add(bg);

	//bgPos = new FlxPoint();

	var infoText:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/intro/spare-me-ninjas'));
	infoText.setGraphicSize(Std.int(infoText.width * 6));
	infoText.updateHitbox();
	infoText.antialiasing = false;
	add(infoText);

	titleText = new FlxSprite().loadGraphic(Paths.image('menus/intro/title-text'));
	titleText.setGraphicSize(Std.int(titleText.width * 6));
	titleText.updateHitbox();
	titleText.antialiasing = false;
	titleText.alpha = 0;
	titleText.visible = false;
	add(titleText);

	logo = new FlxSprite(14 * 6, 7 * 6);
	logo.frames = Paths.getSparrowAtlas('menus/intro/logo');
	logo.animation.addByPrefix('flash', 'flash', 18, true);
	logo.animation.addByPrefix('idle', 'idle', 24, true);

	//logo.animation.add("flash", [0, 1, 2, 1], 18);
	logo.setGraphicSize(Std.int(logo.width * 6));
	logo.updateHitbox();
	logo.antialiasing = false;
	add(logo);

	logoY = -76;
	bounces = 6;

	deluxe = new FlxSprite(74 * 6, 44 * 6).loadGraphic(Paths.image('menus/intro/deluxe'), true, 80, 28);
	deluxe.animation.add('write', [0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 14, false);

	deluxe.setGraphicSize(Std.int(deluxe.width * 6));
	deluxe.updateHitbox();
	deluxe.antialiasing = false;
	add(deluxe);

	sparkle = new FlxSprite(91 * 6, 31 * 6).loadGraphic(Paths.image('menus/intro/sparkle'), true, 16, 24);
	sparkle.animation.add('sparkle', [1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 16, true);

	sparkle.setGraphicSize(Std.int(sparkle.width * 6));
	sparkle.updateHitbox();
	sparkle.antialiasing = false;
	add(sparkle);
}

function update()
{
	if  (controls.ACCEPT)	
		FlxG.switchState(new MainMenuState());
}