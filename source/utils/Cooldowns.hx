package utils;

/**
 * ...
 * @author billy
 */
class Cooldowns
{
	
	private var cds:Map<String, Float>;
	public function new() 
	{
		cds = new Map<String, Float>();
	}
	
	public function start(name:String, length:Float):Void {
		cds.set(name, length);
	}
	
	public function check(name:String, elapsed:Float):Bool {
		if (cds.exists(name)) {
			cds.set(name, cds.get(name) - elapsed);
			if cds.get(name) <= 0 {
				cds.remove(name);
				return true;
			}
		}
		return false;
	}
}