package {
	import components.CustomerButton;
	import components.MainPanel;
	
	import events.DataNotifyEvent;
	import events.EventNames;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	
	import util.ButtonFactory;
	
	/**
	 *	TshirtShow
	 */
	public class TshirtShow extends Sprite {
		private var mainPanel:MainPanel;
		private var colorList:Sprite;
		
		private static const EDGE:Number = 745;
		
		public function TshirtShow() {
			Security.allowDomain("*");
			init();
		}
		
		private function init():void {
			initStageMode();
			addListeners();
			createChildren();
		}
		
		private function addListeners():void {
			this.addEventListener(EventNames.CHAHNGE_COLOR, changeColor);
		}
		
		private function changeColor(event:DataNotifyEvent):void {
			var color:String = event.data as String;
			trace(color);
			mainPanel.changeTshirt(color);
		}
		
		private function initStageMode():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}

		private function createChildren():void {
			createButtons();
			createMain();
		}
		
		private function createMain():void {
			mainPanel = new MainPanel();
			addChild(mainPanel);
		}
		
		private function createButtons():void {
			colorList = new Sprite();
			var buttonList:Array = ButtonFactory.createButtonList();
			var button:CustomerButton = buttonList[0];
			var btnHeight:Number = button.height;
			var btnWidth:Number = button.width;
			for (var i:int=0; i<buttonList.length; i++) {
				button = buttonList[i];
				var x:Number = 0;
				var y:Number = btnHeight*i;
				button.x = x;
				button.y = y;
				trace("button y: ", y);
				colorList.addChild(button);
			}
			colorList.x = EDGE - btnWidth;
			colorList.y = 0;
			addChild(colorList);
		}
	}
}