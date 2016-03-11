package level;

/**
 * ...
 * @author billy
 */
class RDoor
{
	public var x:Int;
	public var y:Int;
	public function new(x:Int, y:Int) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function placeDoor(matrix:Array<Array<Int>>) {
		matrix[y][x] = RId.TILE_BASE_FLOOR;
	}
	
}