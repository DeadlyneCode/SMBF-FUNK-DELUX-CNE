import funkin.game.HudCamera;
import funkin.backend.scripting.events.NoteHitEvent;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;

public var pixelNotesForBF = true;
public var pixelNotesForDad = true;
public var pixelSplashes = true;
public var enablePixelUI = true;



static var daPixelZoom = 6;
var barY = FlxG.height - (7 * 6);

function onNoteCreation(event) {
	if (event.note.strumLine == playerStrums && !pixelNotesForBF) return;
	if (event.note.strumLine == cpuStrums && !pixelNotesForDad) return;

	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('noteskins/smm/arrowEnds'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('noteskins/smm/arrows-pixels'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(daPixelZoom, daPixelZoom);
	note.updateHitbox();
}

function onPostNoteCreation(event) {
	var splashes = event.note;
	if (pixelSplashes)
		splashes.splash = "splash-pixel";
}

function onStrumCreation(event) {
	if (event.player == 1 && !pixelNotesForBF) return;
	if (event.player == 0 && !pixelNotesForDad) return;

	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('noteskins/smm/arrows-pixels'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.scale.set(daPixelZoom, daPixelZoom);
	strum.updateHitbox();
}

function onCountdown(event) {
	if (!enablePixelUI) return;

	if (event.soundPath != null) event.soundPath = 'pixel/' + event.soundPath;
	event.antialiasing = false;
	event.scale = daPixelZoom;
	event.spritePath = switch(event.swagCounter) {
		case 0: null;
		case 1: 'stages/school/ui/ready';
		case 2: 'stages/school/ui/set';
		case 3: 'stages/school/ui/go';
	};
}

function onPlayerHit(event:NoteHitEvent) {
	if (!enablePixelUI) return;
	event.ratingPrefix = "stages/school/ui/";
	event.ratingScale = daPixelZoom * 0.7;
	event.ratingAntialiasing = false;

	event.numScale = daPixelZoom;
	event.numAntialiasing = false;
}


function postCreate() {
	scoreTxt.visible = false;
    missesTxt.visible = false;
    accuracyTxt.visible = false;
    healthBar.visible = false;
    healthBarBG.visible = false;
    iconP1.visible = false;
    iconP2.visible = false;
}

function create(){
    black1 = new FlxSprite();
    black1.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 0.11), FlxColor = 0xFF000000);
	black1.y = 654;
	black1.cameras = [camHUD];
    PlayState.instance.insert(PlayState.instance.members.indexOf(healthBar)+1, black1);

	black2 = new FlxSprite();
    black2.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 0.25), FlxColor = 0xFF000000);
	black2.y = -12;
	black2.cameras = [camHUD];
    PlayState.instance.insert(PlayState.instance.members.indexOf(healthBar)+1, black2);

	scoreBar = new FlxText(125, barY, 0, "00000000");
	scoreBar.autoSize = false;
	scoreBar.borderSize = 0;
	scoreBar.setFormat(Paths.font("smb1.ttf"), 8, FlxColor.WHITE, "left");
	scoreBar.setGraphicSize(Std.int(scoreBar.width * 6));
	scoreBar.scrollFactor.set();
	scoreBar.antialiasing = false;
	scoreBar.cameras = [camHUD];
    PlayState.instance.insert(PlayState.instance.members.indexOf(black1)+1, scoreBar);
}

function update(){
	health = 1;

	scoreBar.text = songScore;
	//pov tu nique les maths avec cette méthode de feignasse
	switch (scoreBar.text.length)
		{
			case 1:
				scoreBar.text = "00000" + scoreBar.text;
			case 2:
				scoreBar.text = "0000" + scoreBar.text;
			case 3:
				scoreBar.text = "000" + scoreBar.text;
			case 4:
				scoreBar.text = "00" + scoreBar.text;
			case 5:
				scoreBar.text = "0" + scoreBar.text;
		}
}