package
{
	import com.mistermartinez.core.MML;
	import com.mistermartinez.math.Vector2D;
	
	import entities.Ball;
	import entities.Bound;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import namespaces.*;
	
	[SWF(frameRate="30")]
	public class AIRMobileTesting extends Sprite
	{
		public const WIDTH:uint = stage.stageWidth / 2;
		public const HEIGHT:uint = 816 / 2;
		public var brushes:Object;
		public var accelerometer:Accelerometer;        
		
		public function AIRMobileTesting()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			MML.initialize(stage);
			brushes = {};
			if (Accelerometer.isSupported)
			{
				accelerometer = new Accelerometer();
				MML.defaultGroup.injector.mapValue(Accelerometer, accelerometer);
			}
			if (Multitouch.supportsTouchEvents)
			{
				use namespace mobile;
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			}
			else
			{
				use namespace desktop;
			}
			addEventListeners();
			addBounds();
			var ball:Ball = new Ball(new Vector2D(WIDTH, HEIGHT), 1);
		}
		
		private function addBounds():void
		{
			const SIZE:uint = 10;
			var bound:Bound = new Bound(new Rectangle(WIDTH,-SIZE,WIDTH,SIZE));	//TOP
			bound =  new Bound(new Rectangle(WIDTH * 2, 0, SIZE, HEIGHT * 2)); //RIGHT
			bound =  new Bound(new Rectangle(WIDTH, HEIGHT * 2, WIDTH, SIZE)); //BOT
			bound =  new Bound(new Rectangle(-SIZE,HEIGHT, SIZE, HEIGHT)); //LEFT
		}
		
		mobile function addEventListeners():void
		{
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		}
		
		desktop function addEventListeners():void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			var brush:Brush = brushes["mouse"];
			if (!brush)
				return;
			brush.drawLineTo(event.stageX, event.stageY)
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			var brush:Brush = brushes["mouse"];
			removeChild(brush);
			brush = null;
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			var brush:Brush = new Brush(event.stageX, event.stageY);
			brushes["mouse"] = brush;
			addChild(brush);
		}
		
		protected function onTouchMove(event:TouchEvent):void
		{
			var brush:Brush = brushes[event.touchPointID];
			if (!brush)
				return;
			brush.drawLineTo(event.stageX, event.stageY, event.pressure)
		}
		
		protected function onTouchBegin(event:TouchEvent):void
		{
			var brush:Brush = new Brush(event.stageX, event.stageY);
			brush.id = event.touchPointID;
			brushes[brush.id] = brush;
			addChild(brush);
		}
		
		protected function onTouchEnd(event:TouchEvent):void
		{
			removeChild(brushes[event.touchPointID]);
			brushes[event.touchPointID] = null;
		}
	}
}