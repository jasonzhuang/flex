package com.netease {
	
	import flash.display.MovieClip;
	import fl.containers.UILoader;
	
	
	public class CustomerUILoader extends MovieClip {
		protected var uiloader:UILoader;
		private var _templateId:String;
		private var _index:String;
		
		private var _template:Template;
		
		public function CustomerUILoader() {
		}
		
		public function set template(value:Template):void {
			this._template = value;
		}
		
		public function get template():Template {
			return this._template;
		}
		
		public function setImage(value:Object):void {
			uiloader.source = value;
		}
		
		public function set templateId(value:String):void {
			this._templateId = value;
		}
		
		public function get templateId():String {
			return this._templateId;
		}
		
		public function set index(value:String):void {
			this._index = value;
		}
		
		public function get index():String {
			return this._index;
		}
	}
	
}
