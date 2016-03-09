package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	
	private var _btnPlay:FlxButton;
	override public function create():Void
	{
		super.create();
		add(new FlxText(0, 0, 0, "Hello World!"));
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		add(_btnPlay);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}
}