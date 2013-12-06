package components.treeList
{
    import flash.events.Event;
    import mx.events.FlexEvent;
    import spark.components.List;
    import spark.events.IndexChangeEvent;
        
    [Event(name="change", type="components.treeList.SparkMenuEvent")]
    
    public class SparkMenuBar extends List
    {
        override public function dispatchEvent(event:Event):Boolean
        {
            if (event.type == IndexChangeEvent.CHANGE && event is IndexChangeEvent && !(event is SparkMenuEvent))
            {
                // don't dispatch change events directly from the MenuBar, only forward SparkMenuEvents from the
                // menus.
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));                
                return true;          
            }
            return super.dispatchEvent(event);
        }
    }
}
