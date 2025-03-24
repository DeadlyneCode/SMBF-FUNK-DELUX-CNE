import funkin.backend.utils.CoolUtil;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;

var mainMenuItems:Array<String> = ['STORY MODE', 'FREEPLAY', 'OPTIONS', 'EXTRAS'];
var storySubmenuItems:Array<String> = ['WEEK1', 'WEEK2', 'BACK'];
var menuItems:Array<String> = mainMenuItems;
var menuTexts:FlxTypedGroup;
var curSelected:Int = 0;
var canSwitch:Bool = true;
var inSubMenu:Bool = false;

function create(){
    CoolUtil.playMenuSong();

    var bg = new FlxBackdrop(Paths.image('menus/title/bg'));
    bg.velocity.x = -50;
    bg.setGraphicSize(Std.int(bg.width * 6));
    bg.updateHitbox();
    bg.antialiasing = false;
    add(bg);

    thumbnail = new FlxSprite(103 * 6, 38 * 6).loadGraphic(Paths.image('menus/title/thumbnails'), true, 46, 46);
    thumbnail.animation.add('idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0, false);
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

    var main:FlxText = new FlxText(455, 39 , 0, "MAIN MENU", 32);
    main.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
    main.setGraphicSize(Std.int(main.width * 6));
    add(main);

    var vers:FlxText = new FlxText(840, 668 , 0, "V2.0", 32);
    vers.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
    vers.setGraphicSize(Std.int(main.width * 7.5));
    add(vers);

    version = new FlxSprite(735, 349);
    version.loadGraphic(Paths.image('menus/title/cube'));
    version.setGraphicSize(Std.int(version.width * 5.9));
    version.antialiasing = false;
    add(version);

    selector = new FlxSprite(32, 220).loadGraphic(Paths.image('menus/title/selector'));
    selector.setGraphicSize(Std.int(selector.width * 6));
    selector.antialiasing = false;
    add(selector);

    menuTexts = new FlxTypedGroup();
    add(menuTexts);

    updateMenuTexts();
    changeSelect(0);
}

function updateMenuTexts(){
    menuTexts.clear();
    for (i in 0...menuItems.length) {
        var menuText:FlxText = new FlxText(60, 176 + i * 96, 0, menuItems[i], 8);
        menuText.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
        menuText.setGraphicSize(Std.int(menuText.width * 6));
        menuText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1, 1);
        menuText.updateHitbox();
        menuText.ID = i;
        menuTexts.add(menuText);
    }
}

function update(elapsed:Float):Void {
    if (FlxG.keys.justPressed.SEVEN) {
        persistentUpdate = false;
        persistentDraw = true;
        openSubState(new EditorPicker());
    }
    
    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
    
    if (canSwitch) {
        if (controls.BACK) {
            if (inSubMenu) {
                inSubMenu = false;
                menuItems = mainMenuItems;
                curSelected = 0;
                updateMenuTexts();
                changeSelect(0);
            } else {
                backTitle();
            }
        }
        if (controls.UP_P) changeSelect(-1);
        if (controls.DOWN_P) changeSelect(1);
        if (controls.ACCEPT) confirmSelect();
    }
}

function changeSelect(change:Int):Void {
    curSelected += change;
    
    if (curSelected >= menuItems.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = menuItems.length - 1;

    if (inSubMenu) {
        thumbnail.animation.frameIndex = 7 + curSelected;
    } else {
        thumbnail.animation.frameIndex = curSelected;
    }    
    selector.y = 220 + curSelected * 96;
}

function confirmSelect():Void {
    canSwitch = false;

    for (spr in menuTexts)
        if (curSelected == spr.ID)
            FlxFlicker.flicker(spr, 1, 0.05);

    new FlxTimer().start(1, () -> switch(menuItems[curSelected]) {
        case 'STORY MODE':
            inSubMenu = true;
            menuItems = storySubmenuItems;
            curSelected = 0;
            updateMenuTexts();
            changeSelect(0);
            canSwitch = true; 

        case 'FREEPLAY':
            FlxG.switchState(new FreeplayState());

        case 'OPTIONS':
            FlxG.switchState(new OptionsMenu());

        case 'EXTRAS':
            FlxG.switchState(new FreeplayState());

        case 'WEEK 1':
            trace("Lancement de WEEK 1");
        
        case 'WEEK 2':
            trace("Lancement de WEEK 2");

        case 'BACK':
            inSubMenu = false;
            menuItems = mainMenuItems;
            curSelected = 0;
            updateMenuTexts();
            changeSelect(0);
            canSwitch = true;
    });
}

function backTitle():Void {
    canSwitch = false;
    FlxG.switchState(new TitleState());
}
