package imageCompare {
	import flash.display.Loader;
	
	/**
	 *	OrderLoader
	 */
	public class OrderLoader extends Loader {
		public var index:int;
		
		public function OrderLoader(index:int)
		{
			super();
			this.index = index;
		}
	}
}