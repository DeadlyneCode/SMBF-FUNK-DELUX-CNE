import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;

var menuItems:Array<String> = ['STORY MODE', 'FREEPLAY', 'OPTIONS', 'EXTRAS'];
var curArray:Array<String>;
var grpMenuShit2:FlxTypedGroup<FlxText>();
var grpMenuShit:FlxTypedGroup<FlxText>();

function create(){

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

    curArray = menuItems;
	addMenuItems();

    grpMenuShit2 = new FlxTypedGroup();
    add(grpMenuShit2);

    grpMenuShit = new FlxTypedGroup();
    add(grpMenuShit);

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

}

function addMenuItems()
	{
		grpMenuShit.clear();
		grpMenuShit2.clear();
		for (i in 0...curArray.length)
		{
			var songText:FlxText = new FlxText(10 * 6, (16 * 6 * i) + (29 * 6), 0, curArray[i], 8);
			songText.scrollFactor.set();
			songText.setFormat(Paths.font("smb1.ttf"), 8);
			songText.setGraphicSize(Std.int(songText.width * 6));
			songText.updateHitbox();

			var songText2:FlxText = new FlxText(0, 0, 0, curArray[i], 8);
			songText2.scrollFactor.set();
			songText2.setFormat(Paths.font("smb1.ttf"), 8);
			songText2.setGraphicSize(Std.int(songText2.width * 6));
			songText2.updateHitbox();
			songText2.x = songText.x + 1 * 6;
			songText2.y = songText.y + 1 * 6;
			songText2.color = 0x000000;

			grpMenuShit2.add(songText2);
			grpMenuShit.add(songText);

			canControl = true;
		}
	}


function update (elapsed){

    switch (curSelected){
        case 0:

        case 1:

        case 2:

        case 3:

    }
    if (FlxG.keys.justPressed.RIGHT)
        changeSelection(1);
    if (FlxG.keys.justPressed.LEFT)
        changeSelection(-1);

}

function changeSelection(change) 
    {
        curSelected += change;
    
        if (curSelected >= names.length)
            curSelected = 0;
        if (curSelected <0)
            curSelected = names.length-1;
    }