package game.ai;
import flixel.input.FlxAccelerometer;
import flixel.math.FlxPoint;
import game.Player;
import game.RSprite;

/**
 * ...
 * @author billy
 */
class EnemyIdleState extends AIState
{
	public var visionRadius:Float;
	public function new(sprite:RSprite, visionRadius:Float) {
		super(sprite);
		this.visionRadius = visionRadius;
	}

	override public function update(elapsed:Float) {
		var player:Player = sprite.level.player;
		var dx:Float = player.x - sprite.x;
		var dy:Float = player.y - sprite.y;
		var dist:Float = Math.sqrt( (dx * dx) + (dy * dy) );
		if (dist <= visionRadius) {
			// player found
			if (sprite.level.tilemap.ray(new FlxPoint(sprite.x, sprite.y), new FlxPoint(player.x, player.y))) {
				trace("target found");
				sprite.fsm.stateSpriteData.set("target", player);
				sprite.fsm.setState("agro");
			}
		}
	}
	
}