package level;
import flash.geom.Matrix;
import flixel.FlxG;
import js.html.BarProp;
/**
 * ...
 * @author billy
 */
class RRoom
{
	public static var UP:Int = 0;
	public static var LEFT:Int = 1;
	public static var DOWN:Int = 2;
	public static var RIGHT:Int = 3;
	
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	
	public var doors:Array<RDoor>;
	public var connected:Array<RRoom>;
	public function new(x:Int, y:Int, width:Int, height:Int) 
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.doors = new Array<RDoor>();
		this.connected = new Array<RRoom>();
	}
	
	public function placeRoom(matrix:Array<Array<Int>>) {
		for (iy in (y - 1)...(y + height + 1)) {
			for (ix in (x - 1)...(x + width + 1)) {
				if (ix >= x && iy >= y && ix < x + width && iy < y + height) {
					matrix[iy][ix] = RId.TILE_BASE_FLOOR;
				} else {
					matrix[iy][ix] = RId.TILE_BASE_WALL;
				}
			}
		}
	}
	
	
	
	public function placeDoors(matrix:Array<Array<Int>>) {
		for (door in doors) {
			door.placeDoor(matrix);
		}
	}
	
	public function left(expansion:Int = 0):Int {
		return (x - 1) - expansion;
	}
	
	public function right(expansion:Int = 0):Int {
		return (x + width) + expansion;
	}
	
	public function top(expansion:Int = 0):Int {
		return (y - 1) - expansion;
	}
	
	public function bottom(expansion:Int = 0):Int {
		return (y + height) + expansion;
	}
	
	public function checkCollision(room:RRoom, exp1:Int = 0, exp2:Int = 0):Bool {
		return ( left(exp1) < room.right(exp2) && right(exp1) > room.left(exp2) && top(exp1) < room.bottom(exp2) && bottom(exp1) > room.top(exp2) );
	}
	
	public function canPlaceRoom(matrix:Array<Array<Int>>, rooms:Array<RRoom>, boundingRoom:RRoom):Bool {
		if (x >= boundingRoom.x && y >= boundingRoom.y && x + width < boundingRoom.x + boundingRoom.width && y + height < boundingRoom.y + boundingRoom.height) {
			for (room in rooms) {
				if (checkCollision(room)) {
					return false;
				}
			}
			for (iy in y...y + height) {
				for (ix in x...x + width) {
					if (RId.isSolid(matrix[iy][ix])) {
						trace("cannot place room");
						return false;
					}
				}
			}
			return true;
		} else {
			return false;
		}
	}
	
	public function attemptConnection(room:RRoom, matrix:Array<Array<Int>>):Bool {
		var x_direction:Int = 0;
		var y_direction:Int = 0;
		if (room.left(1) < left(1) && room.right(-1) < left(1)) {
			x_direction = -1;
		} else if (room.right(-1) > right(-1) && room.left(1) > right(-1)) {
			x_direction = 1;
		}
		
		if (room.top(1) < top(1) && room.bottom(-1) < top(1)) {
			y_direction = -1;
		} else if (room.bottom(-1) > bottom(-1) && room.top(1) > bottom(-1)) {
			y_direction = 1;
		}
		
		if ( (x_direction == 0 || y_direction == 0) && (x_direction != 0 || y_direction != 0) ) {
			var corridor:RCorridor = null;
			if (x_direction != 0) {
				var y:Int = FlxG.random.int(Math.floor(Math.max(room.top(1), top(1))), Math.ceil(Math.min(room.bottom(-1), bottom(-1))));
				var x_start:Int = right();
				var x_end:Int = room.left();
				if (x_direction > 0) {
					x_start = room.right();
					x_end = left();
				}
				corridor = new RCorridor(x_start, y, x_end, y);
			} else {
				var x:Int = FlxG.random.int(Math.floor(Math.max(room.left(1), left(1))), Math.ceil(Math.min(room.right(-1), right(-1))));
				var y_start:Int = bottom();
				var y_end:Int = room.top();
				if (y_direction > 0) {
					y_start = room.bottom();
					y_end = top();
				}
				corridor = new RCorridor(x, y_start, x, y_end);
			}
			if (corridor != null) {
				corridor.place(matrix);
				room.connected.push(this);
				connected.push(room);
				return true;
			}
		}
		return false;
	}
	
	public function createAdjacentRoom(width:Int, height:Int, direction:Int):RRoom {
		if (direction == RRoom.UP) {
			var y:Int = this.y - (height+1);
			var x:Int = FlxG.random.int(this.x, this.x + this.width - 1) - Math.floor(width / 2);
			
			var newRoom:RRoom = new RRoom(x, y, width, height);
			newRoom.doors.push(new RDoor(x + Math.floor(width / 2), this.y - 1));
			return newRoom;
		} else if (direction == RRoom.DOWN) {
			var y:Int = this.y + this.height + 1;
			var x:Int = FlxG.random.int(this.x, this.x + this.width - 1) - Math.floor(width / 2);
			
			var newRoom:RRoom = new RRoom(x, y, width, height);
			newRoom.doors.push(new RDoor(x + Math.floor(width / 2), this.y + this.height));
			return newRoom;
		} else if (direction == RRoom.LEFT) {
			var x:Int = this.x - (width + 1);
			var y:Int = FlxG.random.int(this.y, this.y + this.height - 1) - Math.floor(height / 2);
			
			var newRoom:RRoom = new RRoom(x, y, width, height);
			newRoom.doors.push(new RDoor(this.x - 1, y + Math.floor(height / 2)));
			return newRoom;
		} else if (direction == RRoom.RIGHT) {
			var x:Int = this.x + this.width + 1;
			var y:Int = FlxG.random.int(this.y, this.y + this.height - 1) - Math.floor(height / 2);
			
			var newRoom:RRoom = new RRoom(x, y, width, height);
			newRoom.doors.push(new RDoor(this.x + this.width, y + Math.floor(height / 2)));
			return newRoom;
		}
		return null;
	}
	
}