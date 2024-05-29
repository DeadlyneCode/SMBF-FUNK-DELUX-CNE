import flixel.addons.display.FlxBackdrop;


function postCreate()
{
    var bg = new FlxBackdrop(Paths.image('menus/title/bg'));
    bg.velocity.x = -100;
    bg.setGraphicSize(Std.int(bg.width * 6));
	bg.updateHitbox();
	bg.antialiasing = false;
    insert(1, bg);

    var bricks = new FlxSprite(0, 0);
    bricks.loadGraphic(Paths.image('menus/title/bricks'));
    bricks.scrollFactor.set(0, 0);
    bricks.setGraphicSize(Std.int(bricks.width * 6));
    bricks.updateHitbox();
    bricks.antialiasing = false;
    add(bricks);
}
