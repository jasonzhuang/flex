package components {
	import events.DataNotifyEvent;
	import events.EventNames;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 *	CustomerButton
	 */
	public class CustomerButton extends Sprite {
		private var normalSkin:DisplayObject;
		private var hoverSkin:DisplayObject;
		private var state:String;
		private var tag:String;
		private static const NORAML:String = "normal";
		private static const HOVER:String = "hover";
		
		
		public function CustomerButton(normalSkin:DisplayObject, hoverSkin:DisplayObject, tag:String = "")
		{
			this.normalSkin = normalSkin;
			this.hoverSkin = hoverSkin;
			this.tag = tag;
			addChild(normalSkin);
			addChild(hoverSkin);
			this.addEventListener(MouseEvent.MOUSE_OVER, toggle);
			this.addEventListener(MouseEvent.MOUSE_OUT, toggle);
			this.hoverSkin.visible = false;
			this.state = NORAML;
			this.useHandCursor = true;
		}
		
		private function toggle(event:MouseEvent):void {
			this.state == NORAML ? hoverState(): normalState();
			if(this.state == HOVER) {
				this.dispatchEvent(new DataNotifyEvent(EventNames.CHAHNGE_COLOR, this.tag, true));
			}
		}
		
		private function hoverState():void {
			this.state = HOVER;
			normalSkin.visible = false;
			hoverSkin.visible = true;
		}
		
		private function normalState():void {
			this.state = NORAML;
			normalSkin.visible = true;
			hoverSkin.visible = false;
		}
	}
}