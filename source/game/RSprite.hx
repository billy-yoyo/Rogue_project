package game;
import flixel.FlxSprite;
import game.ai.FSM;

/**
 * ...
 * @author billy
 */
class RSprite extends FlxSprite
{
	public var level:PlayState;
	public var fsm:FSM;
	public var rawSpeed:Float;
	public function new(level:PlayState, X:Float, Y:Float, rawSpeed:Float = 100) {
		this.level = level;
		this.fsm = new FSM();
		this.rawSpeed = rawSpeed;
		super(X, Y);
	}
	
	public function moveSprite(dx:Float, dy:Float):Void {
		x += dx;
		y += dy;
	}
}