package game.traps.types;

import flixel.util.FlxColor;
import game.effects.spritetypes.Root;
import game.enemies.Enemy;
import game.traps.Trap;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class BearTrap extends Trap
{

	public var rootDuration = 3;
	public function new(level:PlayState, X:Float, Y:Float, damage:DamageModel) 
	{
		super(level, X, Y, damage);
		makeGraphic(5, 5, FlxColor.RED);
	}
	
	override public function enemyHit(enemy:Enemy) {
		enemy.effects.push(new Root(enemy, rootDuration));
		enemy.dealDamage(damage);
	}
	
}