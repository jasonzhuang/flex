package skins.customerTab {
	
	import flash.geom.PerspectiveProjection;
	
	import mx.core.IFactory;
	import mx.core.IVisualElement;
	
	import spark.components.DataGroup;
	import spark.components.Group;
	import spark.components.IItemRenderer;
	import components.customerTab.CustomTabBar;
	
	
	public class CustomButtonBarButtonDragProxy extends Group {
		public function CustomButtonBarButtonDragProxy() {
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			
			//var list:List = owner as List;
			var list:CustomTabBar = owner as CustomTabBar;
			if (!list) {
				return;
			}
			
			if(list.mouseDownIndex == -1){
				return;
			}
			
			var dataGroup:DataGroup = list.dataGroup;
			if (!dataGroup) {
				return;
			}
			
			this.styleName = list;
			
			width = dataGroup.width;
			height = dataGroup.height;
			
			var element:IVisualElement = dataGroup.getElementAt(list.mouseDownIndex);
			if (!element || !(element is IItemRenderer)){ //this probably doesn't need to be here since we don't support virtual layouts
				return;
			}
			
			var perspectiveProjection:PerspectiveProjection = dataGroup.transform.perspectiveProjection;
			
			var clone:IItemRenderer = cloneItemRenderer(IItemRenderer(element), list);
			
			// Copy the dimensions
			clone.width = element.width;
			clone.height = element.height;
			
			// Copy the transform
			if (element.hasLayoutMatrix3D) {
				clone.setLayoutMatrix3D(element.getLayoutMatrix3D(), false);
			}
			else {
				clone.setLayoutMatrix(element.getLayoutMatrix(), false);
			}
			
			// Copy other relevant properties
			clone.depth = element.depth;
			//clone.visible = element.visible;
			if (element.postLayoutTransformOffsets)
				clone.postLayoutTransformOffsets = element.postLayoutTransformOffsets;
			
			// Put it in a dragging state
			clone.dragging = true;
			
			// Add the clone as a child
			addElement(clone);
			
			if(element.is3D){
				transform.perspectiveProjection = perspectiveProjection;
			}
		}
		
		private function cloneItemRenderer(renderer:IItemRenderer, list:CustomTabBar):IItemRenderer {
			// Create a new ItemRenderer:
			// 1. if itemRendererFunction is defined, call it to get the renderer factory and instantiate it
			// 2. if itemRenderer is defined, instantiate one
			
			// 1. if itemRendererFunction is defined, call it to get the renderer factory and instantiate it    
			var rendererFactory:IFactory;
			var itemRendererFunction:Function = list.itemRendererFunction;
			var data:Object = renderer.data;
			if (itemRendererFunction != null)
				rendererFactory = itemRendererFunction(data);
			
			// 2. if itemRenderer is defined, instantiate one
			if (!rendererFactory)
				rendererFactory = list.itemRenderer;
			
			var newRenderer:IItemRenderer = rendererFactory.newInstance();
			
			// Initialize the item renderer
			if (!newRenderer)
				return null;
			
			// The list is the IItemRendererOwner for this renderer.
			// It will set all the properties on this renderer, based on 
			// the itemIndex and data.
			list.updateRenderer(newRenderer, renderer.itemIndex, data);
			
			return newRenderer;
		}
	}
}