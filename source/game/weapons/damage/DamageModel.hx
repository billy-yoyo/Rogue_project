package game.weapons.damage;

import game.enemies.Enemy;
/**
 * ...
 * @author billy
 */
class DamageModel
{
	
	public var baseDamage:Float;
	public function new(base:Float) 
	{
		this.baseDamage = base;
	}
	
	public function calculateDamage(enemy:Enemy) {
		return baseDamage;
	}
}