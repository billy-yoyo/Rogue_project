package game;
import flixel.FlxSprite;
import game.ai.FSM;
import game.effects.SpriteEffect;

/**
 * ...
 * @author billy
 */
class RSprite extends FlxSprite
{
	public var effects:Array<SpriteEffect>;
	public var level:PlayState;
	public var fsm:FSM;
	public var rawSpeed:Float;
	public function new(level:PlayState, X:Float, Y:Float, rawSpeed:Float = 100) {
		this.level = level;
		this.fsm = new FSM();
		this.rawSpeed = rawSpeed;
		this.effects = new Array<SpriteEffect>();
		super(X, Y);
	}
	
	override public function update(elapsed:Float) {
		fsm.update(elapsed);
		for (effect in effects) {
			effect.update(elapsed);
		}
		super.update(elapsed);
	}
	
	public function moveSprite(dx:Float, dy:Float):Void {
		x += dx;
		y += dy;
	}
}