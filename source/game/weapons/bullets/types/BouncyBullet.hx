package game.weapons.bullets.types;

import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class BouncyBullet extends Bullet
{

	override public function createBullet(level, X, Y, SpeedX, SpeedY, spawner:BulletSpawner) {
		return new BouncyBullet(level, X, Y, SpeedX, SpeedY, spawner.damage, spawner.life);
	}
	
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel, life:Float) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		this.bouncy = true;
		this.hasLife = true;
		this.life = life;
	}
	
}