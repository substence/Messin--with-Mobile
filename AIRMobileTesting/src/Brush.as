package
{
	import flash.display.Shape;
	
	public class Brush extends Shape
	{
		public var id:uint;
		public var color:uint;
		
		public function Brush(x:uint, y:int)
		{
			color = Math.random() * 0xFFFFFF;
			graphics.lineTo(x, y);
		}
		
		public function drawLineTo(localX:Number, localY:Number, pressure:Number = 1):void
		{
			graphics.lineStyle(1 + (pressure * 30), color);
			graphics.lineTo(localX, localY);
		}
	}
}