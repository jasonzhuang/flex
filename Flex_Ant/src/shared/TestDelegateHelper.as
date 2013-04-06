package shared
{
	public class TestDelegateHelper {
        public static function registerTestDelegate(testDelegateClass:Class,
                realDelegateClass:Class):void
        {
            ResponderHelper.registerTestDelegate(testDelegateClass, realDelegateClass);
        }
	}
}