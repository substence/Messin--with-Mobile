package components{		import Box2D.Common.Math.b2Vec2;
	
	import com.mistermartinez.components.Component;
	import com.mistermartinez.entities.b2Entity;
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.InputHandler;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	public class CKeyboardControl extends Component implements IUpdatable	{				public var leftKeys:Vector.<int> = Vector.<int>([Keyboard.A, Keyboard.LEFT]);		public var upKeys:Vector.<int> = Vector.<int>([Keyboard.W, Keyboard.UP]);		public var rightKeys:Vector.<int> = Vector.<int>([Keyboard.D, Keyboard.RIGHT]);		public var downKeys:Vector.<int> = Vector.<int>([Keyboard.S, Keyboard.DOWN]);		[Inject]		public var input:InputHandler;				public function update():void		{			onKeyDown(null);		}		protected function onKeyDown(event:KeyboardEvent):void		{					var direction:Vector2D = new Vector2D();			if (input.areAnyKeysDown(leftKeys))				direction.x -= 1;			if (input.areAnyKeysDown(rightKeys))				direction.x += 1;			if (input.areAnyKeysDown(upKeys))				direction.y -= 1;			if (input.areAnyKeysDown(downKeys))				direction.y += 1;			if (direction.x != 0 || direction.y != 0)			{				direction.multiply(100);				b2Entity(owner).applyForce(direction);			}		}				override protected function onUnregister():void		{			//_user.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);		}				override protected function onRegister():void		{			//_user.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);		}	}}