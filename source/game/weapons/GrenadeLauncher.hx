package game.weapons;
import game.RSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import game.weapons.bullets.BulletSpawner;
import game.weapons.bullets.types.Grenade;

/**
 * ...
 * @author billy
 */
class GrenadeLauncher extends Weapon
{

	public function new(level:PlayState, source:RSprite) 
	{
		super(level, source);
		fireCooldown = 1;
		bulletSpeed = 70;
		bulletSpread = 0;
		bulletSpawner = new BulletSpawner(this, Grenade);
		bulletSpawner.explosionAmount = 30;
		bulletSpawner.fuse = 1.5;
	}
	
}