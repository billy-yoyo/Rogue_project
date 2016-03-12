package game;
import flixel.FlxSprite;
import game.ai.FSM;
import game.effects.SpriteEffect;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class RSprite extends FlxSprite
{
	public var healthbar:Healthbar = null;
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
	
	override public function draw() {
		super.draw();
		if (healthbar != null) {
			healthbar.updatePosition();
			healthbar.draw();
		}
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
	
	public function getXSpeed():Float {
		return 0;
	}
	
	public function getYSpeed():Float {
		return 0;
	}
	
	public function dealDamage(damage:DamageModel):Void {
		health = health - damage.calculateDamage(this);
		if (healthbar != null) {
			healthbar.updateHealth();
		}
	}
}