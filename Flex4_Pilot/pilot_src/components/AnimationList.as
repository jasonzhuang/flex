package components {
	import components.layout.AnimationTileLayout;
	
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	
	import spark.components.List;
	import spark.layouts.supportClasses.DropLocation;
	
	/**
	 *	AnimationList
	 */
	public class AnimationList extends List {
		/*override protected function dragOverHandler(event:DragEvent):void {
			var movedIndices:Vector.<int> = this.selectedIndices;
			//super.dragDropHandler(event);
			
			var dropLocation:DropLocation = layout.calculateDropLocation(event);
			var dropIndex:int = dropLocation.dropIndex;
			
			trace("drag over index: ", dropIndex);
			
			setDraggingItemVisibility(false);
			//TODO:need determine when can't animate?
			AnimationTileLayout(layout).updateLayout(movedIndices, dropIndex);
			
			//super.dragOverHandler(event);
		}*/
		
		/*override protected function dragDropHandler(event:DragEvent):void {
			//super.dragDropHandler(event);
			if(mouseDownIndex == -1) {
				return;
			}
			setDraggingItemVisibility(true);
		}*/
		
		private function setDraggingItemVisibility(value:Boolean):void {
			for (var index:int = 0; index < this.selectedIndices.length ; index++) {
				var item:IVisualElement = layout.target.getElementAt(index) as IVisualElement;
				item.visible = value;
			}
		}
		
		private function needAnimation(dropIndex:int):Boolean {
			return this.selectedIndices[0] != dropIndex;
		}
	}
}