package components
{
    import mx.containers.HBox;

    public class MyContainer extends HBox
    {
        /**
        * 1.when no width assigned, unscaledWidth = width = measuredWidth
        * 2.when width or height is explictly assigned, unscaledWidth = width, measuredWidth value is calculated.
        * 3.when width is set by percent(width=60%), if the result is small than measuredWidth, unscaledWidth = width = measuredWidth
        * otherwise, unscaledWidth = width = parent width * percent, measuredWidth value is calculated.
        * 4.width(explicitWidth) will change when set self container scaleX, but unscaledWidth and measuredWidth will not change
        * 5.explicitWidth has value only when width is set, if width is set by percent or no width is set, the explicitWidth is NaN
        * 6.unscaledWidth = width / Math.abs(scaleX)
        */
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            trace("unscaledWidth is: " + unscaledWidth);
            super.updateDisplayList(unscaledWidth, unscaledHeight);
        }
        
        override protected function measure():void {
            super.measure();
        }
    }
}