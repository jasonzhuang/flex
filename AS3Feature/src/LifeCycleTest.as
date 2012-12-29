package {
	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *	LiftCycleTest
	 */
	public class LifeCycleTest extends Sprite {
		/**
		 * 
		 */
		public function LifeCycleTest() {
			//objectLifeCycle();
			//eventHandler();
			eventBroadcast();
		}
		
		/**
		 * Creation:
		    1. All display objects initialized
		        1.1 Display list hierarchy created
		        1.2 Class properties assigned
		    2. Display objects constructed, children first, bottom up
		        2.1 Parent instance variables set; DisplayObject.name defined
		        2.2 Display list properties set (parent, stage, root, loaderInfo)
		        2.3 Constructors called
		        2.4 Event: DisplayObject.added
		        2.5 Event: DisplayObject.addedToStage

 			==================================================
			Destrcution:
		    1. Display objects removed from display list, bottom up (Top-most parent of removed display list only)
		    2. Event: DisplayObject.removed (Top-most parent of removed display list only)
		    3. Event: DisplayObject.removedFromStage
		        Event: DisplayObject.removedFromStage, <b>parents first, bottom up(depth 0, 1, 2...)</b>
		    4. Parent instance name variable nulled
		    5. Display list properties nulled (parent, stage, root, loaderInfo)
		    6. Display object destroyed by the GC (Pending any lingering references)
	        NOTE:
			 * only the top-most parent is removed from the active display list, 
			 * all descendents in display list getting removed will get a <b>removedFromStage</b> event,
			 * the children do not get their own <b>removed</b> event
		 */
		private function objectLifeCycle():void {
			var rect:Sprite = new Sprite();
			rect.addEventListener(Event.REMOVED, removeHandler);
			rect.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			rect.graphics.beginFill(0xffff00, 0.5);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			var innerRect:Shape = new Shape();
			innerRect.addEventListener(Event.REMOVED, removeHandler2);
			innerRect.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage2);
			innerRect.graphics.beginFill(0xff0000, 1);
			innerRect.graphics.drawRect(5,15,30,40);
			innerRect.graphics.endFill();
			rect.addChild(innerRect);
			addChild(rect);
			removeChild(rect);
		}
		
		/**
		 * By default, listeners added first will get called first.
		 */
		private function eventHandler():void {
			addEventListener(Event.ENTER_FRAME, handler1); // called third 
			addEventListener(Event.ENTER_FRAME, handler2); // called fourth
			addEventListener(Event.ENTER_FRAME, handler3, false, 10); // called first
			addEventListener(Event.ENTER_FRAME, handler4, false, 10); // called second
			
			function handler1(event:Event):void {
				
			}
			
			function handler2(event:Event):void {
				
			}
			
			function handler3(event:Event):void {
				
			}
			
			function handler4(event:Event):void {
				
			}
		}
		
		/**
		 * stage was given its first enterFrame listener after this was, its listeners won't get called until all of the listeners added to this have fired.
		 * The priority parameter will have no affect on this since it only applies to an individual object's listener set.
		 */
		private function eventBroadcast():void {
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xff0000, 1);
			rect.graphics.drawRect(0,0,100,100);
			rect.graphics.endFill();
			addChild(rect);
			rect.addEventListener(MouseEvent.CLICK, handler1); // called first
			stage.addEventListener(MouseEvent.CLICK, handler2, false, 10); // called third
			rect.addEventListener(MouseEvent.CLICK, handler3); // called second
			
			function handler1(event:Event):void {
				trace("handler1");
			}
			
			function handler2(event:Event):void {
				trace("handler2");
			}
			
			function handler3(event:Event):void {
				trace("handler3");
			}
		}
		
		private function removeHandler(event:Event):void {
			trace("rect remove event occur");
		}
		
		private function removeHandler2(event:Event):void {
			trace("innerRect remove event occur");
		}
		
		private function removeFromStage(event:Event):void {
			trace("rect remove from stage event occur");
		}
		
		private function removeFromStage2(event:Event):void {
			trace("ninnerRect remove from stage event occur");
		}
	}
}