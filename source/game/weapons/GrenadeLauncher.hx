package game.weapons;
import game.RSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
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
	}
	
	override public function forceFire(targetX:Float, targetY:Float):Void
	{
		var angle:Float = getAngle(targetX, targetY);
		
		shootBullet(new Grenade(level, source.x, source.y, Math.cos(angle) * bulletSpeed, Math.sin(angle) * bulletSpeed, 30, 1.5));

	}
}