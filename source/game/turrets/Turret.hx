package game.turrets;
import game.RSprite;
import game.ai.TurretAgroState;
import game.ai.TurretIdleState;
import game.weapons.TurretWeapon;
import game.weapons.Weapon;
import flixel.util.FlxColor;

/**
 * ...
 * @author billy
 */
class Turret extends RSprite
{
	
	public var weapon:Weapon;
	public function new(level:PlayState, X:Float, Y:Float, fireRate:Float, visionRadius:Float) 
	{
		super(level, X, Y, 0);
		fsm.registerState("idle", new TurretIdleState(this, visionRadius));
		fsm.registerState("agro", new TurretAgroState(this, visionRadius, fireRate));
		fsm.setState("idle");
		weapon = new TurretWeapon(level, this);
		makeGraphic(6, 6, FlxColor.RED);
	}
	
	public function fireAt(target:RSprite):Void {
		weapon.forceFire(target.x, target.y);
	}
}