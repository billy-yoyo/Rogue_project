package game;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import game.weapons.GrenadeLauncher;
import game.weapons.Weapon;

/**
 * ...
 * @author billy
 */
class Player extends RSprite
{
	public static var walkAnimationDirection:Array<String> = ["down_walk", "left_walk", "up_walk", "right_walk"];
	public static var idleAnimationDirection:Array<String> = ["down_idle", "left_idle", "up_idle", "right_idle"];

	public var weapon:Weapon;
	public var lastDirection:Int = 0;
	public function new(level:PlayState, ?X:Float=0, ?Y:Float=0) 
	{
		super(level, X, Y, 200);
		loadGraphic(AssetPaths.player_sprite__png, true, 16, 16);
		var walkSpeed:Int = 15;
		var idleSpeed:Int = 3;
		animation.add("right_walk", [3, 1, 0, 2], walkSpeed, true);
		animation.add("right_idle", [3, 0], idleSpeed, true);
		animation.add("left_walk", [7, 5, 4, 6], walkSpeed, true);
		animation.add("left_idle", [7, 4], idleSpeed, true);
		animation.add("up_walk", [11, 9, 8, 10], walkSpeed, true);
		animation.add("up_idle", [11, 9], idleSpeed, true);
		animation.add("down_walk", [15, 13, 12, 14], walkSpeed, true);
		animation.add("down_idle", [15, 12], idleSpeed, true);
		animation.play("down_idle");
		offset.x = 3;
		width = 10;
		offset.y = 11;
		height = 5;
		drag.x = drag.y = 1600;
		weapon = new Weapon(level, this);
	}
	
	public function handleAnimationDirection():Void {
		if (velocity.x == 0 && velocity.y == 0) {
			animation.play(Player.idleAnimationDirection[lastDirection]);
		} else {
			if (velocity.x > 0) {
				lastDirection = 3;
			} else if (velocity.x < 0) {
				lastDirection = 1;
			} else if (velocity.y > 0) {
				lastDirection = 0;
			} else {
				lastDirection = 2;
			}
			animation.play(Player.walkAnimationDirection[lastDirection]);
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		movement();
		firing(elapsed);
		weapon.update(elapsed);
		super.update(elapsed);
		handleAnimationDirection();
	}
	
	private function firing(elapsed:Float):Void {
		if (FlxG.keys.anyPressed([SPACE])) {
			weapon.fire(elapsed, FlxG.mouse.x, FlxG.mouse.y);
		}
	}
	
	override public function getXSpeed():Float {
		trace(velocity.x);
		return velocity.x;
	}
	
	override public function getYSpeed():Float {
		trace(velocity.y);
		return velocity.y;
	}
	
	private function movement():Void {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
			
		if (_up || _down || _left || _right) {
			velocity.x = rawSpeed;
			velocity.y = rawSpeed;
		
		
			var mA:Float = 0;
			if (_up)
			{
				mA = -90;
				if (_left)
					mA -= 45;
				else if (_right)
					mA += 45;
			}
			else if (_down)
			{
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
			}
			else if (_left)
				mA = 180;
			else if (_right)
				mA = 0;
			
			velocity.set(rawSpeed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), mA);
		}
	}
	
}