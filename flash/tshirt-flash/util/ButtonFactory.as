package util {
	import components.CustomerButton;
	
	import flash.display.DisplayObject;

	/**
	 *	ButtonFactory
	 */
	public class ButtonFactory {
		private static var colorTags:Array = ["01", "02", "03", "04", "05", "06", "07", "08", "09"];
		private static var components:Array = [
																	[ONE, ONE_HOVER],
																    [TWO, TWO_HOVER],
																	[THREE, THREE_HOVER],
																	[FOUR, FOUR_HOVER],
																	[FIVE, FIVE_HOVER],
																	[SIX, SIX_HOVER],
																	[SEVEN, SEVEN_HOVER],
																	[EIGHT, EIGHT_HOVER],
																	[NINE, NINE_HOVER]
															    ];

		public static function createButtonList():Array {
			var result :Array = [];
			for(var index:int=0; index< colorTags.length; index++) {
				result.push(createButton(colorTags[index], components[index]));
			}
			
			return result;
		}
		
		private static function createButton(tag:String, compoPair:Array) :CustomerButton {
			return new CustomerButton(new compoPair[0], new compoPair[1], tag);
		}
	}
}