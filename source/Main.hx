package;

import level.RLevelGenerator;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import level.RSettings;
import openfl.display.Sprite;

class Main extends Sprite
{
	var gameWidth:Int = 1080;
	var gameHeight:Int = 720;
	var initialState:Class<FlxState> = PlayState;
	var zoom:Float = 1;
	var framerate:Int = 60;
	var skinSplash:Bool = true;
	var startFullscreen:Bool = false;
	
	public static var currentLevel:FlxTilemap;
	public static var settings:RSettings = new RSettings();
	public function new()
	{
		trace("starting...");
		var levelgen = new RLevelGenerator(10, 10);
		trace("levelgen initialized");
		levelgen.generateLevelMatrix();
		trace("level matrix generated");
		currentLevel = levelgen.generateLevel(settings);
		trace("level finalized");
		
		super();
		addChild(new FlxGame(320, 240, MenuState, 1, 60, 60, true, false));
	}
}