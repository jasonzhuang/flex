
package view {

    import flash.utils.Dictionary;

    /**
    * A page is a UI component between which Flex application can toggle. And only one page can 
    * be displayed in the same time among a collection of related pages.
    * 
    * IPage defines a set of methods which can be used during toggling process.
    */
    public interface IPage {

        /**
        * When application tries to toggle from the current page to another, this method will be
        * called to make the current page prepared for the coming toggling process.
        * 
        * If true is returned, which means the current page is ready to be toggled out, its exit()
        * method will be called. Otherwise, application will try to call its confirmExit() method
        * later to check whether it can be toggled out.
        * 
        * @param context context containing information shared during the toggling process
        * 
        * @return whether the current page is ready to be togggle out.
        */
        function prepareExit(context:Dictionary):Boolean;

        /**
        * When it is OK for current page to be toggled out, this method will be called to let
        * current page process toggling out logic, such as hiding some components, saving current
        * state, and so on.
        * 
        * @param context object containing information shared during the toggling process.
        */
        function exit(context:Dictionary):void;

        /**
        * When current page's prepareExit says it is not ready for toggling out, this method will be
        * called for several times later to check whether it is OK to toggle the current page out.
        * When the process has not been completed, the method will return a waiting signal. If
        * everything is ready, it will return a successful signal, and otherwise a failed signal.
        * 
        * @param context object containing information shared during the toggling process.
        * 
        * @return confirming result indicating whether and how the toggling process can be executed.
        */
        function confirmExit(context:Dictionary):ToggleConfirmResult;

        /**
        * When application exits from the previous page successfully, it will call this method of
        * the current page to check whether it is ready for appliaction to enter it.
        * If the next page is not ready yet, application will call its confirmEnter() method to
        * check the state later. Otherwise application will call its enter() method.
        * 
        * @param context object containing information shared during the toggling process.
        * 
        * @return whether the application can enter the current page.
        */
        function prepareEnter(context:Dictionary):Boolean;

        /**
        * When it is OK for application to enter into the current page, this method will be called
        * to make it available for application to display.
        * 
        * @param context object containing information shared during the toggling process.
        */
        function enter(context:Dictionary):void;

        /**
        * When the page's prepareEnter method says it is not ready to be entered, this method will
        * be called for sever times to confirm whether it is OK now, or the appliaction still has to
        * wait.
        * 
        * @param context object containing information shared during the toggling process.
        * 
        * @return whether the application can enter now or have to wait.
        */
        function confirmEnter(context:Dictionary):ToggleConfirmResult;

        /**
        * When the application can't exit from the current page or enter into the next page,
        * appliaction will call this method on the current page to make application go back.
        * 
        * @param context object containing information shared during the toggling process.
        */
        function reenter(context:Dictionary):void;
    }
}