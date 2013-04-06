

package view {

    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    /**
    * Page container manages several related pages in Flex application, and display one of them
    * at one time. And it will manage the toggling process from one page to another.
    */
    public interface IPageContainer extends IEventDispatcher {

        /**
        * The toggling process entrance.
        * 
        * @param page the page container will toggle to.
        * 
        * TODO whether this method is required?
        */
        function startToggle(page:IPage):void;

        /**
        * The page currently displayed
        */ 
        function get currentPage():IPage;

        /**
        * The toggling logic should be executed in page container by the end of process.
        * 
        * @param page the page should displayed
        * @param context context containing information shared during the toggling process
        * 
        * TODO look for a method name more meaningful.
        */
        function processToggle(page:IPage, context:Dictionary):void;
    }
}