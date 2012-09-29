package com.netease {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	* 1. get data from main: TemplateMain(parent).temp
	* 2. the frames begin from 1, not relative to main frameline
	*/

	public class TemplateDetails extends MovieClip {
		protected var configData:FlashConfigData;
		protected var itemList:Array;
		protected var selectedTemplate:Template;
		
		public function TemplateDetails() {
			super();
			selectedTemplate = TemplateMain(parent).currentTemplate;
			configData = TemplateMain(parent).currentTempalteConfigData;
			itemList = configData.getCurrentItems();
		}
		
		public function next():void {
			itemList = configData.next();
			setDetails();
		}
		
		public function previous():void {
			itemList = configData.previous();
			setDetails();
		}
		
		public function setDetails():void {
			//override by subclass
		}
		
		protected function scaleDetail(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			if(event.type == MouseEvent.MOUSE_OVER) {
				uiloader.scaleX *= 1.05;
				uiloader.scaleY *= 1.05;
			} else if(event.type == MouseEvent.MOUSE_OUT) {
				uiloader.scaleX /= 1.05;
				uiloader.scaleY /= 1.05;
			}

		}
		
	}
	
}
