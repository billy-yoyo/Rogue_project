package game.weapons;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import game.weapons.bullets.Bullet;
import game.weapons.bullets.WillBullet;
import game.weapons.bullets.AndrewsBullet;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Weapon
{

	public var level:PlayState;
	public var source:FlxSprite;
	public var damageModel:DamageModel;
	public var fireCooldown:Float;
	public var currentCooldown:Float = 0;
	public function new(level:PlayState, source:FlxSprite) 
	{
		this.level = level;
		this.source = source;
		this.fireCooldown = 0.05;
		damageModel = new DamageModel(0.2);
	}
	
	public function fire(elapsed:Float, targetX:Float, targetY:Float):Void {
		currentCooldown = currentCooldown - elapsed;
		if (currentCooldown <= 0) {
			currentCooldown = fireCooldown;
			forceFire(targetX, targetY);
		}
	}
	
	public function forceFire(targetX:Float, targetY:Float):Void
	{
		var target:FlxPoint = new FlxPoint(targetX, targetY);
		var angle:Float = FlxAngle.angleBetweenPoint(source, target);
		angle += FlxG.random.int( -1, 1) / 50.0;
		
		var bullet1 = new AndrewsBullet(level, source.x, source.y, Math.cos(angle - 0.05) * 300, Math.sin(angle - 0.05) * 300, damageModel);
		bullet1.spiralAngle += Math.PI;
		level.add(bullet1);
		
		var bullet2 = new Bullet(level, source.x, source.y, Math.cos(angle) * 300, Math.sin(angle) * 300, damageModel);
		level.add(bullet2);
		
		var bullet3 = new AndrewsBullet(level, source.x, source.y, Math.cos(angle + 0.05) * 300, Math.sin(angle + 0.05) * 300, damageModel);
		level.add(bullet3);
	}
	
}