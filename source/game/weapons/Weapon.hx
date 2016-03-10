package game.weapons;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import game.weapons.bullets.Bullet;
import game.weapons.bullets.Grenade;
import game.weapons.bullets.WillBullet;
import game.weapons.bullets.AndrewsBullet;
import game.weapons.bullets.BouncyBullet;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Weapon
{

	public var level:PlayState;
	public var source:RSprite;
	public var damageModel:DamageModel;
	public var fireCooldown:Float;
	public var currentCooldown:Float = 0;
	public var lastBullets:Array<Bullet>;
	public var newBullets:Array<Bullet>;
	public function new(level:PlayState, source:RSprite) 
	{
		this.level = level;
		this.source = source;
		this.fireCooldown = 0.05;
		this.lastBullets = new Array<Bullet>();
		this.newBullets = new Array<Bullet>();
		damageModel = new DamageModel(0.2);
	}
	
	public function update(elapsed:Float) {
		if (currentCooldown > 0) {
			currentCooldown = currentCooldown - elapsed;
		}
	}
	
	public function fire(elapsed:Float, targetX:Float, targetY:Float):Void {
		if (currentCooldown <= 0) {
			newBullets = new Array<Bullet>();
			currentCooldown = fireCooldown;
			forceFire(targetX, targetY);
			lastBullets = newBullets;
		}
	}
	
	public function forceFire(targetX:Float, targetY:Float):Void
	{
		var target:FlxPoint = new FlxPoint(targetX, targetY);
		var angle:Float = FlxAngle.angleBetweenPoint(source, target);
		angle += FlxG.random.int( -1, 1) / 50.0;
		
		shootBullet(new BouncyBullet(level, source.x, source.y, Math.cos(angle) * 300, Math.sin(angle) * 300, damageModel, 5));
		//var bullet1 = new AndrewsBullet(level, source.x, source.y, Math.cos(angle - 0.05) * 300, Math.sin(angle - 0.05) * 300, damageModel);
		//bullet1.spiralAngle += Math.PI;
		//level.add(bullet1);
		
		/*var spiral:Float = 0;
		if (lastBullets.length > 0) {
			spiral = cast(lastBullets[0], WillBullet).spiralAngle;
			trace(spiral);
		}
		shootBullet(new WillBullet(level, source.x, source.y, Math.cos(angle) * 300, Math.sin(angle) * 300, damageModel, spiral));
		*/
		//shootBullet(new Grenade(level, source.x, source.y, Math.cos(angle) * 70, Math.sin(angle) * 70, damageModel, 15, 2.5));
		
		//var bullet3 = new AndrewsBullet(level, source.x, source.y, Math.cos(angle + 0.05) * 300, Math.sin(angle + 0.05) * 300, damageModel);
		//level.add(bullet3);
		
	}
	
	private function shootBullet(bullet:Bullet) {
		level.add(bullet);
		newBullets.push(bullet);
	}
}