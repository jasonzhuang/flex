package flashConfigTest {
	import org.flexunit.Assert;
	
	import xmlparse.FlashConfigData;
	import xmlparse.Template;
	
	/**
	 *	FlashConfiDataTest
	 */
	public class FlashConfiDataTest {
		
		private var template:Template;
		private var flashConfigData:FlashConfigData;
		
		[Before]
		public function setUp():void {
			template = new Template();
			template.templateId = "51520";
			template.type = Template.HORIZONTAL;
			for(var i:int=1; i<11; i++) {
				var item:Object = {};
				item.index = i+10;
				item.url = "http://mock/" + i;
				template.list.push(item);
			}
			
			flashConfigData = new FlashConfigData(template);
		}
		
		[After]
		public function tearDown():void {
			template = null;
		}

		[Test]
		public function testNext():void {
			var currentItems:Array = flashConfigData.getCurrentItems();
			var firstItem:Object = currentItems[0];
			Assert.assertEquals(6, currentItems.length);
			Assert.assertEquals("http://mock/1", firstItem["url"]);
			flashConfigData.next();
			flashConfigData.next();
			flashConfigData.next();
			currentItems = flashConfigData.getCurrentItems();
			var lastItem:Object = currentItems[currentItems.length-1];
			Assert.assertEquals(4, currentItems.length);
			Assert.assertEquals("http://mock/10", lastItem["url"]);
		}
		
		[Test]
		public function testPrevious():void {
			var currentItems:Array = flashConfigData.getCurrentItems();
			var firstItem:Object = currentItems[0];
			Assert.assertEquals("http://mock/1", firstItem["url"]);
			flashConfigData.previous();
			flashConfigData.previous();
			currentItems = flashConfigData.getCurrentItems();
			Assert.assertEquals(6, currentItems.length);
			Assert.assertEquals("http://mock/2", currentItems[1]["url"]);
		}
	}
}