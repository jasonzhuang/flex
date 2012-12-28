package com.netease{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class TemplateCategory extends MovieClip {
		public function TemplateCategory(){
			template1.addEventListener(MouseEvent.CLICK, forward);
			template1.addEventListener(MouseEvent.MOUSE_OVER, scaleCategory);
			template1.addEventListener(MouseEvent.MOUSE_OUT, scaleCategory);
			template2.addEventListener(MouseEvent.CLICK, forward);
			template2.addEventListener(MouseEvent.MOUSE_OVER, scaleCategory);
			template2.addEventListener(MouseEvent.MOUSE_OUT, scaleCategory);
			template3.addEventListener(MouseEvent.CLICK, forward);
			template3.addEventListener(MouseEvent.MOUSE_OVER, scaleCategory);
			template3.addEventListener(MouseEvent.MOUSE_OUT, scaleCategory);
			template4.addEventListener(MouseEvent.CLICK, forward);
			template4.addEventListener(MouseEvent.MOUSE_OVER, scaleCategory);
			template4.addEventListener(MouseEvent.MOUSE_OUT, scaleCategory);
		}
		
		private function scaleCategory(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			if(event.type == MouseEvent.MOUSE_OVER) {
				uiloader.scaleX *= 1.05;
				uiloader.scaleY *= 1.05;
				uiloader.y -= 10;
			} else if(event.type == MouseEvent.MOUSE_OUT) {
				uiloader.scaleX /= 1.05;
				uiloader.scaleY /= 1.05;
				uiloader.y +=10;
			}

		}
		
		private function forward(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			if(!uiloader.template) {
				return;
			}
			this.dispatchEvent(new CategoryChangeEvent(uiloader.template));
		}
		
		public function setTemplateCategory(value:FlashConfigData):void {
			var templateList:Array = value.getCurrentItems();
			if(templateList[0]) {
				template1.setImage(templateList[0]["previewImg"]);
				template1.template = templateList[0];
				templateLabel1.categoryName = templateList[0]["categoryName"];
				templateLabel1.setPosition(-17,0);
			} else {
				template1.setImage(null);
				template1.template = null;
				templateLabel1.categoryName = null;
			}

			if(templateList[1]) {
				template2.setImage(templateList[1]["previewImg"]);
				template2.template = templateList[1];
				templateLabel2.categoryName = templateList[1]["categoryName"];
				templateLabel2.setPosition(-15,0);
			} else {
				template2.setImage(null);
				template2.template = null;
				templateLabel2.categoryName = null;
			}
			
			if(templateList[2]) {
				template3.setImage(templateList[2]["previewImg"]);
				template3.template = templateList[2];
				templateLabel3.categoryName = templateList[2]["categoryName"];
				templateLabel3.setPosition(-17,0);
			}else {
				template3.setImage(null);
				template3.template = null;
				templateLabel3.categoryName = null
			}
			
			if(templateList[3]) {	
				template4.setImage(templateList[3]["previewImg"]);
				template4.template = templateList[3];
				templateLabel4.categoryName = templateList[3]["categoryName"];
				templateLabel4.setPosition(-15,0);
			}else {
				template4.setImage(null);
				template4.template = null;
				templateLabel4.categoryName = null;
			}

		}
		

	}
	
}
