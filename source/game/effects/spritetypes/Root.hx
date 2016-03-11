package game.effects.spritetypes;

import game.effects.SpriteEffect;
import game.RSprite;

/**
 * ...
 * @author billy
 */
class Root extends SpriteEffect
{

	public var oldRawSpeed:Float;
	public function new(target:RSprite, duration:Float, addOnInit:Bool=true) 
	{
		super(target, duration, addOnInit);
		
	}
	
	override public function add() {
		oldRawSpeed = target.rawSpeed;
		target.rawSpeed = 0;
		super.add();
	}
	
	override public function remove() {
		target.rawSpeed = oldRawSpeed;
		super.remove();
	}
	
}