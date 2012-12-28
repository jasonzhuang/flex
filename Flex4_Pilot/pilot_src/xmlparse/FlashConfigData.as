package xmlparse {
	/**
	 *	FlashConfigData is used for flash side
	 * 
	 */
	public class FlashConfigData {
		private var totalItems:int;
		private var itemsPerPage:int;
		private var template:Template;
		
		private var categoryRange:Object = {};
		private var detailRange:Object = {};
		
		//page start from 0
		private var currentPage:int = 0;
		
		//current page items
		private var showData:Array;
		
		//template category page amout 
		private const CATEGORY_SLOT:int = 4;
		
		//template detail page amout. For vertical, it has 8 items, for horizontal, it has 6 items
		private const DETAIL_AMOUT:Array = [8,6];
		
		public function FlashConfigData(value:Template) {
			this.template = value;
			totalItems = value.list.length;
			setItemsPerPage();
			changeRange();
		}
		
		private function getRangeType():Object {
			return template.type == Template.CATEGORY ? categoryRange : detailRange;
		}
		
		private function setItemsPerPage():void {
			switch (template.type) {
				case Template.VERTICAL:
					itemsPerPage = DETAIL_AMOUT[0];
					break;
				case Template.HORIZONTAL:
					itemsPerPage = DETAIL_AMOUT[1];
					break;
				case Template.CATEGORY:
					itemsPerPage = CATEGORY_SLOT;
					break;
				default:
					throw new Error("not supported template type: " + template.type);
			}
		}
				
		public function getCurrentItems():Array {
			var result:Array = [];
			
			var rangeObj:Object = getRangeType();
			
			for(var start:int = rangeObj["start"]; start<=rangeObj["end"]; start++) {
				result.push(template.list[start]);
			}
			
			return result;
		}
		
		private function changeRange():void {
			var range:Object = getRangeType();
			
			range["start"] = currentPage*itemsPerPage;
			range["end"] = (range["start"] + itemsPerPage) >= totalItems ? (totalItems -1) : (range["start"] + itemsPerPage -1);
		}
		
		public function next():Array {
			var rangeObj:Object = getRangeType();
			
			if(rangeObj["end"] >= totalItems-1) {
				return getCurrentItems();
			}
			
			currentPage = currentPage + 1;
			
			changeRange();
			
			return getCurrentItems();
		}
		
		public function previous():Array {
			var rangeObj:Object = getRangeType();
			
			if(rangeObj["start"] == 0) {
				return getCurrentItems();
			}
			
			currentPage = currentPage - 1;
			
			changeRange();
			
			return getCurrentItems();
		}
	}
}