package level;

/**
 * ...
 * @author billy
 */
class RId
{
	/**
	 *  list of tile id constants
	 */
	public static var TILE_BASE_WALL_FRONT:Int = 2;
	public static var TILE_BASE_WALL:Int = 3;
	public static var TILE_BASE_FLOOR:Int = 4;
	public static var TILE_NONE:Int = 1;
	
	/**
	 *	list of spawn id constants
	 */
	public static var SPAWN_PLAYER:Int = 5;
	
	public static var solids:Array<Int> = [TILE_BASE_WALL, TILE_BASE_WALL_FRONT];
	public static function isSolid(id:Int) {
		return Lambda.has(solids, id);
	}
}