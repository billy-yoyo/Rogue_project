package effects;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import game.weapons.bullets.Bullet;

/**
 * ...
 * @author billy
 */
class BulletTrace extends FlxSprite
{
	
	public var source:PlayState;
	public var start:FlxPoint;
	public var end:FlxPoint;
	public var life:Float;
	public function new(source:PlayState, start:FlxPoint, end:FlxPoint, life:Float ) 
	{
		super(Math.min(start.x, end.x), Math.min(start.y, end.y));
		makeGraphic(Std.int(Math.max(start.x, end.x) - this.x) + 1, Std.int(Math.max(start.y, end.y) - this.y) + 1, FlxColor.TRANSPARENT, true);
		FlxSpriteUtil.beginDraw(FlxColor.BLUE);
		FlxSpriteUtil.drawLine(this, start.x - this.x, start.y - this.y, end.x - this.x, end.y - this.y);
		this.source = source;
		this.start = start;
		this.end = end;
		this.life = life;
	}
	
	override public function update(elapsed:Float):Void
	{
		life = life - elapsed;
		if (life <= 0) {
			source.remove(this);
		}
		super.update(elapsed);
	}
	
}