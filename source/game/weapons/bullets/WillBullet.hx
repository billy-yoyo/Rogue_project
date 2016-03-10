package game.weapons.bullets;

import flixel.FlxG;
import flixel.math.FlxPoint;
import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class WillBullet extends Bullet
{    
    public var spiralAngle:Float = 0;
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel, spiral:Float = 0) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		spiralAngle = spiral;
	}

    override private function movement(elapsed:Float):Void
    {
		spiralAngle += 0.2;
		var perpVec:FlxPoint = getPerp(Math.sin(spiralAngle) * 0.5);
        var dx:Float = (speed.x * elapsed) + perpVec.x;
        var dy:Float = (speed.y * elapsed) + perpVec.y;
        
        
        /*var bulletTrace = new BulletTrace(level, new FlxPoint(this.x + centre_x_offset, this.y + centre_y_offset), 
                                                 new FlxPoint(this.x + dx + centre_x_offset, this.y + dy + centre_y_offset), 0.05);
        level.add(bulletTrace);*/
        
        moveSprite(dx, dy);
    }
    
}