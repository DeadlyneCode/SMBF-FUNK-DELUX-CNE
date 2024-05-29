import funkin.backend.utils.CoolUtil;

import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;

import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;

import funkin.options.OptionsMenu;

var menuItems:Array<String> = ['STORY MODE', 'FREEPLAY', 'OPTIONS', 'EXTRAS'];
var menuTexts:FlxTypedGroup;
var curSelected = 0;
var canSwitch = true;

function create(){

    CoolUtil.playMenuSong();

    var bg = new FlxBackdrop(Paths.image('menus/title/bg'));
    bg.velocity.x = -100;
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

	menuTexts = new FlxTypedGroup();
	add(menuTexts);

    for (i in 0...menuItems.length)
    {
        var menuText:FlxText = new FlxText(60, 176 + i * 96, 0, menuItems[i], 8);
        menuText.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
        menuText.setGraphicSize(Std.int(menuText.width * 6));
        menuText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1, 1);
        menuText.updateHitbox();
        menuText.ID = i;
        menuTexts.add(menuText);
    }

    changeSelect(0);
}

function update (elapsed)
{
	if (FlxG.keys.justPressed.SEVEN)
    {
        persistentUpdate = false;
        persistentDraw = true;
        openSubState(new EditorPicker());
    }
    
    if (controls.SWITCHMOD)
    {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

    
    if (canSwitch)
    {
        if (controls.UP_P) changeSelect(-1);
        if (controls.DOWN_P) changeSelect(1);
        if (controls.ACCEPT) confirmSelect();
    }
}

function changeSelect(change) 
{
    curSelected += change;
    
    if (curSelected >= menuItems.length)
        curSelected = 0;
    if (curSelected <0)
        curSelected = menuItems.length-1;

    thumbnail.animation.frameIndex = curSelected;
    selector.y = 220 + curSelected * 96;
}

function confirmSelect()
{
    canSwitch = false;

    for (spr in menuTexts)
        if (curSelected == spr.ID) FlxFlicker.flicker(spr, 1, 0.05);

    new FlxTimer().start(1, () -> switch(menuItems[curSelected])
    {
        case 'STORY MODE':
            FlxG.switchState(new StoryMenuState());

        case 'FREEPLAY':
            FlxG.switchState(new FreeplayState());

        case 'OPTIONS':
            FlxG.switchState(new OptionsMenu());

        case 'EXTRAS':
            FlxG.switchState(new FreeplayState());
    });
}