package components {
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.Image;
	import spark.components.List;
	
	import vo.PhotoVO;
	
	/**
	 *	CustomerList
	 */
	public class CustomerList extends List {
		override protected function calculateSelectedIndices(index:int, shiftKey:Boolean, ctrlKey:Boolean):Vector.<int>
		{
			return super.calculateSelectedIndices(index, shiftKey, true);
		}
		
		override protected function dragStartHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
			return;
			
			var dragSource:DragSource = new DragSource();
			addDragData(dragSource);
			DragManager.doDrag(this, 
			dragSource, 
			event, 
			createDragIndicator(), 
			0, //xOffset 
			0, //yOffset
			1, //imageAlpha
			dragMoveEnabled);
		}
		
		override public function createDragIndicator():IFlexDisplayObject {
			var items:Vector.<Object> = this.selectedItems;
			var count:uint = items.length;
			
			var showPhoto:PhotoVO = items[0] as PhotoVO;
			trace("selected photo desc: ", showPhoto.desc);
			
			var dragView:CustomDragIndicator = new CustomDragIndicator();
			
			if (dragView is IVisualElement) {
				IVisualElement(dragView).owner = this;
			}
			
			var element:ILayoutElement;
			
			if (layout.useVirtualLayout) {
				element = layout.target.getVirtualElementAt(selectedIndex);
			} else {
				element = layout.target.getElementAt(selectedIndex);
			}
			
			dragView.x = element.getLayoutBoundsX();
			dragView.y = element.getLayoutBoundsY();
			
			dragView.width = element.getPreferredBoundsWidth();
			dragView.height = element.getPreferredBoundsHeight();
			dragView.dragViewSource = showPhoto.url;
			dragView.selectedPhotoes = count;
			return dragView;
		}
	}
}