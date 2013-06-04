package utils
{
	import components.MyNoteCard;
	
	public class RegisterManager extends ConfigManager
	{
		private static var registerPool:Array;
		
		private static var instance:RegisterManager;
		
		/**
		 * Note:
		 * ReferenceError: Error #1065: Variable XXX is not defined.
		 * reason: the class is not compiled with the application because the linker and the compiler do not
		 * add classes that are not referenced in the code.
		 * SOLUTUION: add the class somewhere before invoke getDefinitionByName.
		 */
		{
			registerPool = [
								MyNoteCard,
							];
		}
		
		public function RegisterManager() {
			if(instance != null) {
				throw new Error("Singleton Error");
			}
			instance = this;
		}
		
		public static function getIntance():RegisterManager {
			if(!instance) {
				instance = new RegisterManager();
			}
			return instance;
		}
	}
}