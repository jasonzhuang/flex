package components.browserDragList {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IVisualElement;
	import mx.core.InteractionMode;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import spark.components.List;

	use namespace mx_internal;  //ListBase and List share selection properties that are mx_internal
	
	/**
	 *	BrowserDragList :when drag-drop, behevior seems like browser tab
	 */
	public class BrowserDragList extends List {
		override protected function dragCompleteHandler(event:DragEvent):void {
			super.dragCompleteHandler(event);
			
			if(event.action == DragManager.NONE && event.dragInitiator == this){
				setDraggingTabVisibility(true);
			}
		}
		
		override protected function dragDropHandler(event:DragEvent):void {
			super.dragDropHandler(event);
			if(mouseDownIndex == -1) {
				return;
			}
			setDraggingTabVisibility(true);
		}
		
		override protected function mouseMoveHandler(event:MouseEvent):void {
			if (!mouseDownPoint || !dragEnabled)
				return;
			
			var pt:Point = new Point(event.localX, event.localY);
			pt = DisplayObject(event.target).localToGlobal(pt);
			
			const DRAG_THRESHOLD:int = 5;
			
			if (Math.abs(mouseDownPoint.x - pt.x) > DRAG_THRESHOLD ||
				Math.abs(mouseDownPoint.y - pt.y) > DRAG_THRESHOLD)
			{
				var dragEvent:DragEvent = new DragEvent(DragEvent.DRAG_START);
				dragEvent.dragInitiator = this;
				
				var localMouseDownPoint:Point = this.globalToLocal(mouseDownPoint);
				
				dragEvent.localX = localMouseDownPoint.x;
				dragEvent.localY = localMouseDownPoint.y;
				dragEvent.buttonDown = true;
				
				// We're starting a drag operation, remove the handlers
				// that are monitoring the mouse move, we don't need them anymore:
				dispatchEvent(dragEvent);
				
				//hide the tab that is currently being dragged
				setDraggingTabVisibility(false);
				
				// Finally, remove the mouse handlers
				removeMouseHandlersForDragStart(event);
			}
		}
		
		protected function removeMouseHandlersForDragStart(event:Event):void {
			// If dragging failed, but we had a pending selection, commit it here
			if (pendingSelectionOnMouseUp && !DragManager.isDragging)
			{
				if (getStyle("interactionMode") == InteractionMode.TOUCH)
				{
					// if in touch mode, and we didn't start scrolling, let's check to see
					// whether we moused up on the same item we mouse downed on. 
					// we don't do this check for mouse mode because technically selection happens 
					// on mousedown there.
					
					// this selectionChange check is basically a "click" check to make sure we moused downed on 
					// the same item that we moused up on.
					// We could just put it in click handler, but this is a little easier in mouseup
					// since we've combined some dragging logic and some touch interaction 
					// logic around pendingSelectionOnMouseUp.
					var selectionChange:Boolean = (event.target == mouseDownObject || 
						(mouseDownObject is DisplayObjectContainer && 
							DisplayObjectContainer(mouseDownObject).contains(event.target as DisplayObject)));
					
					// check to make sure they clciked on an item and selection should change
					if (selectionChange)
					{
						// now handle the cases where the item is being selected or de-selected
						// based on allowMultipleSelection
						if (allowMultipleSelection)
						{
							setSelectedIndices(calculateSelectedIndices(mouseDownIndex, pendingSelectionShiftKey, pendingSelectionCtrlKey), true);
						}
						else
						{
							setSelectedIndex(mouseDownIndex, true);
						}
					}
				}
				else
				{
					// if in mouse interactionMode, we must have finished an attempted drag, so let's
					// select the item if in multi-select mode or de-select the item 
					// if in single select mode.  See item_mouseDownHandler for how this was setup
					if (allowMultipleSelection)
					{
						setSelectedIndices(calculateSelectedIndices(mouseDownIndex, pendingSelectionShiftKey, pendingSelectionCtrlKey), true);
					}
					else
					{
						// Must be deselecting the current selected item since the only
						// reason we are here could be dragging
						setSelectedIndex(NO_SELECTION, true);
					}
				}
			}
		}
		
		protected function setDraggingTabVisibility(value:Boolean):void {
			var renderer:IVisualElement = dataGroup.getElementAt(this.mouseDownIndex) as IVisualElement;
			renderer.visible = value;
		}
	}
}