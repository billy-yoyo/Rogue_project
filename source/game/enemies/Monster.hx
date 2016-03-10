package game.enemies;

import game.ai.EnemyAgroState;
import game.ai.EnemyIdleState;
import flixel.util.FlxColor;
/**
 * ...
 * @author billy
 */
class Monster extends Enemy
{

	public function new(level:PlayState, X:Float, Y:Float) 
	{
		super(level, X, Y, 10, 80);
		this.fsm.registerState("idle", new EnemyIdleState(this, 100));
		this.fsm.registerState("agro", new EnemyAgroState(this, 100));
		this.fsm.setState("idle");
		makeGraphic(5, 5, FlxColor.BLUE);
	}
	
}