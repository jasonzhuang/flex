package com.netease {
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import com.netease.DataNotifyEvent;
	import com.netease.ConfigData;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	/*
	* Note:
	* 1.specific object exists when it add to stage
	* as the test show, in 70 frame, templateDetails.detailOne
	* already exists, but templateDetails.detailThree not exists
	* 2.gotoAndPlay() only effects on the main frame line, so show bubbles the event
	* 3.addFrameScript(), in the same frame, only excute the last function
	* 4.once the instance has added to the stage, next time reback to the specific frame, the instance will still exist
	*/
	

	public class TemplateMain extends MovieClip {
		private static const CONFIG_URL:String = "http://st2.yxp.126.net/flash2/images/qqlomo/flash/config.xml";
		private var configData:ConfigData;
		
		private var categoryConfigData:FlashConfigData;
		public var currentTempalteConfigData:FlashConfigData;
		private var recommendTemplateData:Template;
		public var currentTemplate:Template;
		
		public function TemplateMain() {
			EventLocator.getInstance().addEventListener(DataNotifyEvent.CONFIG_LOADED, xmlParseComplete);
			loadConfigFile();
			this.addEventListener(CategoryChangeEvent.CATEGORY_CHANGE, gotoTemplateDetail);
			this.addEventListener(NavigateToFlexEvent.NAV_TO_FLEX, gotoFlex);
			
			this.addFrameScript(30, setTemplateCategory);
			this.addFrameScript(40, setRecommandTemplates);
			this.addFrameScript(43, navCategoryListener);
			this.addFrameScript(66, setCategorySnapshot);
			this.addFrameScript(113, setCategorySnapshot);
			this.addFrameScript(91, btnListener);
			this.addFrameScript(129, btnListener);
		}
		
		private function gotoFlex(event:NavigateToFlexEvent):void {
			trace("template id: " + event.templateId + " index: "+  event.index + " from: " + event.from);
			var result:String = event.templateId + "&"+ event.index + "&from=" + event.from;
			this.dispatchEvent(new DataEvent("templateChoose", true, false, result));
			backToMainPage(null);
		}
		
		private function loadConfigFile():void {
			var configService:URLService = new URLService(CONFIG_URL);
			configService.addEventListener(DataEvent.DATA, onConfigReceived);
			configService.addEventListener(IOErrorEvent.IO_ERROR, onFeedError);
			configService.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFeedError);
			configService.send();
		}
		
		private function onConfigReceived(event:DataEvent):void
		{
			var result:XML = new XML(event.data);
			ConfigManager.parseXML(result);
		}
			
		private function onFeedError(event:ErrorEvent):void
		{
			trace(event.text);
		}
		
		private function xmlParseComplete(event:DataNotifyEvent):void {
			configData = ConfigData(event.data);
			trace("templates length: " + configData.choosableTemplates.length);
			recommendTemplateData = configData.recommendTemplate;
			var templateCategoryData:Template = configData.templateCategory;
			categoryConfigData = new FlashConfigData(templateCategoryData);
		}
		
		private function gotoTemplateDetail(event:CategoryChangeEvent):void {
			currentTemplate = event.template;
			currentTempalteConfigData = new FlashConfigData(currentTemplate);
			if(currentTemplate.type == Template.HORIZONTAL) {
				gotoAndPlay("100");
			} else if(currentTemplate.type == Template.VERTICAL) {
				gotoAndPlay("45");
			}
		}

		private function backToMainPage(event:MouseEvent):void {
			gotoAndPlay("40");
			//should set again
			setTemplateCategory();
			setRecommandTemplates();
		}
		
		private function setRecommandTemplates():void {
			recommandTemplates.setRecommendThumbs(recommendTemplateData);
		}
		
		private function setTemplateCategory():void {
			templateCategory.setTemplateCategory(categoryConfigData);
		}

		private function scrollNextCategory(event:MouseEvent):void {
			categoryConfigData.next();
			setCategoryBtnState();
			setTemplateCategory();
		}
		
		private function scrollPrevCategory(event:MouseEvent):void {
			categoryConfigData.previous();
			setCategoryBtnState();
			setTemplateCategory();
		}
		
		private function scrollPrevDetail(event:MouseEvent):void {
			if(currentTemplate.type == Template.HORIZONTAL) {
				hTemplateDetails.previous();
				setDetailBtnState();
			} else if(currentTemplate.type == Template.VERTICAL) {
				vTemplateDetails.previous();
				setDetailBtnState();
			}
		}
		
		private function scrollNextDetail(event:MouseEvent):void {
			if(currentTemplate.type == Template.HORIZONTAL) {
				hTemplateDetails.next();
				setDetailBtnState();
			} else if(currentTemplate.type == Template.VERTICAL) {
				vTemplateDetails.next();
				setDetailBtnState();
			}
		}
		
		private function setCategorySnapshot():void {
			if(currentTemplate.type == Template.HORIZONTAL) {
				hsnapshot.setImage(currentTemplate["previewImg"]);
			}else if(currentTemplate.type == Template.VERTICAL) {
				vsnapshot.setImage(currentTemplate["previewImg"]);
			}
		}
		
		private function navCategoryListener():void {
			stop();
			setCategoryBtnState();
			categoryPrevBtn.addEventListener(MouseEvent.CLICK, scrollPrevCategory);
			categoryNextBtn.addEventListener(MouseEvent.CLICK, scrollNextCategory);
		}
		
		private function setCategoryBtnState():void {
			if(categoryConfigData.hasPrevious()){
				categoryPrevBtn.enabled = true;
				categoryPrevBtn.alpha = 1.0;
				categoryPrevBtn.mouseEnabled = true;
			} else {
				categoryPrevBtn.enabled = false;
				categoryPrevBtn.alpha = 0.3;
				categoryPrevBtn.mouseEnabled = false;
			}
			
			if(categoryConfigData.hasNext()) {
				categoryNextBtn.enabled = true;
				categoryNextBtn.alpha = 1.0;
				categoryNextBtn.mouseEnabled = true;
			} else {
				categoryNextBtn.enabled = false;
				categoryNextBtn.alpha = 0.3;
				categoryNextBtn.mouseEnabled = false;
			}
		}
		
		private function setDetailBtnState():void {
			if(currentTempalteConfigData.hasPrevious()) {
				detailPrevBtn.enabled = true;
				detailPrevBtn.alpha = 1.0;
				detailPrevBtn.mouseEnabled = true;
			} else {
				detailPrevBtn.enabled = false;
				detailPrevBtn.alpha = 0.3;
				detailPrevBtn.mouseEnabled = false;
			}
			
			if(currentTempalteConfigData.hasNext()) {
				detailNextBtn.enabled = true;
				detailNextBtn.alpha = 1.0;
				detailNextBtn.mouseEnabled = true;
			} else {
				detailNextBtn.enabled = false;
				detailNextBtn.alpha = 0.3;
				detailNextBtn.mouseEnabled = false;
			}
		}
		
		private function btnListener():void {
			stop();
			setDetailBtnState();
			detailPrevBtn.addEventListener(MouseEvent.CLICK, scrollPrevDetail);
			detailNextBtn.addEventListener(MouseEvent.CLICK, scrollNextDetail);
			closeDetailBtn.addEventListener(MouseEvent.CLICK, backToMainPage);
		}
	}
	
}
