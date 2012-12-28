package com.netease {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.filters.BlurFilter;
	import flash.text.*;
	import flash.geom.Point;
	
	public class CategoryLabel extends MovieClip {
		private var categoryText:TextField;
		private var categoryTextShadow:TextField;
		
		public function CategoryLabel() {
			categoryTextShadow = new TextField();
			categoryText = new TextField();
			setProperties(categoryTextShadow);
			setProperties(categoryText);
			categoryTextShadow.textColor = 0xA38650;
			categoryText.textColor = 0xffffff;
			setShadow(categoryTextShadow);
			setPosition(-5,0);
			this.addChild(categoryTextShadow);
			this.addChild(categoryText);
		}
		
		public function set categoryName(value:String):void {
			categoryText.text = value ? value: "";
			categoryTextShadow.text = value ? value: "";
		}
		
		private function setProperties(value:TextField):void {
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 18;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "Microsoft YaHei";//微软雅黑
			value.defaultTextFormat = myFormat;
			value.autoSize = TextFieldAutoSize.CENTER;
			value.wordWrap = true;
		}
		
		private function setShadow(value:TextField):void {
			var myFilters:Array = value.filters;
			var blurFilter:BlurFilter = new BlurFilter();
			myFilters.push(blurFilter);
			value.filters = myFilters;
		}
		
		public function setPosition(valueX:int, valueY:int):void {
			categoryText.x = categoryTextShadow.x = valueX;
			categoryText.y = categoryTextShadow.y = valueY;
		}
		
	}
	
}
