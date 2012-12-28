package com.threekindoms.client.utils
{
	import com.threekindoms.client.vo.Coordinate;
	
	public class CoordinateFactory
	{
		public static function constrcutFromIdentifier(identifierX:int, identifierY:int):Coordinate {
			var coordinate:Coordinate = new Coordinate();
			coordinate.identifierX = identifierX;
			coordinate.identifierY = identifierY;
			return coordinate;
		}

        public static function constructFromLocation(locationX:int, locationY:int):Coordinate {
        	var coordinate:Coordinate = new Coordinate();
        	coordinate.locationX = locationX;
        	coordinate.locationY = locationY;
        	return coordinate;
        }
	}
}