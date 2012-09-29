package vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Model
	{
		private static var _instance:Model;
		
		public static function getInstance():Model {
			if(!_instance) {
				_instance = new Model();
			}
			return _instance;
		}
		
		public var dataPool:ArrayCollection;
	}
}