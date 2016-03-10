package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxTile;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import game.Player;
import game.enemies.Enemy;
import game.enemies.Monster;
import level.RId;
import level.RLevelGenerator;

class PlayState extends FlxState
{	
	
	public var player:Player;
	public var tilemap:FlxTilemap;
	public var enemies:FlxSpriteGroup;
	override public function create():Void
	{
		enemies = new FlxSpriteGroup(0, 0, 1000);
		
		var levelgen = new RLevelGenerator(12, 12);
		levelgen.generateLevelMatrix();
		tilemap = levelgen.generateLevel(Main.settings);
		tilemap.follow();
		tilemap.setTileProperties(RId.TILE_BASE_FLOOR, FlxObject.NONE);
		tilemap.setTileProperties(RId.TILE_BASE_WALL, FlxObject.ANY);
		tilemap.setTileProperties(RId.SPAWN_PLAYER, FlxObject.NONE);
		add(tilemap);
		
		
		var playerSpawns:Array<FlxPoint> = tilemap.getTileCoords(RId.SPAWN_PLAYER);
		if (playerSpawns.length > 0) {
			var playerPos:FlxPoint = playerSpawns[FlxG.random.int(0, playerSpawns.length-1)];
			player = new Player(this, playerPos.x, playerPos.y);
			addEnemy(new Monster(this, playerPos.x, playerPos.y));
			add(player);
			trace("player initialized");
		} else {
			trace("no player spawn found");
		}
		
		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.setScale(1, 1);
		super.create();
	}
	
	public function addEnemy(enemy:Enemy) {
		enemies.add(enemy);
		add(enemy);
	}
	
	public function removeEnemy(enemy:Enemy) {
		enemies.remove(enemy);
		remove(enemy);
	}
	
	override public function draw():Void
	{
		
		super.draw();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(tilemap, player);
	}
}