package components
{
	import com.mistermartinez.components.Component;
	import com.mistermartinez.entities.b2Entity;
	import com.mistermartinez.interfaces.IAdvancedSpatial;
	import com.mistermartinez.math.Vector2D;
	
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	
	public class CAccelorometerMovement extends Component
	{
		private var _mover:IAdvancedSpatial;
		[Inject]
		public var accelerometer:Accelerometer;
		
		public function CAccelorometerMovement(mover:IAdvancedSpatial)
		{
			_mover = mover;
		}
		
		override protected function onRegister():void
		{
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, onAccelerometerUpdate);
		}
		
		override protected function onUnregister():void
		{
			accelerometer.removeEventListener(AccelerometerEvent.UPDATE, onAccelerometerUpdate);
		}
		
		protected function onAccelerometerUpdate(event:AccelerometerEvent):void
		{
			var accelForce:Vector2D = new Vector2D(-event.accelerationX, event.accelerationY);
			accelForce.multiply(20);
			_mover.applyForce(accelForce);
		}
	}
}