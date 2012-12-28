package shared
{
	import flash.utils.Dictionary;

	public class FrontControllerHelper {
        private static var controllerPool:Dictionary = new Dictionary();

        public static function registerFrontController(controllerClass:Class):Boolean {
            if (controllerPool[controllerClass] != null) {
                return false;
            }

            controllerPool[controllerClass] = new controllerClass();

            return true;
        }
    }
}