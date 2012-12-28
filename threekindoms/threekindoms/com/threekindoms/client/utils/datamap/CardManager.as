package com.threekindoms.client.utils.datamap
{
    import com.threekindoms.client.vo.Card;
    import com.threekindoms.client.vo.Coordinate;
    
    import flash.utils.Dictionary;

    public class CardManager
    {
        private var identifierLocationMap:Dictionary = new Dictionary(true);

        public function buildMap(cardEntry:XML):void
        {
            var cardlist:XMLList = cardEntry.children();
            var coordinate:Coordinate;
            var records:Array = [];
            var type:String = cardEntry.@name;
            for each (var card:XML in cardlist)
            {
                coordinate = new Coordinate();
                coordinate.identifierX = card.@identifierX;
                coordinate.identifierY = card.@identifierY;
                coordinate.locationX = card.@locationX;
                coordinate.locationY = card.@locationY;
                records.push(coordinate);
            }
            identifierLocationMap[type] = records;
        }

        public function getIdentifierFromLocation(location:Coordinate):Coordinate
        {
            for each (var records:Array in identifierLocationMap)
            {
                for each (var coordinate:Coordinate in records)
                {
                    if (location.locationEquals(coordinate))
                    {
                        return coordinate;
                    }
                }
            }
            return null;
        }

        public function getLocationFromIdentifier(identifier:Coordinate):Coordinate
        {
            for each (var records:Array in identifierLocationMap)
            {
                for each (var coordinate:Coordinate in records)
                {
                    if (identifier.identifierEquals(coordinate))
                    {
                        return coordinate;
                    }
                }
            }
            return null;
        }

    }
}
