package game.weapons.bullets;

import flixel.FlxG;
import flixel.util.FlxColor;
import game.weapons.damage.DamageModel;
/**
 * ...
 * @author billy
 */
class AndrewsBullet extends Bullet
{    
    public var spiralAngle:Float = 0;
	
	public function new(level:PlayState, X:Float, Y:Float, SpeedX:Float, SpeedY:Float, damage:DamageModel) 
	{
		super(level, X, Y, SpeedX, SpeedY, damage);
		makeGraphic(2, 2, FlxColor.BLUE);
	}

    override private function movement(elapsed:Float):Void
    {   
		spiralAngle += 0.5;
        var dx:Float = (speed.x * elapsed) + (Math.sin(spiralAngle) * 2);
        var dy:Float = (speed.y * elapsed) + (Math.sin(spiralAngle) * 2);
        
        
        /*var bulletTrace = new BulletTrace(level, new FlxPoint(this.x + centre_x_offset, this.y + centre_y_offset), 
                                                 new FlxPoint(this.x + dx + centre_x_offset, this.y + dy + centre_y_offset), 0.05);
        level.add(bulletTrace);*/
        
        this.x += dx;
        this.y += dy;
        
        FlxG.collide(this, level.enemies, handleEnemyCollision);
        if (FlxG.collide(this, level.tilemap)) {
            this.hasCollided = true;
            level.remove(this);
        }
    }
    
}