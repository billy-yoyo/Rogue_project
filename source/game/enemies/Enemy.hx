package game.enemies;

import flixel.FlxSprite;
import flixel.FlxG;
import game.Healthbar;
import game.ai.FSM;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Enemy extends RSprite
{
	
	public function new(level:PlayState, X:Float, Y:Float, health:Float, speed:Float = 100) 
	{
		super(level, X, Y, speed);
		this.health = health;
		this.healthbar = new Healthbar(this, health, -6, -9, 16, 7, 1);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (this.health <= 0) {
			level.removeEnemy(this);
		}
	}
	
	public function push(dx:Float, dy:Float) {
		moveSprite(dx, dy);
		FlxG.collide(this, level.tilemap);
	}
	
}