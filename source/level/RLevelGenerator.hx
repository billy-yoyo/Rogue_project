package level;

import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.FlxState;
import flixel.FlxG;
import level.RId;

/**
 * ...
 * @author billy
 */
class RLevelGenerator
{
	
	private var matrix:Array<Array<Int>>;
	private var rooms:Array<RRoom>;
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
		this.rooms = new Array<RRoom>();
		for (y in 0...Height)
		{
			this.matrix.push(new Array<Int>());
			for (x in 0...Width)
			{
				this.matrix[y].push(RId.TILE_NONE);
			}
		}
	}
	
	public function generateLevelMatrix():Void
	{
		/*for (y in 0...matrix.length) {
			for (x in 0...matrix[y].length) {
				if (FlxG.random.int(0, 100) <= 40) {
					matrix[y][x] = RId.TILE_BASE_FLOOR;
				}
			}
		}
		for (y in -3...4)
		{
			for (x in -3...4)
			{
				this.matrix[y + centre_y][x + centre_x] = RId.TILE_BASE_FLOOR;
			}
		}
		*/
		var bounds:RRoom = new RRoom(0, 0, width, height);
		var lastRoom:RRoom = new RRoom(centre_x - 3, centre_y - 3, 7, 7);
		rooms.push(lastRoom);
		lastRoom.placeRoom(matrix);
		var iterationCounter:Int = 0;
		var placedRooms:Int = 0;
		while (placedRooms < 20 && iterationCounter < 1000) {
			var baseRoom:RRoom = rooms[FlxG.random.int(0, rooms.length - 1)];
			var croom:RRoom = baseRoom.createAdjacentRoom(FlxG.random.int(4, 7), FlxG.random.int(4, 7), FlxG.random.int(0, 3));
			if (croom != null) {
				if (croom.canPlaceRoom(matrix, rooms, bounds)) {
					croom.connected.push(baseRoom);
					baseRoom.connected.push(croom);
					croom.placeRoom(matrix);
					rooms.push(croom);
					placedRooms += 1;
				}
			}
			iterationCounter += 1;
		}
		trace(rooms.length);
		for (room in rooms) {
			room.placeDoors(matrix);
		}
		this.matrix[centre_y][centre_x] = RId.SPAWN_PLAYER;
	}
	
	public function updateTile(x:Int, y:Int) {
		if (matrix[y][x] == RId.TILE_BASE_WALL) {
			if (y < matrix.length - 1) {
				if (RId.isSolid(matrix[y + 1][x]) == false) {
					return RId.TILE_BASE_WALL_FRONT;
				}
			}
		}
		return matrix[y][x];
	}
	
	public function convertToString():String
	{
		var mapString:String = "";
		for (y in 0...matrix.length)
		{
			for (x in 0...matrix[y].length)
			{
				mapString += Std.string(updateTile(x, y)) + ",";
			}
			
			mapString += "\n";
		}
		return mapString;
	}
	
	public function generateLevel(settings:RSettings):FlxTilemap
	{
		var tilemap:FlxTilemap = new FlxTilemap();
		var mapString:String = convertToString();
		tilemap.loadMapFromCSV(mapString, settings.tileset, settings.resolution, settings.resolution, 1);
		tilemap.updateBuffers();
		return tilemap;
	}
	
}