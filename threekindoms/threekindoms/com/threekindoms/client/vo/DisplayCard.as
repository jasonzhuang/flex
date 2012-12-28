package com.threekindoms.client.vo
{
    import flash.events.IEventDispatcher;

    /**
    *  Card must be Bindable, otherwise compile error, says not implements method of IEventDispatcher
    */
    [Bindable]
    public class DisplayCard extends Card implements IEventDispatcher
    {
        public var originalCoordinate:Coordinate;
        public var destCoordinate:Coordinate;
    }
}