package util {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	/**
	 *	TshirtFactory
	 * NOTE:Embed files will increase the swf file size
	 */
	public class TshirtFactory {
		[Embed(source="/assets/01.jpg")]
		private static const ONE:Class;
		
		[Embed(source="/assets/02.jpg")]
		private static const TWO:Class;
		
		[Embed(source="/assets/03.jpg")]
		private static const THREE:Class;
		
		[Embed(source="/assets/04.jpg")]
		private static const FOUR:Class;
		
		[Embed(source="/assets/05.jpg")]
		private static const FIVE:Class;
		
		[Embed(source="/assets/06.jpg")]
		private static const SIX:Class;
		
		[Embed(source="/assets/07.jpg")]
		private static const SEVEN:Class;
		
		[Embed(source="/assets/08.jpg")]
		private static const EIGHT:Class;
		
		[Embed(source="/assets/09.jpg")]
		private static const NINE:Class;
		
		private static var tshirtList:Array = [
			{"01": ONE},
			{"02": TWO},
			{"03": THREE},
			{"04": FOUR},
			{"05": FIVE},
			{"06": SIX},
			{"07": SEVEN},
			{"08": EIGHT},
			{"09": NINE}
		]

		public static function getDefaultTshirt():Bitmap {
			return new ONE();
		}
		
		public static function getTshirt(color:String):Bitmap {
			for each(var obj:Object in tshirtList) {
				if(color in obj) {
					return new obj[color]();
				}
			}
			return null;
		}
	}
}