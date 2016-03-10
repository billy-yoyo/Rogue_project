package game.weapons.bullets;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.FlxG;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Grenade extends Bullet
{
	
	private var explosionAmount:Int;
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, explosionAmount:Int, fuse:Float = 0) 
	{
		super(level, X, Y, SpeedX, SpeedY, new DamageModel(0));
		this.explosionAmount = explosionAmount;
		this.bouncy = true;
		this.hasLife = true;
		this.enemyPiercing = true;
		this.life = fuse;
	}
	
	override public function endOfLife():Void
	{
		var angle_step:Float = (Math.PI * 2) / explosionAmount;
		for (i in 0...explosionAmount) {
			var angle:Float = angle_step * i;
			var bullet = new GrenadeShrapnel(level, x, y, Math.cos(angle) * 300, Math.sin(angle) * 300, new DamageModel(0.5), 0.2);
			level.add(bullet);
		}
		super.endOfLife();
	}
	
}