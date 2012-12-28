package com.netease{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class RecommendTempalates extends MovieClip {
		private var recommendTemplate:Template;
		
		public function RecommendTempalates() {
			recommend1.addEventListener(MouseEvent.CLICK, navigateToFlex);
			recommend1.addEventListener(MouseEvent.MOUSE_OVER, scaleTemplate);
			recommend1.addEventListener(MouseEvent.MOUSE_OUT, scaleTemplate);
			recommend2.addEventListener(MouseEvent.CLICK, navigateToFlex);
			recommend2.addEventListener(MouseEvent.MOUSE_OVER, scaleTemplate);
			recommend2.addEventListener(MouseEvent.MOUSE_OUT, scaleTemplate);
			recommend3.addEventListener(MouseEvent.CLICK, navigateToFlex);
			recommend3.addEventListener(MouseEvent.MOUSE_OVER, scaleTemplate);
			recommend3.addEventListener(MouseEvent.MOUSE_OUT, scaleTemplate);
			recommend4.addEventListener(MouseEvent.CLICK, navigateToFlex);
			recommend4.addEventListener(MouseEvent.MOUSE_OVER, scaleTemplate);
			recommend4.addEventListener(MouseEvent.MOUSE_OUT, scaleTemplate);
		}
		
		public function setRecommendThumbs(template:Template):void {
			recommendTemplate = template;
			var result:Array = template.list;
			
			recommend1.setImage(result[0]["url"]);
			recommend1.index = result[0]["index"];
			
			recommend2.setImage(result[1]["url"]);
			recommend2.index = result[1]["index"];

			recommend3.setImage(result[2]["url"]);
			recommend3.index = result[2]["index"];
		
			recommend4.setImage(result[3]["url"]);
			recommend4.index = result[3]["index"];
		}
		
		private function scaleTemplate(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			if(event.type == MouseEvent.MOUSE_OVER) {
				uiloader.scaleX *= 1.05;
				uiloader.scaleY *= 1.05;
			} else if(event.type == MouseEvent.MOUSE_OUT) {
				uiloader.scaleX /= 1.05;
				uiloader.scaleY /= 1.05;
			}
		}
		
		
		private function navigateToFlex(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			this.dispatchEvent(new NavigateToFlexEvent(recommendTemplate.templateId, uiloader.index, recommendTemplate.type));
		}
	}
	
}
