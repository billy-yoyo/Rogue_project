package game.enemies;

import flixel.FlxSprite;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Enemy extends FlxSprite
{
	
	public function new(X:Float, Y:Float, health:Float) 
	{
		super(X, Y);
		this.health = health;
	}
	
	public function dealDamage(damage:DamageModel) {
		health = health - damage.calculateDamage(this);
	}
}