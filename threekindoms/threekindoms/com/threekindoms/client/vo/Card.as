package com.threekindoms.client.vo
{
    import com.electrotank.electroserver5.api.EsObject;

    [Bindable]
    public class Card
    {
        public var cardId:int;
        public var x:int;
        public var y:int;
        public var dest_x:int;
        public var dest_y:int;
        public var cardType:int;
        public var cardArrtributes:Array;
    }
}