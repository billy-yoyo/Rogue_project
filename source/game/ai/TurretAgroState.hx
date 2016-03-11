package game.ai;
import game.RSprite;
import game.turrets.Turret;

/**
 * ...
 * @author billy
 */
class TurretAgroState extends AIState
{

	public var visionRadius:Float;
	public var target:RSprite;
	public var fireTime:Float;
	private var fireCD:Float;
	public function new(sprite:RSprite, visionRadius:Float, fireTime:Float) {
		super(sprite);
		this.visionRadius = visionRadius;
		this.fireTime = fireTime;
	}
	
	override public function begin() {
		if (sprite.fsm.stateSpriteData.exists("target")) {
			var target:RSprite = sprite.fsm.stateSpriteData.get("target");
			var dist:Float = Math.sqrt( Math.pow(target.x - sprite.x, 2) + Math.pow(target.y - sprite.y, 2) );
			if (dist <= visionRadius) {
				this.target = target;
				this.fireCD = fireTime;
			} else {
				sprite.fsm.setState("idle");
			}
		} else {
			sprite.fsm.setState("idle");
		}
	}
	
	override public function update(elapsed:Float) {
		if (target != null) {
			fireCD -= elapsed;
			if (fireCD <= 0) {
				var dist:Float = Math.sqrt( Math.pow(target.x - sprite.x, 2) + Math.pow(target.y - sprite.y, 2) );
				if (dist <= visionRadius) {
					var turret:Turret = cast(sprite, Turret);
					turret.fireAt(target);
					if (target.health <= 0) {
						sprite.fsm.setState("idle");
					} else {
						begin();
					}
				} else {
					sprite.fsm.setState("idle");
				}
			}
		}
	}
	
}