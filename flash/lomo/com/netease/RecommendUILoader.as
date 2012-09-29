package com.netease {
	
	import flash.display.MovieClip;
	import fl.containers.UILoader;
	
	public class RecommendUILoader extends CustomerUILoader {
		public function RecommendUILoader() {
			uiloader = new UILoader();
			uiloader.buttonMode = uiloader.useHandCursor = true;
			uiloader.width = 136;
			uiloader.height = 168;
			this.addChild(uiloader);
		}
	}
	
}
