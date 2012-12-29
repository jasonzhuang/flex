package {
	import flash.display.Sprite;
	
	import views.drag.DragSlider;
	
	public class DragSliderRunner extends Sprite {
		public function DragSliderRunner() {
			var drag:DragSlider = new DragSlider();
			this.addChild(drag);
		}
	}
}