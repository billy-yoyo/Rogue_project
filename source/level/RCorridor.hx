package level;

import flixel.math.FlxPoint;
/**
 * ...
 * @author billy
 */
class RCorridor
{
	public var startX:Int;
	public var startY:Int;
	public var endX:Int;
	public var endY:Int;
	public function new(startX:Int, startY:Int, endX:Int, endY:Int) 
	{
		this.startX = startX;
		this.startY = startY;
		this.endX = endX;
		this.endY = endY;
	}
	
	public function place(matrix:Array<Array<Int>>) {
		var wallOffset1:FlxPoint = new FlxPoint(0, -1);
		var wallOffset2:FlxPoint = new FlxPoint(0, 1);
		if (startX == endX) {
			wallOffset1 = new FlxPoint(-1, 0);
			wallOffset2 = new FlxPoint(1, 0);
		}
		if (startX == endX && startY == endY) {
			matrix[startY][startX] = RId.TILE_BASE_FLOOR;
		} else {
			for (y in startY...(endY+1)) {
				for (x in startX...(endX+1)) {
					matrix[y][x] = RId.TILE_BASE_FLOOR;
					matrix[Std.int(y + wallOffset1.y)][Std.int(x + wallOffset1.x)] = RId.TILE_BASE_WALL;
					matrix[Std.int(y + wallOffset2.y)][Std.int(x + wallOffset2.x)] = RId.TILE_BASE_WALL;
				}
			}
		}
	}
}