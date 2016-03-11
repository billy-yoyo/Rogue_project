package game.weapons;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import game.weapons.bullets.Bullet;
import game.weapons.bullets.BulletSpawner;
import game.weapons.bullets.types.Grenade;
import game.weapons.bullets.types.BouncyBullet;
import game.weapons.damage.DamageModel;
import game.effects.WeaponEffect;

/**
 * ...
 * @author billy
 */
class Weapon
{

	public var effects:Array<WeaponEffect>;
	public var bulletSpawner:BulletSpawner;
	
	public var level:PlayState;
	public var source:RSprite;
	public var fireCooldown:Float;
	public var currentCooldown:Float = 0;
	public var lastBullets:Array<Bullet>;
	public var newBullets:Array<Bullet>;
	
	public var bulletSpeed:Float = 300;
	public var bulletSpread:Int = 30;
	public function new(level:PlayState, source:RSprite) 
	{
		this.level = level;
		this.source = source;
		this.fireCooldown = 0.05;
		this.lastBullets = new Array<Bullet>();
		this.newBullets = new Array<Bullet>();
		this.bulletSpawner = new BulletSpawner(this, Bullet);
		bulletSpawner.damage = new DamageModel(2);
		
		effects = new Array<WeaponEffect>();
	}
	
	public function update(elapsed:Float) {
		for (effect in effects) {
			effect.update(elapsed);
		}
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
	
	public function getAngle(targetX:Float, targetY:Float):Float {
		var target:FlxPoint = new FlxPoint(targetX, targetY);
		return FlxAngle.angleBetweenPoint(source, target);
	}
	
	public function offsetAngle(angle:Float, amount:Int):Float {
		if (amount == 0) {
			return angle;
		} else {
			return angle + FlxG.random.int( -amount, amount) / 1000.0;
		}
	}
	
	public function getBulletAngle(targetX:Float, targetY:Float, bulletSpread:Int):Float {
		return offsetAngle(getAngle(targetX, targetY), bulletSpread);
	}
	
	public function forceFire(targetX:Float, targetY:Float):Void
	{
		var angle:Float = getBulletAngle(targetX, targetY, bulletSpread);
		shootBullet(bulletSpawner.create(level, source.x, source.y, Math.cos(angle) * bulletSpeed, Math.sin(angle) * bulletSpeed));
	}
	
	private function shootBullet(bullet:Bullet) {
		level.add(bullet);
		newBullets.push(bullet);
	}
}