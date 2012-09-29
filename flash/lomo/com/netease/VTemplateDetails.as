package com.netease {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
		
	public class VTemplateDetails extends TemplateDetails {
		public function VTemplateDetails() {
			super();
			this.addFrameScript(1, setDetailLabel);
			this.addFrameScript(3, setDetails1);
			this.addFrameScript(6, setDetails2);
			this.addFrameScript(9, setDetails3);
			this.addFrameScript(12, setDetails4);
			this.addFrameScript(15, setDetails5);
			this.addFrameScript(18, setDetails6);
			this.addFrameScript(21, setDetails7);
			this.addFrameScript(24, setDetails8);
		}

		public function setDetailLabel():void {
			detailLabel.categoryName = selectedTemplate.categoryName;
		}
		
		public function clearDetails():void {
			detail1.setImage(null);
			detail1.index = null;
			detail2.setImage(null);
			detail2.index = null;
			detail3.setImage(null);
			detail3.index = null;
			detail4.setImage(null);
			detail4.index = null;
			detail5.setImage(null);
			detail5.index = null;
			detail6.setImage(null);
			detail6.index = null;
			detail7.setImage(null);
			detail7.index = null;
			detail8.setImage(null);
			detail8.index = null;
		}
		
		override public function setDetails():void {
			clearDetails();
			setDetails1();
			setDetails2();
			setDetails3();
			setDetails4();
			setDetails5();
			setDetails6();
			setDetails7();
			setDetails8();
		}
		
		private function setDetails1():void {
			if(itemList[0]) {
				detail1.addEventListener(MouseEvent.CLICK, forward);
				detail1.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail1.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail1.setImage(itemList[0]["url"]);
				detail1.index = itemList[0]["index"];
			}
		}
		
		private function setDetails2():void {
			if(itemList[1]) {
				detail2.addEventListener(MouseEvent.CLICK, forward);
				detail2.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail2.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail2.setImage(itemList[1]["url"]);
				detail2.index = itemList[1]["index"];
			}
		}
		
		private function setDetails3():void {
			if(itemList[2]) {
				detail3.addEventListener(MouseEvent.CLICK, forward);
				detail3.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail3.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail3.setImage(itemList[2]["url"]);
				detail3.index = itemList[2]["index"];
			}
		}
		
		private function setDetails4():void {
			if(itemList[3]) {
				detail4.addEventListener(MouseEvent.CLICK, forward);
				detail4.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail4.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail4.setImage(itemList[3]["url"]);
				detail4.index = itemList[3]["index"];
			}
		}
		
		private function setDetails5():void {
			if(itemList[4]) {
				detail5.addEventListener(MouseEvent.CLICK, forward);
				detail5.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail5.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail5.setImage(itemList[4]["url"]);
				detail5.index = itemList[4]["index"];
			}
		}
		
		private function setDetails6():void {
			if(itemList[5]) {
				detail6.addEventListener(MouseEvent.CLICK, forward);
				detail6.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail6.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail6.setImage(itemList[5]["url"]);
				detail6.index = itemList[5]["index"];
			}
		}
		
		private function setDetails7():void {
			if(itemList[6]) {
				detail7.addEventListener(MouseEvent.CLICK, forward);
				detail7.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail7.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail7.setImage(itemList[6]["url"]);
				detail7.index = itemList[6]["index"];
			}
		}
		
		/**
		* MUST stop the frame
		*/
		private function setDetails8():void {
			if(itemList[7]) {
				detail8.addEventListener(MouseEvent.CLICK, forward);
				detail8.addEventListener(MouseEvent.MOUSE_OVER, scaleDetail);
				detail8.addEventListener(MouseEvent.MOUSE_OUT, scaleDetail);
				detail8.setImage(itemList[7]["url"]);
				detail8.index = itemList[7]["index"];
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
