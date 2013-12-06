package com.netease.view.common {
	import components.CustomDragIndicator;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.List;
	
	/**
	 *	CustomerList
	 */
	public class CustomerList extends List {
		
		override protected function calculateSelectedIndices(index:int, shiftKey:Boolean, ctrlKey:Boolean):Vector.<int>
		{
			return super.calculateSelectedIndices(index, shiftKey, true);
		}
		
		private function getItemIndex(item:Object):int {
			for (var i:int = 0; i < this.dataProvider.length; ++i) {
				if (this.dataProvider.getItemAt(i) == item) {
					return i;
				}
			}
			return -1;
		}
		
		override protected function dragStartHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			var dragSource:DragSource = new DragSource();
			addDragData(dragSource);
			var indicator:IFlexDisplayObject = createDragIndicator();
			dragSource.addData(indicator, "indicator");
			DragManager.doDrag(this, 
				dragSource, 
				event, 
				indicator,
				indicator.width / 2.0, //xOffset 
				indicator.height - 20, //yOffset
				1, //imageAlpha
				dragMoveEnabled);
			var items:Vector.<Object> = this.selectedItems;
			for each (var item:Object in items) {
				var itemIndex:int = getItemIndex(item);
				if(layout.useVirtualLayout) {
					layout.target.getVirtualElementAt(itemIndex).includeInLayout  = false;
					layout.target.getVirtualElementAt(itemIndex).visible = false;
				}else {
					layout.target.getElementAt(itemIndex).includeInLayout = false;
					layout.target.getElementAt(itemIndex).visible = false;
				}
			}
			// List drag&drop有个bug，快速点击的时候，StartHandler会被调用，但是CompleteHandler没有调用
			// 所以用stage事件来避开这个bug
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var max:int = this.dataProvider.length;
			for (var i:int = 0; i < max; ++i) {
				if(layout.useVirtualLayout) {
					if(layout.target.getElementAt(i)){
						layout.target.getVirtualElementAt(i).includeInLayout = true;
						layout.target.getVirtualElementAt(i).visible = true;
					}
				} else {
					if(layout.target.getVirtualElementAt(i)){
						layout.target.getElementAt(i).includeInLayout = true;
						layout.target.getElementAt(i).visible = true;
					}
					
				}
			}
		}
		
		override public function createDragIndicator():IFlexDisplayObject {
			var items:Vector.<Object> = this.selectedItems;
			var count:uint = items.length;
			
			var dragView:CustomDragIndicator = new CustomDragIndicator();
			
			if (dragView is IVisualElement) {
				IVisualElement(dragView).owner = this;
			}
			
			var element:PhotoRenderer;
			
			if (layout.useVirtualLayout) {
				element = PhotoRenderer(layout.target.getVirtualElementAt(selectedIndex));
			} else {
				element = PhotoRenderer(layout.target.getElementAt(selectedIndex));
			}
			
			//here we want the dragView point be equal with mouseDown
			//refer List source code of mouseMoveHandler 
			use namespace mx_internal;
			
			var localMouseDownPoint:Point = this.globalToLocal(mouseDownPoint);
			dragView.x = localMouseDownPoint.x; /*- element.dragThumb.width/2;*/
			dragView.y = localMouseDownPoint.y; /*- element.dragThumb.height/2;*/
			
			dragView.dragViewSource = element.dragThumb;
			dragView.selectedPhotoes = count;
			return dragView;
		}
		
		override protected function dragCompleteHandler(event:DragEvent):void 
		{
			var max:int = this.dataProvider.length;
			for (var i:int = 0; i < max; ++i) {
				if(layout.target.getVirtualElementAt(i)){
					layout.target.getVirtualElementAt(i).includeInLayout = true;
					layout.target.getVirtualElementAt(i).visible = true;
				}
			}
			super.dragCompleteHandler(event);
		}
	}
}