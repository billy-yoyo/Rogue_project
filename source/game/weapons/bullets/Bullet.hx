package game.weapons.bullets;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxVector;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import effects.BulletTrace;
import game.enemies.Enemy;
import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class Bullet extends RSprite
{
	
	public var speed:FlxVector;
	public var hasCollided:Bool = false;
	public var damage:DamageModel;
	public var centre_x_offset:Float;
	public var centre_y_offset:Float;
	
	public var enemyPiercing:Bool = false;
	public var mapPiercing:Bool = false;
	public var bouncy:Bool = false;
	public var knockback:Float = 0;
	public var hasLife:Bool = false;
	public var life:Float = 0;
	
	public function createBullet(level, X, Y, SpeedX, SpeedY, spawner:BulletSpawner) {
		return new Bullet(level, X, Y, SpeedX, SpeedY, spawner.damage);
	}
	
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel) 
	{
		super(level, X, Y, Math.sqrt( (SpeedX * SpeedX) + (SpeedY * SpeedY) ));
		centre_x_offset = 1.5;
		centre_y_offset = 1.5;
		this.speed = new FlxVector(SpeedX, SpeedY);
		this.level = level;
		this.damage = damage;
		setupGraphic();
	}
	
	private function setupGraphic():Void {
		loadGraphic(AssetPaths.sprite_tileset__png, true, 8, 8);
		animation.add("move", [0], 1000, true);
		animation.play("move");
		this.offset.x = 3;
		this.offset.y = 5;
		this.width = 2;
		this.height = 2;
		this.angle = this.speed.angleBetween(new FlxPoint(0, 0));
	}
	
	public function getPerp(offset:Float):FlxPoint
	{
		var vector:FlxVector = new FlxVector(speed.x, speed.y);
		vector.rotateByDegrees(90);
		return new FlxPoint(vector.dx * offset, vector.dy * offset);
	}
	
	public function endOfLife():Void
	{
		level.remove(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (hasLife) {
			life -= elapsed;
			if (life <= 0) {
				endOfLife();
			}
		}
		movement(elapsed);
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void
	{
		var dx:Float = speed.x * elapsed;
		var dy:Float = speed.y * elapsed;
		
		/*var bulletTrace = new BulletTrace(level, new FlxPoint(this.x + centre_x_offset, this.y + centre_y_offset), 
												 new FlxPoint(this.x + dx + centre_x_offset, this.y + dy + centre_y_offset), 0.05);
		level.add(bulletTrace);*/
		
		moveSprite(dx, dy);
	}
	
	public function hitWall():Void
	{
		this.hasCollided = true;
		level.remove(this);
	}
	
	override public function moveSprite(dx:Float, dy:Float):Void
	{
		
		this.x += dx;
		this.y += dy;
		
		FlxG.overlap(this, level.enemies, handleEnemyCollision);
		if (mapPiercing == false) {
			if (bouncy == false) {
				if (FlxG.collide(level.tilemap, this)) {
					hitWall();
				}
			} else {
				this.y -= dy;
				if (FlxG.collide(level.tilemap, this)) {
					this.x -= dx;
					speed.x = speed.x * -1;
					//trace("x_bounce");
				}
				this.y += dy;
				if (FlxG.collide(level.tilemap, this)) {
					this.y -= dy;
					speed.y = speed.y * -1;
				}
			}
		}
	}
	
	public function hitEnemy(enemy:Enemy):Void
	{
		this.hasCollided = true;
		if (enemyPiercing == false) {
			level.remove(this);
		}
		enemy.dealDamage(this.damage);
		if (knockback > 0) {
			enemy.push(speed.dx * knockback, speed.dy * knockback);
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
			hitEnemy(enemy);
		}
	}
}