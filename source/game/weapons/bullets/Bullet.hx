package game.weapons.bullets;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import effects.BulletTrace;
import game.enemies.Enemy;
import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class Bullet extends FlxSprite
{
	
	public var level:PlayState;
	public var speed:FlxPoint;
	public var hasCollided:Bool = false;
	public var damage:DamageModel;
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel) 
	{
		super(X, Y);
		makeGraphic(3, 3, FlxColor.BLUE);
		this.speed = new FlxPoint(SpeedX, SpeedY);
		this.level = level;
		this.damage = damage;
	}
	
	override public function update(elapsed:Float):Void 
	{
		movement(elapsed);
	}
	
	private function movement(elapsed:Float):Void
	{
		var dx:Float = speed.x * elapsed;
		var dy:Float = speed.y * elapsed;
		
		var bulletTrace = new BulletTrace(level, new FlxPoint(this.x, this.y), new FlxPoint(this.x + dx, this.y + dy), 100);
		level.add(bulletTrace);
		
		this.x = bulletTrace.end.x;
		this.y = bulletTrace.end.y;
		
		FlxG.collide(this, level.enemies, handleEnemyCollision);
		if (FlxG.collide(this, level.tilemap)) {
			this.hasCollided = true;
			level.remove(this);
		}
	}
	
	public function handleEnemyCollision(obj1:FlxObject, obj2:FlxObject):Void
	{
		if (this.hasCollided == false) {
			var obj:FlxObject = obj1;
			if (obj1 == this) {
				obj = obj2;
			}
			
			var enemy:Enemy = cast(obj, Enemy);
			this.hasCollided = true;
			level.remove(this);
			enemy.dealDamage(this.damage);
		}
	}
}