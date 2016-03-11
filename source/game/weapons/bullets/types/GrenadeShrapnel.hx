package game.weapons.bullets.types;

import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class GrenadeShrapnel extends Bullet
{
	
	override public function createBullet(level, X, Y, SpeedX, SpeedY, spawner:BulletSpawner) {
		return new GrenadeShrapnel(level, X, Y, SpeedX, SpeedY, spawner.damage, spawner.life);
	}
	
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel, life:Float = 0.1) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		this.hasLife = true;
		this.enemyPiercing = true;
		this.life = life;
		this.knockback = 15;
	}
	
}