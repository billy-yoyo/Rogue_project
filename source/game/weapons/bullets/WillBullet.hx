package game.weapons.bullets;

import flixel.FlxG;
/**
 * ...
 * @author billy
 */
class WillBullet extends Bullet
{    
    private var spiralAngle:Float = 0;

    override private function movement(elapsed:Float):Void
    {
		spiralAngle += 0.05;
        var dx:Float = (speed.x * elapsed) + (Math.cos(spiralAngle) * 2);
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