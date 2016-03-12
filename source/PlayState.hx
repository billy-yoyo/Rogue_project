package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
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
import game.traps.types.BearTrap;
import game.turrets.Turret;
import game.weapons.damage.DamageModel;
import level.RId;
import level.RLevelGenerator;

class PlayState extends FlxState
{	
	
	public var visionOverlay:FlxSprite;
	public var visionFidelity:Int = 100;
	public var visionStep:Float;
	public var visionRadius:Float = 100;
	
	public var player:Player;
	public var tilemap:FlxTilemap;
	public var enemies:FlxSpriteGroup;
	override public function create():Void
	{
		enemies = new FlxSpriteGroup(0, 0, 1000);
		visionStep = (Math.PI * 2) / visionFidelity;
		visionFidelity += 1;
		var levelgen = new RLevelGenerator(100, 100);
		levelgen.generateLevelMatrix();
		tilemap = levelgen.generateLevel(Main.settings);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		//tilemap.follow();
		tilemap.setTileProperties(RId.TILE_BASE_FLOOR, FlxObject.NONE);
		tilemap.setTileProperties(RId.TILE_BASE_WALL, FlxObject.ANY);
		tilemap.setTileProperties(RId.SPAWN_PLAYER, FlxObject.NONE);
		tilemap.setTileProperties(RId.TILE_BASE_WALL_FRONT, FlxObject.ANY);
		add(tilemap);
		
		
		var playerSpawns:Array<FlxPoint> = tilemap.getTileCoords(RId.SPAWN_PLAYER);
		if (playerSpawns.length > 0) {
			var playerPos:FlxPoint = playerSpawns[FlxG.random.int(0, playerSpawns.length-1)];
			player = new Player(this, playerPos.x, playerPos.y);
			addEnemy(new Monster(this, playerPos.x + 70, playerPos.y + 70));
			//var turret:Turret = new Turret(this, playerPos.x, playerPos.y, 0.5, 150);
			add(new BearTrap(this, playerPos.x, playerPos.y, new DamageModel(3)));
			add(player);
			trace("player initialized");
		} else {
			trace("no player spawn found");
		}
		
		FlxG.camera.follow(player, LOCKON, 1);
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