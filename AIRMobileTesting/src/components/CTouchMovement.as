package components
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	
	import com.mistermartinez.components.Component;
	import com.mistermartinez.entities.b2Entity;
	import com.mistermartinez.interfaces.IAdvancedSpatial;
	import com.mistermartinez.interfaces.IUpdatable;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.Box2DHandler;
	
	import flash.display.Stage;
	import flash.events.TouchEvent;
	
	public class CTouchMovement extends Component
	{
		private var _mover:b2Entity;
		private var _touchEvent:TouchEvent;
		private var _previousPosition:Vector2D;
		[Inject]
		public var stage:Stage;
		
		public function CTouchMovement(mover:b2Entity)
		{
			_mover = mover;
		}
		
		override protected function onRegister():void
		{
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);		
		}
		
		override protected function onUnregister():void
		{
			stage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);		
		}
		
		protected function onTouchMove(event:TouchEvent):void
		{
			if (_touchEvent)
			{
				_previousPosition = _mover.position.clone();
				_mover.position = new Vector2D(event.stageX, event.stageY);
			}
		}
		
		protected function onTouchBegin(event:TouchEvent):void
		{
			if (_mover.fixture.TestPoint(new b2Vec2(event.localX / Box2DHandler.DRAW_SCALE, event.localY / Box2DHandler.DRAW_SCALE)))	//are you touching the owner
			{
				_touchEvent = event;
			}
		}
		
		protected function onTouchEnd(event:TouchEvent):void
		{
			if (_touchEvent && _touchEvent.touchPointID == event.touchPointID)
			{
				_touchEvent = null;
				var inertia:Vector2D = _mover.position.subtract(_previousPosition);
				inertia.multiply(60);
				_mover.applyForce(inertia);
			}
		}
	}
}