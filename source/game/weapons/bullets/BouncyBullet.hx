package game.weapons.bullets;

import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class BouncyBullet extends Bullet
{

	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel, life:Float) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		this.bouncy = true;
		this.hasLife = true;
		this.life = life;
	}
	
}