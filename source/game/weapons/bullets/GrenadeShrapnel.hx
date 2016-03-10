package game.weapons.bullets;

import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class GrenadeShrapnel extends Bullet
{
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel, life:Float = 0.1) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		this.hasLife = true;
		this.enemyPiercing = true;
		this.life = life;
	}
	
}