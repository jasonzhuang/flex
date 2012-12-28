package com.threekindoms.client.vo {
    public class Coordinate
    {
        public var identifierX:int;
        public var identifierY:int;
        public var locationX:int;
        public var locationY:int;

        public function Coordinate(identifierX:int = -1, identifierY:int = -1) {
            this.identifierX = identifierX;
            this.identifierY = identifierY;
        }

        public function identifierEquals(other:Coordinate):Boolean
        {
            return this.identifierX == other.identifierX && this.identifierY == other.identifierY;
        }

        public function locationEquals(other:Coordinate):Boolean
        {
            return this.locationX == other.locationX && this.locationY == other.locationY;
        }

    }
}
