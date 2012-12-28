package control {
    import com.adobe.cairngorm.control.FrontController;

    import events.RetrieveListEvent;
    import command.RetrieveListCommand;

    public class WrapperController extends FrontController {
        public function WrapperController() {
            super();
            addCommands();
        }

        private function addCommands():void {
            this.addCommand(RetrieveListEvent.RETRIEVE_LIST, RetrieveListCommand);
        }
    }
}