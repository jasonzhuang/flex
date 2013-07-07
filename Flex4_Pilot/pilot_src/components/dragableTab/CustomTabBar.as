package components.dragableTab {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.core.DragSource;
	import mx.core.EventPriority;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.DragManager;
	
	import spark.components.IItemRenderer;
	import spark.components.TabBar;
	import spark.events.RendererExistenceEvent;
	import spark.layouts.supportClasses.DropLocation;
	
	[Style(name="dragIndicatorClass", type="Class", inherit="no")]
	[Style(name="dropIndicatorSkin", type="Class", inherit="no")]
	
	[Event(name='tabReordered', type='components.dragableTab.CustomTabBarReorderEvent')]
	
	public class CustomTabBar extends TabBar {
		
		[SkinPart(required="false", type="flash.display.DisplayObject")]
		public var dropIndicator:IFactory;
		
		//set in item_mouseDownHandler
		private var mouseDownPoint:Point;
		public var mouseDownIndex:int = -1;
		
		public function CustomTabBar() {
			super();
		}
		
		private var _dragEnabled:Boolean = false;
		
		public function get dragEnabled():Boolean {
			return _dragEnabled;
		}
		
		public function set dragEnabled(value:Boolean):void {
			if (value == _dragEnabled)
				return;
			_dragEnabled = value;
			
			if (_dragEnabled) {
				addEventListener(DragEvent.DRAG_START, dragStartHandler, false, EventPriority.DEFAULT_HANDLER);
				//DRAG_COMPLETE is dispatched by DragProxy : mx.managers.dragClasses.DragProxy
				addEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_OVER, dragOverHandler, false, EventPriority.DEFAULT_HANDLER);
				addEventListener(DragEvent.DRAG_DROP, dragDropHandler, false, EventPriority.DEFAULT_HANDLER);
			}
			else {
				removeEventListener(DragEvent.DRAG_START, dragStartHandler, false);
				removeEventListener(DragEvent.DRAG_COMPLETE, dragCompleteHandler, false);
				removeEventListener(DragEvent.DRAG_ENTER, dragEnterHandler, false);
				removeEventListener(DragEvent.DRAG_EXIT, dragExitHandler, false);
				removeEventListener(DragEvent.DRAG_OVER, dragOverHandler, false);
				removeEventListener(DragEvent.DRAG_DROP, dragDropHandler, false);
			}
		}
		
		protected function dragStartHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			var dragSource:DragSource = new DragSource();
			dragSource.addData(dataProvider.getItemAt(mouseDownIndex), "draggedTabItem");
			
			DragManager.doDrag(this, 
				dragSource, 
				event,
				createDragIndicator(),
				0,
				0,
				0.5,
				true
			);
		}
		
		public function createDragIndicator():IFlexDisplayObject {
			var dragIndicator:IFlexDisplayObject;
			var dragIndicatorClass:Class = Class(getStyle("dragIndicatorClass"));
			if (dragIndicatorClass) {
				dragIndicator = new dragIndicatorClass();
			}
			if (dragIndicator is IVisualElement) {
				IVisualElement(dragIndicator).owner = this;
			}
			
			return dragIndicator;
		}
		
		protected function dragCompleteHandler(event:DragEvent):void {
			if (event.isDefaultPrevented()) {
				return;
			}
			
			//check if the drag was successfull and if it wasn't set the visibility of the tab we were dragging back to true
			if(event.action == DragManager.NONE && event.dragInitiator == this){
				setDraggingTabVisibility(true);
			}
			
			//NOTE: Right now I am not supporting dragging tabs to other tabBars, so we don't need to do anything here yet.
			//refer List dragCompleteHandler() source code
		}
		
		override protected function dataGroup_rendererAddHandler(event:RendererExistenceEvent):void {
			var index:int = event.index;
			var renderer:IVisualElement = event.renderer;
			
			if (!renderer)
				return;
			
			renderer.addEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
		}
		
		protected function item_mouseDownHandler(event:MouseEvent):void {
			var newIndex:int;
			if (event.currentTarget is IItemRenderer)
				newIndex = IItemRenderer(event.currentTarget).itemIndex;
			else
				newIndex = dataGroup.getElementIndex(event.currentTarget as IVisualElement);
			
			mouseDownPoint = event.target.localToGlobal(new Point(event.localX, event.localY));
			mouseDownIndex = newIndex;
			
			if(dragEnabled){
				systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
				systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler, false, 0, true);
				systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			}
		}
		
		protected function mouseMoveHandler(event:MouseEvent):void {
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
				removeMouseHandlersForDragStart();
			}
			
		}
		
		protected function dragEnterHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			var dropLocation:DropLocation = calculateDropLocation(event); 
			if (dropLocation)
			{
				DragManager.acceptDragDrop(this);
				
				// Create the dropIndicator instance. The layout will take care of
				// parenting, sizing, positioning and validating the dropIndicator.
				createDropIndicator();
				
				// Show focus
				//drawFocusAnyway = true;
				//drawFocus(true);
				
				// Notify manager we can drop
				DragManager.showFeedback(event.ctrlKey ? DragManager.COPY : DragManager.MOVE);
				
				// Show drop indicator
				layout.showDropIndicator(dropLocation);
			}
			else
			{
				DragManager.showFeedback(DragManager.NONE);
			}
		}
		
		private function calculateDropLocation(event:DragEvent):DropLocation {
			// Verify data format
			if (!enabled || !event.dragSource.hasFormat("draggedTabItem")) {
				return null;
			}
			
			// Calculate the drop location
			return layout.calculateDropLocation(event);
		}
		
		public function createDropIndicator():DisplayObject {
			// Do we have a drop indicator already?
			if (layout.dropIndicator)
				return layout.dropIndicator;
			
			var dropIndicatorInstance:DisplayObject;
			if (dropIndicator)
			{
				dropIndicatorInstance = DisplayObject(createDynamicPartInstance("dropIndicator"));
			}
			else
			{
				var dropIndicatorClass:Class = Class(getStyle("dropIndicatorSkin"));
				if (dropIndicatorClass)
					dropIndicatorInstance = new dropIndicatorClass();
			}
			if (dropIndicatorInstance is IVisualElement)
				IVisualElement(dropIndicatorInstance).owner = this;
			
			// Set it in the layout
			layout.dropIndicator = dropIndicatorInstance;
			return dropIndicatorInstance;
		}
		
		protected function dragExitHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			// Hide if previously showing
			layout.hideDropIndicator();
			
			// Hide focus
			//drawFocus(false);
			//drawFocusAnyway = false;
			
			// Destroy the dropIndicator instance
			destroyDropIndicator();
		}
		
		public function destroyDropIndicator():DisplayObject {
			var dropIndicatorInstance:DisplayObject = layout.dropIndicator;
			if (!dropIndicatorInstance)
				return null;
			
			// Release the reference from the layout
			layout.dropIndicator = null;
			
			// Release it if it's a dynamic skin part
			var count:int = numDynamicParts("dropIndicator");
			for (var i:int = 0; i < count; i++)
			{
				if (dropIndicatorInstance == getDynamicPartAt("dropIndicator", i))
				{
					// This was a dynamic part, remove it now:
					removeDynamicPartInstance("dropIndicator", dropIndicatorInstance);
					break;
				}
			}
			return dropIndicatorInstance;
		}
		
		protected function dragOverHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			var dropLocation:DropLocation = calculateDropLocation(event);
			if (dropLocation)
			{
				// Show focus
				//drawFocusAnyway = true;
				//drawFocus(true);
				
				// Notify manager we can drop
				DragManager.showFeedback(event.ctrlKey ? DragManager.COPY : DragManager.MOVE);
				
				// Show drop indicator
				CustomTabBarHorizontalLayout(layout).draggingIndex = mouseDownIndex;
				layout.showDropIndicator(dropLocation);
			}
			else
			{
				// Hide if previously showing
				layout.hideDropIndicator();
				
				// Hide focus
				//drawFocus(false);
				//drawFocusAnyway = false;
				
				// Notify manager we can't drop
				DragManager.showFeedback(DragManager.NONE);
			}
		}
		
		protected function dragDropHandler(event:DragEvent):void {
			if (event.isDefaultPrevented())
				return;
			
			// Hide the drop indicator
			layout.hideDropIndicator();
			destroyDropIndicator();
			
			// Hide focus
			//drawFocus(false);
			//drawFocusAnyway = false;
			
			// Get the dropLocation
			var dropLocation:DropLocation = calculateDropLocation(event);
			if (!dropLocation)
				return;
			
			// Find the dropIndex
			var dropIndex:int = dropLocation.dropIndex;
			
			// Make sure the manager has the appropriate action
			DragManager.showFeedback(event.ctrlKey ? DragManager.COPY : DragManager.MOVE);
			
			var dragSource:DragSource = event.dragSource;
			//get dragged item
			var item:Object = dragSource.dataForFormat("draggedTabItem") as Object;
			
			//remove the item from the dataProvider
			if (mouseDownIndex < dropIndex) {
				dropIndex--;
			}
			
			if(mouseDownIndex != dropIndex) {
				var e:CustomTabBarReorderEvent = new CustomTabBarReorderEvent(CustomTabBarReorderEvent.TAB_REORDERED,true,true);
				e.oldIndex = mouseDownIndex;
				e.newIndex = dropIndex;
				
				if(dispatchEvent(e)) {//make sure it was not prevented by some outside class
					//===========Note: for drag animation=========
					CustomTabBarHorizontalLayout(layout).doAnimationInLayout();

					dataProvider.removeItemAt(mouseDownIndex);
					dataProvider.addItemAt(item, dropIndex);
					selectedIndex = dropIndex;
					
				}
				else {
					//the reorder event was canceled/prevented by some outside class
					setDraggingTabVisibility(true);
				}
			}
			else {
				//the user just dragged to where the original dragged tab was so no reorder done
				setDraggingTabVisibility(true);
			}
		}
		
		protected function mouseUpHandler(event:Event):void {
			removeMouseHandlersForDragStart();
		}
		
		protected function removeMouseHandlersForDragStart():void {
			mouseDownPoint = null;
			
			systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false);
			systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false);
			systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler, false);
		}
		
		override protected function dataGroup_rendererRemoveHandler(event:RendererExistenceEvent):void {
			var index:int = event.index;
			var renderer:Object = event.renderer;
			
			if (!renderer)
				return;
			
			renderer.removeEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
		}
		
		protected function setDraggingTabVisibility(value:Boolean):void {
			var renderer:IVisualElement = dataGroup.getElementAt(this.mouseDownIndex) as IVisualElement;
			renderer.visible = value;
		}
		
		
		//////////////////////////////////////////CLOSING OF TABS///////////////////////////////////////////////////
		
		public function setCloseableTab(index:int, value:Boolean):void {
			if (index >= 0 && index < dataGroup.numElements) {
				var btn:CustomTabBarButton = dataGroup.getElementAt(index) as CustomTabBarButton;
				btn.closeable = value;
			}
		}
		public function getCloseableTab(index:int):Boolean {
			if (index >= 0 && index < dataGroup.numElements) {
				var btn:CustomTabBarButton = dataGroup.getElementAt(index) as CustomTabBarButton;
				return btn.closeable;
			}
			return false;
		}
		
		private function closeHandler(event:CustomTabBarCloseEvent):void {
			closeTab(event.index, selectedIndex);
		}
		
		public function closeTab(closedTab:int, selectedTab:int):void {
			if (dataProvider.length == 0) return;
			
			if (dataProvider is IList) {
				dataProvider.removeItemAt(closedTab);
			} else if (dataProvider is ViewStack){
				//remove the entire child from the dataProvider, which also removes it from the ViewStack
				(dataProvider as ViewStack).removeChildAt(closedTab);
			}
			
			//adjust selectedIndex appropriately
			if (dataProvider.length == 0) {
				selectedIndex = -1;
			} else if (closedTab < selectedTab) {
				selectedIndex = selectedTab - 1;
			} else if (closedTab == selectedTab) {
				selectedIndex = (selectedTab == 0 ? 0 : selectedTab - 1);
			} else {
				selectedIndex = selectedTab;
			}
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if(instance == dataGroup){
				dataGroup.addEventListener(RendererExistenceEvent.RENDERER_ADD, dataGroup_rendererAddHandler);
				dataGroup.addEventListener(RendererExistenceEvent.RENDERER_REMOVE, dataGroup_rendererRemoveHandler);
				dataGroup.addEventListener(CustomTabBarCloseEvent.CLOSE_TAB, closeHandler);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if(instance == dataGroup){
				dataGroup.removeEventListener(RendererExistenceEvent.RENDERER_ADD, dataGroup_rendererAddHandler);
				dataGroup.removeEventListener(RendererExistenceEvent.RENDERER_REMOVE, dataGroup_rendererRemoveHandler);
				dataGroup.removeEventListener(CustomTabBarCloseEvent.CLOSE_TAB, closeHandler);
			}
		}
	}
}