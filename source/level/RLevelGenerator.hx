package level;

import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.FlxState;
import level.RId;

/**
 * ...
 * @author billy
 */
class RLevelGenerator
{
	
	private var matrix:Array<Array<Int>>;
	private var width:Int;
	private var height:Int;
	private var centre_x:Int;
	private var centre_y:Int;
	public function new(Width:Int, Height:Int) 
	{
		width = Width;
		height = Height;
		centre_x = Std.int(Math.floor(width / 2));
		centre_y = Std.int(Math.floor(height / 2));
		this.matrix = new Array<Array<Int>>();
		for (y in 0...Height)
		{
			this.matrix.push(new Array<Int>());
			for (x in 0...Width)
			{
				this.matrix[y].push(RId.TILE_BASE_WALL);
			}
		}
	}
	
	public function generateLevelMatrix():Void
	{
		for (y in -3...4)
		{
			for (x in -3...4)
			{
				this.matrix[y + centre_y][x + centre_x] = RId.TILE_BASE_FLOOR;
			}
		}
		this.matrix[centre_y][centre_x] = RId.SPAWN_PLAYER;
	}
	
	public function convertToString():String
	{
		var mapString:String = "";
		for (y in 0...matrix.length)
		{
			for (x in 0...matrix[y].length)
			{
				mapString += Std.string(matrix[y][x]) + ",";
			}
			
			mapString += "\n";
		}
		return mapString;
	}
	
	public function generateLevel(settings:RSettings):FlxTilemap
	{
		var tilemap:FlxTilemap = new FlxTilemap();
		var mapString:String = convertToString();
		trace(mapString);
		tilemap.loadMapFromCSV(mapString, settings.tileset, settings.resolution, settings.resolution, 1);
		tilemap.updateBuffers();
		return tilemap;
	}
	
}