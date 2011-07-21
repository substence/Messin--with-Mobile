package entities
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	
	import com.mistermartinez.entities.b2Entity;
	import com.mistermartinez.math.Vector2D;
	import com.mistermartinez.utils.Box2DHandler;
	import com.mistermartinez.utils.InputHandler;
	
	import flash.geom.Rectangle;
	
	public class Bound extends b2Entity
	{
		public function Bound(dimensions:Rectangle)
		{
			super(new Vector2D(dimensions.x, dimensions.y), false);
			_bodyDefinition.type = b2Body.b2_staticBody;
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(dimensions.width / Box2DHandler.DRAW_SCALE, dimensions.height / Box2DHandler.DRAW_SCALE);
			addFixture(createFixtureDefinition(shape));
		}
	}
}