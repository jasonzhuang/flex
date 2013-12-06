/**
 * @author Michael Ritchie
 * @blog http://www.thanksmister.com
 * @twitter Thanksmister
 * Copyright (c) 2010
 * 
 * This is a Flash application to test the TouchList component.
 * */
package
{
	import com.thanksmister.touchlist.controls.TouchList;
	import com.thanksmister.touchlist.events.ListItemEvent;
	import com.thanksmister.touchlist.renderers.TouchListItemRenderer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class AS3ScrollingList extends Sprite
	{
		private var touchList:TouchList;
		private var textOutput:TextField;
		
		public function AS3ScrollingList()
		{
			// needed to scale our screen
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			if(stage) 
				init();
			else
				stage.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			stage.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(Event.RESIZE, handleResize);
			
			// add our list and listener
			touchList = new TouchList(stage.stageWidth, stage.stageHeight);
			touchList.addEventListener(ListItemEvent.ITEM_SELECTED, handlelistItemSelected);
			addChild(touchList);
			
			// Fill our list with item rendreres that extend ITouchListRenderer. 
			for(var i:int = 0; i < 50; i++) {
				var item:TouchListItemRenderer = new TouchListItemRenderer();
					item.index = i;
					item.data = "This is list item " + String(i);
					item.itemHeight = 80;
			
				touchList.addListItem(item);
			}
		}
		
		
		private function handleResize(e:Event = null):void
		{
			touchList.resize(stage.stageWidth, stage.stageHeight);
		}
		
		/**
		 * Handle keyboard events for menu, back, and seach buttons.
		 * */
		private function handleKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK) {
				e.preventDefault();
				//NativeApplication.nativeApplication.exit();
			} else if(e.keyCode == Keyboard.MENU){
				e.preventDefault();
			} else if(e.keyCode == Keyboard.SEARCH){
				e.preventDefault();
			}
		}
		
		/**
		 * Handle list item seleced.
		 * */
		private function handlelistItemSelected(e:ListItemEvent):void
		{
			trace("List item selected: " + e.renderer.index);
		}
	}
}