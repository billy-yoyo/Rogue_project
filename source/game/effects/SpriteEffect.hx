package game.effects;
import game.RSprite;

/**
 * ...
 * @author billy
 */
class SpriteEffect
{
	
	public var target:RSprite;
	public var duration:Float;
	private var durationLeft:Float;
	private var applied:Bool = false;
	public function new(target:RSprite, duration:Float, addOnInit:Bool = true) 
	{
		this.target = target;
		this.duration = duration;
		if (addOnInit) {
			add();
		}
	}
	
	public function copy(target:RSprite) {
		return new SpriteEffect(target, duration, true);
	}
	
	public function add() {
		applied = true;
		durationLeft = duration;
	}
	
	public function remove() {
		applied = false;
		target.effects.remove(this);
	}
	
	public function update(elapsed:Float) {
		if (duration > 0) {
			durationLeft -= elapsed;
			if (durationLeft <= 0) {
				remove();
			}
		}
	}
}