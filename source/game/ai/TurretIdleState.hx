package game.ai;
import game.enemies.Enemy;

/**
 * ...
 * @author billy
 */
class TurretIdleState extends AIState
{

	public var visionRadius:Float;
	public function new(sprite:RSprite, visionRadius:Float) {
		super(sprite);
		this.visionRadius = visionRadius;
	}
	
	override public function update(elapsed:Float) {
		var minDist:Float = -1;
		var closest:Enemy = null;
		for (enemy in sprite.level.enemies) {
			var dx:Float = enemy.x - sprite.x;
			var dy:Float = enemy.y - sprite.y;
			var dist:Float = Math.sqrt( (dx * dx) + (dy * dy) );
			if (dist <= minDist || minDist == -1) {
				minDist = dist;
				closest = cast(enemy, Enemy);
			}
		}
		if (minDist <= visionRadius && closest != null) {
			sprite.fsm.stateSpriteData.set("target", closest);
			sprite.fsm.setState("agro");
		}
	}
}