package game.effects;
import game.weapons.Weapon;

/**
 * ...
 * @author billy
 */
class WeaponEffect
{
	
	public var target:Weapon;
	public var duration:Float;
	private var durationLeft:Float;
	private var applied:Bool = false;
	public function new(target:Weapon, duration:Float, addOnInit:Bool = true) 
	{
		this.target = target;
		this.duration = duration;
		if (addOnInit) {
			this.add();
		}
	}
	
	public function copy(target:Weapon) {
		return new WeaponEffect(target, duration, true);
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