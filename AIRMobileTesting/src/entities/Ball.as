package entities
{
	import Box2D.Collision.Shapes.b2CircleShape;
	
	import com.mistermartinez.entities.b2Entity;
	import com.mistermartinez.math.Vector2D;
	
	import components.CAccelorometerMovement;
	import components.CKeyboardControl;
	import components.CTouchMovement;
	
	import flash.sensors.Accelerometer;
	import flash.ui.Multitouch;
	
	public class Ball extends b2Entity
	{
		public function Ball(position:Vector2D, radius:Number)
		{
			super(position, false);
			var shape:b2CircleShape = new b2CircleShape(radius);
			addFixture(createFixtureDefinition(shape));
			if (Accelerometer.isSupported)
				addComponent(new CAccelorometerMovement(this));
			if (Multitouch.supportsTouchEvents)
				addComponent(new CTouchMovement(this));
		}
	}
}