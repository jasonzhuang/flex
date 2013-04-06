
package view {

    import utils.Enum;

    /**
    * Enumeration of result types when application verify whether application can enter into or exit
    * from a page.
    */
    public class ToggleConfirmResult extends Enum {

        /**
        * The state is still pending, and application should check the result later.
        */
        public static const WAIT:ToggleConfirmResult = new ToggleConfirmResult("WAIT");

        /**
        * The page is ready, and application can process the next step.
        */
        public static const SUCCESSED:ToggleConfirmResult = new ToggleConfirmResult("SUCCESSED");

        /**
        * The page can't be ready, and application should go back.
        */
        public static const FAILED:ToggleConfirmResult = new ToggleConfirmResult("FAILED");

        /**
        * Constructor, and must not be called.
        */
        public function ToggleConfirmResult(id:String) {
            super(id);
        }
    }
}