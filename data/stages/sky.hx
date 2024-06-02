import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;

function create(){
    importScript("data/scripts/smm");

    stars = new FlxBackdrop(Paths.image("stages/sky/stars"));
    stars.velocity.x = 5;
    insert(members.indexOf(dad), stars);

    coinsBack = new FlxSprite(0, 0).loadGraphic(Paths.image("stages/sky/coins1"), true, 160, 80);
    coinsBack.scrollFactor.set(1, 1);
    coinsBack.antialiasing = false;
    coinsBack.updateHitbox();
    insert(members.indexOf(dad), coinsBack);

    coinsBack2 = new FlxSprite(coinsBack.width-340, 0).loadGraphic(Paths.image("stages/sky/coins1"), true, 160, 80);
    coinsBack2.scrollFactor.set(1, 1);
    coinsBack2.antialiasing = false;
    coinsBack2.updateHitbox();
    insert(members.indexOf(dad), coinsBack2);

    coinsFront = new FlxSprite(coinsBack.width, 0).loadGraphic(Paths.image("stages/sky/coins2"), true, 160, 80);
    coinsFront.scrollFactor.set(1, 1);
    coinsFront.antialiasing = false;
    coinsFront.updateHitbox();
    insert(members.indexOf(dad), coinsFront);

    coinsFront2 = coinsFront.clone();
    insert(members.indexOf(dad), coinsFront2);
    
    coinsBack.animation.add("idle", [0, 0, 0, 0, 0, 1, 2, 1], 9);
    coinsBack2.animation.add("idle", [0, 0, 0, 0, 0, 1, 2, 1], 9);
    coinsBack.animation.play("idle");
    coinsBack2.animation.play("idle");

    coinsFront.animation.add("idle", [0, 0, 0, 0, 0, 1, 2, 1], 9);
    coinsFront2.animation.add("idle", [0, 0, 0, 0, 0, 1, 2, 1], 9);
    coinsFront.animation.play("idle");
    coinsFront2.animation.play("idle");
}

function update(elapsed){
    coinsBack.x += 16 * elapsed;
    coinsBack2.x += 16 * elapsed;
    coinsFront.x += 36 * elapsed;
    coinsFront2.x += 36 * elapsed;
    if (coinsBack.x >= 200){
        coinsBack.x = -160;
    }

    if (coinsBack2.x >= 250){
        coinsBack2.x = -160;
    }

    if (coinsFront.x >= 150){
        coinsFront.x = -130;
    }
    if (coinsFront2.x >= 150){
        coinsFront2.x = -130;
    }
}