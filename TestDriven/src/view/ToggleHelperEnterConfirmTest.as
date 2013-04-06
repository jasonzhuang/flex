package view {

    import event.ToggleEvent;
    
    import org.flexunit.Assert;
    import org.flexunit.Assume;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    public class ToggleHelperEnterConfirmTest extends ToggleHelperTestBase {

        [Before(async, ui)]
        public function setUp():void {
            super.prepare(new ToggleContainer([new Page(), new Page()]));

            Assume.assumeTrue(!(this.container.getPage(1) as Page).enterConfirmed);

            super.startToggle();
        }

        [Test(async, ui)]
        public function testOutComp():void {
            Assert.assertEquals(this.container.getPage(1), this.container.currentPage);

            Assert.assertTrue(this.container.getPage(0).existed);
            Assert.assertTrue(this.container.getPage(1).entered);

            Assert.assertTrue((this.container.getPage(1) as Page).enterConfirmed);
        }
    }
}

import flash.utils.Dictionary;

import view.TogglePage;
import view.ToggleConfirmResult;

class Page extends TogglePage {

    override public function prepareEnter(context:Dictionary):Boolean {
        return false;
    }

    public var enterConfirmed:Boolean = false;

    private var counter:int = 5;

    override public function confirmEnter(context:Dictionary):ToggleConfirmResult {
        if (this.counter == 0) {
            this.counter = 5;
            this.enterConfirmed = true;
            return ToggleConfirmResult.SUCCESSED;
        }

        this.counter--;
        return ToggleConfirmResult.WAIT;
    }
}