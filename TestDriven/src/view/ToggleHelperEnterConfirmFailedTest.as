package view {

    import org.flexunit.Assert;
    import org.flexunit.Assume;

    public class ToggleHelperEnterConfirmFailedTest extends ToggleHelperTestBase {

        [Before(async, ui)]
        public function setUp():void {
            super.prepare(new ToggleContainer([new Page(), new Page()]));

            Assume.assumeTrue(!(this.container.getPage(1) as Page).enterConfirmed);
            Assume.assumeTrue(!(this.container.getPage(0) as Page).reentered);

            super.startToggle();
        }

        [Test(async, ui)]
        public function testOutComp():void {
            Assert.assertEquals(this.container.getPage(0), this.container.currentPage);

            Assert.assertTrue(this.container.getPage(0).existed);
            Assert.assertFalse(this.container.getPage(1).entered);

            Assert.assertTrue((this.container.getPage(1) as Page).enterConfirmed);
            Assert.assertTrue((this.container.getPage(0) as Page).reentered);
        }
    }
}

import flash.utils.Dictionary;

import view.ToggleConfirmResult;
import view.TogglePage;

class Page extends TogglePage {

    private var counter:int = 5;

    public var enterConfirmed:Boolean = false;

    override public function confirmEnter(context:Dictionary):ToggleConfirmResult {
        if (counter == 0) {
            counter = 5;
            this.enterConfirmed = true;
            return ToggleConfirmResult.FAILED;
        }

        this.counter--;
        return ToggleConfirmResult.WAIT;
    }

    public var reentered:Boolean = false;

    override public function reenter(context:Dictionary):void {
        this.reentered = true;
    }

    override public function prepareEnter(context:Dictionary):Boolean {
        return false;
    }
}