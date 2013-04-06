package cases {
    import flash.events.Event;

    import mx.controls.TextInput;
    import mx.events.FlexEvent;

    import org.flexunit.Assert;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    public class UIComponentTest {

        protected var textInput:TextInput;

        [Before(async,ui)]
        public function setUp():void {
            //Create a textInput, add it to the testEnvironment. Wait until it is created, then run tests on it
            textInput = new TextInput();
            Async.proceedOnEvent( this, textInput, FlexEvent.CREATION_COMPLETE, 1000);
            UIImpersonator.addChild( textInput );
        }

        [After(async,ui)]
        public function tearDown():void {
            UIImpersonator.removeChild( textInput );
            textInput = null;
        }

        [Test(async,ui)]
        public function testSetTextProperty() : void {

            var passThroughData:Object = new Object();
            passThroughData.propertyName = 'text';
            passThroughData.propertyValue = 'SSGA';

            textInput.addEventListener(FlexEvent.VALUE_COMMIT,
                    Async.asyncHandler(this, handleVerifyProperty, 10, passThroughData, handleEventNeverOccurred ),
                    false, 0, true );
            setProperty(textInput, passThroughData );
        }

        [Test(async,ui)]
        public function testSetEnabledTwiceProperty() : void {
            //A nice clear box test. The enabled property only emmits an event if it acutally changes.
            var passThroughData:Object = new Object();
            passThroughData.propertyName = 'enabled';
            passThroughData.propertyValue = true;

            //text default enabled is false
            textInput.addEventListener("enabledChanged",
                    Async.asyncHandler( this, handleUnexpectedEvent, 1000, passThroughData, handleExpectedTimeout ),
                    false, 0, true );
            setProperty(textInput, passThroughData );
        }

        protected function setProperty(target:Object, passThroughData:Object ):void {
            target[passThroughData.propertyName ] = passThroughData.propertyValue;
            //textInput.text = "SSGA";
        }

        protected function handleVerifyProperty( event:Event, passThroughData:Object ):void {
            //This method will be called after the TextInput is created. The TextInput will be ready to use
            //before any of our test methods run
            var textInput:TextInput = event.target as TextInput;
            Assert.assertEquals(event.target[passThroughData.propertyName ], passThroughData.propertyValue );
            //Assert.assertEquals("SSGA", textInput.text)
        }

        protected function handleExpectedTimeout( passThroughData:Object ):void {
            Assert.assertTrue("this is event is never occcur", true);
        }

        protected function handleUnexpectedEvent( event:Event, passThroughData:Object ):void {
            Assert.fail('Unexpected Event Received');
        }

        protected function handleEventNeverOccurred( passThroughData:Object ):void {
            Assert.fail('Pending Event Never Occurred');
        }
    }

}