import funkin.game.PlayState;
import flixel.effects.FlxFlicker;

var bffire = strumLines.members[1].characters[0];
var bf = strumLines.members[1].characters[1];
var bfsmall = strumLines.members[1].characters[2];

var bfstatue = 3;
var invincible = false;

function postCreate(){
    bf.x = bffire.x;
    bfsmall.x = bffire.x - 4;
    bfsmall.y = bffire.y - 4;
    camGame.scroll.set(-400, -328);
	FlxG.camera.followLerp = 0;
    updateVisibility();
}

function update(){
    health = 1;
}

function onPlayerMiss(e) {
    e.missVolume = 0;
    if (!invincible) {
        bfstatue--;

        if (bfstatue > 0) {
            activateInvincibility();
        } else {
            //c'est la mort ici
        }
    }
}

function activateInvincibility() {
    invincible = true;
    var flickerTarget;
    
    switch(bfstatue) {
        case 2:
            flickerTarget = bf;
        case 1:
            flickerTarget = bfsmall;
        default:
            flickerTarget = null;
    }
    updateVisibility();
    if (flickerTarget != null) {
        FlxFlicker.flicker(flickerTarget, 5, 0.1, true);
    }
    var timer = new FlxTimer();

    timer.start(5, function(t:FlxTimer) {
        invincible = false;
    });
}

function updateVisibility() {

    switch(bfstatue) {
        case 3:
            bffire.visible = true;
            bf.visible = false;
            bfsmall.visible = false;

        case 2:
            bffire.visible = false;
            bf.visible = true;
            bfsmall.visible = false;

        case 1:
            bffire.visible = false;
            bf.visible = false;
            bfsmall.visible = true;

        case 0:
            bffire.visible = false;
            bf.visible = false;
            bfsmall.visible = false;
            // la mort
    }

}