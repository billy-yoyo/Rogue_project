package game.weapons;
import game.RSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import game.weapons.bullets.Grenade;

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
	}
	override public function forceFire(targetX:Float, targetY:Float):Void
	{
		var target:FlxPoint = new FlxPoint(targetX, targetY);
		var angle:Float = FlxAngle.angleBetweenPoint(source, target);
		angle += FlxG.random.int( -1, 1) / 50.0;
		
		shootBullet(new Grenade(level, source.x, source.y, Math.cos(angle) * 70, Math.sin(angle) * 70, 30, 1.5));

	}
}