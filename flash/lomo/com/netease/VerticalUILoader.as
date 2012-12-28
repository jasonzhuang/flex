package com.netease {
	
	import flash.display.MovieClip;
	import fl.containers.UILoader;
	
	
	public class VerticalUILoader extends CustomerUILoader {
		public function VerticalUILoader() {
			uiloader = new UILoader();
			uiloader.buttonMode = uiloader.useHandCursor = true;
			uiloader.width = 112;
			uiloader.height = 170;
			this.addChild(uiloader);
		}
	}
	
}
