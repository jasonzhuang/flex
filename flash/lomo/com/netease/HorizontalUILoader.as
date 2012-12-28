package com.netease {
	
	import flash.display.MovieClip;
	import fl.containers.UILoader;
	
	public class HorizontalUILoader extends CustomerUILoader {
		public function HorizontalUILoader() {
			uiloader = new UILoader();
			uiloader.buttonMode = uiloader.useHandCursor = true;
			uiloader.width = 132;
			uiloader.height = 102;
			this.addChild(uiloader);
		}
	}
	
}
