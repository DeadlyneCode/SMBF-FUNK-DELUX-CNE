import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;

var menuItems:Array<String> = ['STORY MODE', 'FREEPLAY', 'OPTIONS', 'EXTRAS'];
var curSelected = 0;
var menuTexts:Array<FlxText> = [];

var startX:Float = 10 * 6;
var startY:Float = 16 * 11;
var spacing:Float = 12 * 8;

function create(){

    FlxG.sound.playMusic(Paths.music('fMenu'),0);

    if (FlxG.sound.music != null && FlxG.sound.music.volume == 0) {
		FlxG.sound.music.fadeIn(0.5, 0, 0.7);
		FlxG.sound.music.play();
	}

    var bg = new FlxBackdrop(Paths.image('menus/title/bg'), 0, 0, true, false, 0, 0);
    bg.velocity.set(-25, 0);
    bg.setGraphicSize(Std.int(bg.width * 6));
	bg.updateHitbox();
	bg.antialiasing = false;
    add(bg);

    thumbnail = new FlxSprite(103 * 6, 38 * 6).loadGraphic(Paths.image('menus/title/thumbnails'), true, 46, 46);
	thumbnail.animation.add('idle', [0, 1, 2, 3], 0, false);
	thumbnail.animation.play('idle');
	thumbnail.animation.frameIndex = 0;
	thumbnail.setGraphicSize(Std.int(thumbnail.width * 6));
	thumbnail.updateHitbox();
	thumbnail.antialiasing = false;
	add(thumbnail);

    bricks = new FlxSprite(0, 0);
    bricks.loadGraphic(Paths.image('menus/title/bricks'));
    bricks.setGraphicSize(Std.int(bricks.width * 6));
    bricks.updateHitbox();
    bricks.antialiasing = false;
    add(bricks);

    version = new FlxSprite(0, 0);
    version.loadGraphic(Paths.image('menus/title/info'));
    version.setGraphicSize(Std.int(version.width * 6));
    version.updateHitbox();
    version.antialiasing = false;
    add(version);

    selector = new FlxSprite(32, 220).loadGraphic(Paths.image('menus/title/selector'));
	selector.setGraphicSize(Std.int(selector.width * 6));
	selector.antialiasing = false;
	add(selector);

    for (i in 0...menuItems.length)
        {
            var menuTextWhite:FlxText = new FlxText(startX, startY + i * spacing, 0, menuItems[i], 8);
            menuTextWhite.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
            menuTextWhite.setGraphicSize(Std.int(menuTextWhite.width * 6));
            menuTextWhite.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1, 1);
            menuTextWhite.updateHitbox();
            add(menuTextWhite);

            menuTexts.push(menuTextWhite);
        }

}


function update (elapsed){

    switch (curSelected){
        case 0:
            thumbnail.animation.frameIndex = 0;
            selector.y = 220;
        case 1:
            thumbnail.animation.frameIndex = 1;
            selector.y = 310;
        case 2:
            thumbnail.animation.frameIndex = 2;
            selector.y = 410;
        case 3:
            thumbnail.animation.frameIndex = 3; 
            selector.y = 500;
    }
    
    if (FlxG.keys.justPressed.DOWN)
        changeSelection(1);
    if (FlxG.keys.justPressed.UP)
        changeSelection(-1);

}

function changeSelection(change) 
    {
        curSelected += change;
    
        if (curSelected >= menuItems.length)
            curSelected = 0;
        if (curSelected <0)
            curSelected = menuItems.length-1;
    }