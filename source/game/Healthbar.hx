package game;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxSpriteUtil.LineStyle;
import game.RSprite;
/**
 * ...
 * @author billy
 */
class Healthbar extends FlxSprite
{

	public var parent:RSprite;
	public var maxHealth:Float;
	public var borderSize:Float;
	public var rel_x:Float;
	public var rel_y:Float;
	
	private var interpols:Array<FlxColor>;
	private var lineStyle:LineStyle;
	public function new(parent:RSprite, maxHealth:Float, rel_x:Float, rel_y:Float, width:Int, height:Int, borderSize:Float = 2, borderColor:FlxColor = FlxColor.BLACK) 
	{
		super(parent.x + rel_x, parent.y + rel_y);
		this.rel_x = rel_x;
		this.rel_y = rel_y;
		this.parent = parent;
		this.maxHealth = maxHealth;
		this.interpols = [FlxColor.RED, FlxColor.ORANGE, FlxColor.GREEN];
		this.borderSize = borderSize;
		this.lineStyle = { color: FlxColor.BLACK, thickness: borderSize }
		makeGraphic(width, height, FlxColor.BLACK);
		updateHealth();
	}
	
	public function updatePosition() {
		this.x = parent.x + rel_x;
		this.y = parent.y + rel_y;
	}
	
	public function getColour() {
		var percent:Float = parent.health / maxHealth;
		if (percent < 0.5) {
			return FlxColor.interpolate(interpols[0], interpols[1], percent * 2);
		} else {
			return FlxColor.interpolate(interpols[1], interpols[2], (percent - 0.5) * 2);
		}
	}
	
	public function getWidth():Int {
		var percent:Float = parent.health / maxHealth;
		return Math.ceil(percent * (width - (2*borderSize)));
	}
	
	public function updateHealth() {
		FlxSpriteUtil.drawRect(this, 0, 0, width, height, FlxColor.WHITE, lineStyle);
		var cwidth:Int = getWidth();
		if (cwidth > 0) {
			FlxSpriteUtil.drawRect(this, borderSize, borderSize, cwidth, height - (2 * borderSize), getColour());
		}
	}
}