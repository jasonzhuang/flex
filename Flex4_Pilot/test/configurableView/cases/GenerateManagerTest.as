package configurableView.cases
{
	import configurableView.views.MockFrameGroup;
	import configurableView.views.MockPhotoChoose;
	
	import org.flexunit.Assert;
	
	import utils.ConfigManager;
	import views.NoteCard2;
	import views.MyNoteCard;
	
	public class GenerateManagerTest
	{
		private var viewXML:XML;
		
		[Before]
		public function setUp():void {
			viewXML = 
				<configuration>
					<widgetContainer id="container" type="spark.components.VGroup">
							<widget id="photo" type="configurableView.views.MockPhotoChoose"/>
							<widget id="frameGroup" type="configurableView.views.MockFrameGroup"/>
					</widgetContainer>
				</configuration>;
		}
		
		[After]
		public function tearDown():void {
			viewXML = null;
		}
		
		[Test]
		public function testGenerateBatchClass():void {
			var container:Object = ConfigManager.generateBatch(viewXML);
			Assert.assertEquals(2, container.numChildren);
			Assert.assertTrue(container.getChildAt(0) is MockPhotoChoose);
		    Assert.assertTrue(container.getChildAt(1) is MockFrameGroup);
		}
		
		[Test]
		public function testGenerateSingleClass():void {
			var klass:Object = ConfigManager.generateSingle("views.MyNoteCard");
			Assert.assertTrue(klass is MyNoteCard);
		}
		
		[Test]
		public function testGenerateFail():void {
			try{
				var klass:Object = ConfigManager.generateSingle("voxx.Person");
				Assert.fail("should generate fail");
			} catch(e:Error) {
				Assert.assertEquals("constructor class error", e.message);
			}
		}
	}
}