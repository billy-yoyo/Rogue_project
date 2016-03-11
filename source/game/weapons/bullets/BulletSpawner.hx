package game.weapons.bullets;
import game.effects.SpriteEffect;
import game.weapons.Weapon;
import game.weapons.damage.DamageModel;
import game.weapons.bullets.Bullet;

/**
 * ...
 * @author billy
 */
class BulletSpawner
{
	public var bulletType:Class<Bullet>;
	public var fuse:Float = 0.5;
	public var explosionAmount:Int = 15;
	public var life:Float = 1;
	public var spiral:Float = 0;
	public var damage:DamageModel = new DamageModel(0);
	
	public var bulletEffects:Array<SpriteEffect>;
	public var weapon:Weapon;
	
	public function new(weapon:Weapon, bulletType:Class<Bullet>) 
	{
		this.weapon = weapon;
		this.bulletType = bulletType;
		this.bulletEffects = new Array<SpriteEffect>();
	}
	
	public function create(level:PlayState, X:Float, Y:Float, SpeedX:Float = 0, SpeedY:Float = 0):Bullet {
		var bullet:Bullet = Type.createEmptyInstance(bulletType).createBullet(level, X, Y, SpeedX, SpeedY, this);
		
		for (effect in bulletEffects) {
			bullet.effects.push(effect.copy(bullet));
		}
		return bullet;
	}
}