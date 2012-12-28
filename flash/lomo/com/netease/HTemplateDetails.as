package com.netease {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class HTemplateDetails extends TemplateDetails {
		public function HTemplateDetails() {
			super();
			this.addFrameScript(1, setDetailLabel);
			this.addFrameScript(3, setDetails1);
			this.addFrameScript(6, setDetails2);
			this.addFrameScript(9, setDetails3);
			this.addFrameScript(12, setDetails4);
			this.addFrameScript(15, setDetails5);
			this.addFrameScript(18, setDetails6);
		}
		
		public function setDetailLabel():void {
			detailLabel.categoryName = selectedTemplate.categoryName;
		}
		
		public function clearDetails():void {
			hdetail1.setImage(null);
			hdetail1.index = null;
			hdetail2.setImage(null);
			hdetail2.index = null;
			hdetail3.setImage(null);
			hdetail3.index = null;
			hdetail4.setImage(null);
			hdetail4.index = null;
			hdetail5.setImage(null);
			hdetail5.index = null;
			hdetail6.setImage(null);
			hdetail6.index = null;
		}
		
		override public function setDetails():void {
			clearDetails();
			setDetails1();
			setDetails2();
			setDetails3();
			setDetails4();
			setDetails5();
			setDetails6();
		}
		
		private function setDetails1():void {
			if(itemList[0]) {
				hdetail1.addEventListener(MouseEvent.CLICK, forward);
				hdetail1.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail1.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail1.setImage(itemList[0]["url"]);
				hdetail1.index = itemList[0]["index"];
			}
		}
		
		private function setDetails2():void {
			if(itemList[1]) {
				hdetail2.addEventListener(MouseEvent.CLICK, forward);
				hdetail2.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail2.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail2.setImage(itemList[1]["url"]);
				hdetail2.index = itemList[1]["index"];
			}
		}
		
		private function setDetails3():void {
			if(itemList[2]) {
				hdetail3.addEventListener(MouseEvent.CLICK, forward);
				hdetail3.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail3.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail3.setImage(itemList[2]["url"]);
				hdetail3.index = itemList[2]["index"];
			}
		}
		
		private function setDetails4():void {
			if(itemList[3]) {
				hdetail4.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail4.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail4.addEventListener(MouseEvent.CLICK, forward);
				hdetail4.setImage(itemList[3]["url"]);
				hdetail4.index = itemList[3]["index"];
			}
		}
		
		private function setDetails5():void {
			if(itemList[4]) {
				hdetail5.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail5.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail5.addEventListener(MouseEvent.CLICK, forward);
				hdetail5.setImage(itemList[4]["url"]);
				hdetail5.index = itemList[4]["index"];
			}
		}
		
		private function setDetails6():void {
			if(itemList[5]) {
				hdetail6.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				hdetail6.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				hdetail6.addEventListener(MouseEvent.CLICK, forward);
				hdetail6.setImage(itemList[5]["url"]);
				hdetail6.index = itemList[5]["index"];
			}
			stop();
		}
		
		private function forward(event:MouseEvent):void {
			var uiloader:CustomerUILoader = event.currentTarget as CustomerUILoader;
			if(!uiloader.index) {
				return;
			}
			this.dispatchEvent(new NavigateToFlexEvent(selectedTemplate.templateId, uiloader.index));
		}
	}
	
}
