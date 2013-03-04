package util {
	import components.CustomerButton;
	
	import flash.display.DisplayObject;

	/**
	 *	ButtonFactory
	 */
	public class ButtonFactory {
		[Embed(source="/assets/color-01a.jpg")]
		private static const ONE:Class;
		
		[Embed(source="/assets/color-01b.jpg")]
		private static const ONE_HOVER:Class;

		[Embed(source="/assets/color-02a.jpg")]
		private static const TWO:Class;
		
		[Embed(source="/assets/color-02b.jpg")]
		private static const TWO_HOVER:Class;
		
		[Embed(source="/assets/color-03a.jpg")]
		private static const THREE:Class;
		
		[Embed(source="/assets/color-03b.jpg")]
		private static const THREE_HOVER:Class;
		
		[Embed(source="/assets/color-04a.jpg")]
		private static const FOUR:Class;
		
		[Embed(source="/assets/color-04b.jpg")]
		private static const FOUR_HOVER:Class;
		
		[Embed(source="/assets/color-05a.jpg")]
		private static const FIVE:Class;
		
		[Embed(source="/assets/color-05b.jpg")]
		private static const FIVE_HOVER:Class;
		
		[Embed(source="/assets/color-06a.jpg")]
		private static const SIX:Class;
		
		[Embed(source="/assets/color-06b.jpg")]
		private static const SIX_HOVER:Class;
		
		[Embed(source="/assets/color-07a.jpg")]
		private static const SEVEN:Class;
		
		[Embed(source="/assets/color-07b.jpg")]
		private static const SEVEN_HOVER:Class;

		[Embed(source="/assets/color-08a.jpg")]
		private static const EIGHT:Class;
		
		[Embed(source="/assets/color-08b.jpg")]
		private static const EIGHT_HOVER:Class;
		
		[Embed(source="/assets/color-09a.jpg")]
		private static const NINE:Class;
		
		[Embed(source="/assets/color-09b.jpg")]
		private static const NINE_HOVER:Class;
		
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