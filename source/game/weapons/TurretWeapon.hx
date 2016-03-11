package game.weapons;

import game.RSprite;
import game.weapons.bullets.types.TurretBullet;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class TurretWeapon extends Weapon
{
	
	public function new(level:PlayState, source:RSprite) 
	{
		super(level, source);
		this.bulletSpeed = 150;
		this.bulletSpread = 0;
	}
	
	override public function forceFire(targetX:Float, targetY:Float):Void
	{
		var angle:Float = getBulletAngle(targetX, targetY, bulletSpread);
		
		shootBullet(new TurretBullet(level, source.x, source.y, Math.cos(angle) * bulletSpeed, Math.sin(angle) * bulletSpeed, new DamageModel(1)));
	}
}