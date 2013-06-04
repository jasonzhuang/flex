package components {
	import components.layout.AnimationTileLayout;
	
	import mx.events.DragEvent;
	
	import spark.components.List;
	import spark.layouts.supportClasses.DropLocation;
	
	/**
	 *	AnimationList
	 */
	public class AnimationList extends List {
		override protected function dragOverHandler(event:DragEvent):void {
			var movedIndices:Vector.<int> = this.selectedIndices;
			//super.dragDropHandler(event);
			
			var dropLocation:DropLocation = layout.calculateDropLocation(event);
			var dropIndex:int = dropLocation.dropIndex;
			
			if(needAnimation(dropIndex)) {
				AnimationTileLayout(layout).updateLayout(movedIndices, dropIndex);
			}
			
			super.dragOverHandler(event);
		}
		
		private function needAnimation(dropIndex:int):Boolean {
			return this.selectedIndices[0] != dropIndex;
		}
	}
}