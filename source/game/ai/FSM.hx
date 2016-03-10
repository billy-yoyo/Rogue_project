package game.ai;
import haxe.Constraints.FlatEnum;

/**
 * ...
 * @author billy
 */
class FSM
{
	
	public var stateSpriteData:Map<String, RSprite>;
	public var stateStringData:Map<String, String>;
	private var states:Map<String, AIState>;
	private var state:String;
	public function new() 
	{
		states = new Map<String, AIState>();
		stateSpriteData = new Map<String, RSprite>();
		stateStringData = new Map<String, String>();
	}
	
	public function registerState(stateName:String, newState:AIState):FSM {
		states.set(stateName, newState);
		return this;
	}
	
	public function setState(state:String):Void {
		if (this.state != null) {
			states.get(this.state).end();
		}
		this.state = state;
		states.get(this.state).begin();
	}
	
	public function update(elapsed:Float):Void {
		if (this.state != null) {
			states.get(state).update(elapsed);
		}
	}
}