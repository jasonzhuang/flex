package util {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.display.Sprite;
	/**
	 *	TshirtFactory
	 * NOTE:Embed files will increase the swf file
	 */
	public class TshirtFactory {
		private static var tshirtList:Array = [
			{"01": T_ONE},
			{"02": T_TWO},
			{"03": T_THREE},
			{"04": T_FOUR},
			{"05": T_FIVE},
			{"06": T_SIX},
			{"07": T_SEVEN},
			{"08": T_EIGHT},
			{"09": T_NINE}
		]

		public static function getDefaultTshirt():Sprite {
			return new T_ONE();
		}
		
		public static function getTshirt(color:String):Sprite {
			for each(var obj:Object in tshirtList) {
				if(color in obj) {
					return new obj[color]();
				}
			}
			return null;
		}
	}
}