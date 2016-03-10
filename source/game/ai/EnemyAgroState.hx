package game.ai;
import flixel.input.FlxAccelerometer;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import game.RSprite;

/**
 * ...
 * @author billy
 */
class EnemyAgroState extends AIState
{
	public var visionRadius:Float;
	private var trackTime:Float;
	private var path:Array<FlxPoint>;
	private var pathProgress:Int;
	private var pathVector:FlxVector;
	private var pathTravelled:Float;
	public function new(sprite:RSprite, visionRadius:Float) 
	{
		super(sprite);
		this.visionRadius = visionRadius;
	}
	
	override public function begin():Void {
		trackTime = 0.1;
		if (sprite.fsm.stateSpriteData.exists("target")) {
			var target:RSprite = sprite.fsm.stateSpriteData.get("target");
			var dist:Float = Math.sqrt( Math.pow(target.x - sprite.x, 2) + Math.pow(target.y - sprite.y, 2) );
			if (dist <= visionRadius) {
				path = sprite.level.tilemap.findPath(new FlxPoint(sprite.x, sprite.y), new FlxPoint(target.x, target.y));
				if (path.length > 1) {
					pathProgress = 0;
					pathVector = new FlxVector(path[1].x - path[0].x, path[1].y - path[0].y);
				} else {
					sprite.fsm.setState("idle");
				}
			} else {
				sprite.fsm.setState("idle");
			}
		} else {
			sprite.fsm.setState("idle");
		}
	}
	
	override public function update(elapsed:Float):Void {
		var length:Float = sprite.rawSpeed * elapsed;
		sprite.moveSprite(length * pathVector.dx, length * pathVector.dy);
		pathTravelled += length;
		if (pathTravelled >= pathVector.length) {
			pathTravelled = 0;
			pathProgress += 1;
			if (pathProgress + 1 < path.length) {
				pathVector = new FlxVector(path[pathProgress + 1].x - path[pathProgress].x, path[pathProgress + 1].y - path[pathProgress].y);
			} else {
				begin();
			}
		}
		trackTime -= elapsed;
		if (trackTime <= 0) {
			begin();
		}
	}
}