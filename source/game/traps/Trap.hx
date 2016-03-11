package game.traps;

import flixel.FlxG;
import flixel.FlxObject;
import game.RSprite;
import game.enemies.Enemy;
import game.weapons.damage.DamageModel;

/**
 * ...
 * @author billy
 */
class Trap extends RSprite
{

	public var damage:DamageModel;
	public function new(level:PlayState, X:Float, Y:Float, damage:DamageModel) 
	{
		super(level, X, Y, 0);
		this.damage = damage;
	}
	
	override public function update(elapsed:Float) {
		checkForEnemies();
		super.update(elapsed);
	}
	
	public function checkForEnemies() {
		if (FlxG.overlap(this, level.enemies, handleRawOverlap)) {
			trigger();
		}
	}
	
	public function trigger() {
		level.remove(this);
	}
	
	public function enemyHit(enemy:Enemy) {
		enemy.dealDamage(damage);
	}
	
	public function handleRawOverlap(obj1:FlxObject, obj2:FlxObject):Void {
		var obj:FlxObject = obj1;
		if (obj1 == this) {
			obj = obj2;
		}
		
		var enemy:Enemy = cast(obj, Enemy);
		enemyHit(enemy);
	}
}