package components {
	import flash.geom.Point;
	
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.Image;
	import spark.components.List;
	
	import vo.PhotoVO;
	
	use namespace mx_internal;
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
			
			//here we want the dragView point be equal with mouseDown
			//refer List source code of mouseMoveHandler 
			var localMouseDownPoint:Point = this.globalToLocal(mouseDownPoint);
			dragView.x = localMouseDownPoint.x; /*- element.dragThumb.width/2;*/
			dragView.y = localMouseDownPoint.y; /*- element.dragThumb.height/2;*/
			dragView.dragViewSource = element;
			dragView.selectedPhotoes = count;
			return dragView;
		}
	}
}