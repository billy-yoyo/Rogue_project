package game.weapons.bullets.types;

import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class TurretBullet extends Bullet
{
	
	override public function createBullet(level, X, Y, SpeedX, SpeedY, spawner:BulletSpawner) {
		return new TurretBullet(level, X, Y, SpeedX, SpeedY, spawner.damage);
	}

	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		
	}
	
}