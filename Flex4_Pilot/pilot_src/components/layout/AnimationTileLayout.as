package components.layout {
	
	import mx.core.ILayoutElement;
	import mx.effects.CompositeEffect;
	import mx.effects.Parallel;
	import mx.effects.Sequence;
	import mx.events.EffectEvent;
	
	import spark.effects.Move;
	import spark.layouts.TileLayout;
	import spark.layouts.supportClasses.DropLocation;
	import spark.layouts.supportClasses.LayoutBase;
	
	/**
	 *	AnimationTileLayout
	 */
	public class AnimationTileLayout extends TileLayout {
		public var moveDuration:int = 300;
		//TODO:parallel or sequence
		public var moveEffects:CompositeEffect;
		
		private var moveIndies:Vector.<int>;
		
		/**
		 * TODO:
		 */
		public function updateLayout(selectedIndies:Vector.<int>, dropIndex:int):void {
			//NOTE: Prevent updateDisplayList() from being executed while we are animating items
			target.autoLayout = false;
			moveIndies = selectedIndies;
			var startIndex:int = selectedIndies[0];
			
			trace("startIndex: ", startIndex, " dropIndex: ", dropIndex);
			
			var prevItem:ILayoutElement;
			var movingItem:ILayoutElement;
			var x:int;
			var y:int;
			var move:Move;
			var step:int = startIndex < dropIndex ? 1 : -1;
			
			moveEffects = new Parallel();
			
			for (var index:int = startIndex; index != dropIndex; index= index + step) {
				prevItem = target.getElementAt(index);
				movingItem = target.getElementAt(index + 1);
				move = new Move(movingItem);
				move.xTo = prevItem.getLayoutBoundsX();
				move.yTo = prevItem.getLayoutBoundsY();
				moveEffects.addChild(move);
			}
			
			moveItems();
		}
		
		private function moveItems():void {
			// Undesired behaviors may happen if we leave items with alpha=0 in the display list while performing other animations 
			//setInvisibleItems();
			
			if(moveEffects.children.length > 0) {
				moveEffects.duration = moveDuration;
				moveEffects.addEventListener(EffectEvent.EFFECT_END, moveItemsEnd);
				moveEffects.play();
			}
		}
		
		private function moveItemsEnd(event:EffectEvent):void {
			target.autoLayout = true;
		}
		
		
		//---------------------------------------------------------------------
		//TODO:move to util
		private function inRange(source:Vector.<int>, index:int):Boolean {
			if(index < source[0] || index > source[source.length -1])
			{
				return false;
			} 
			else 
			{
				return true;
			}
		}
		
		private function setInvisibleItems():void {
			for (var index:int = 0; index< target.numElements; index++) {
				if(inRange(moveIndies, index))
				{
					target.getElementAt(index).visible = false;
					trace("trigger invisible");
				}
			}
		}
	}
}