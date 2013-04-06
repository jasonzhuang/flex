package view {

    import event.ToggleEvent;

    import org.flexunit.Assert;
    import org.flexunit.Assume;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    public class ToggleHelperExitConfirmTest extends ToggleHelperTestBase {

        [Before(async, ui)]
        public function setUp():void {
            super.prepare(new ToggleContainer([new Page(), new Page()]));

            Assume.assumeTrue(!(this.container.getPage(0) as Page).exitConfirmed);

            super.startToggle();
        }

        [Test(async, ui)]
        public function testOutComp():void {
            Assert.assertEquals(this.container.getPage(1), this.container.currentPage);

            Assert.assertTrue(this.container.getPage(0).existed);
            Assert.assertTrue(this.container.getPage(1).entered);

            Assert.assertTrue((this.container.getPage(0) as Page).exitConfirmed);
        }
    }
}

import flash.utils.Dictionary;

import view.TogglePage;
import view.ToggleConfirmResult;

class Page extends TogglePage {

    override public function prepareExit(context:Dictionary):Boolean {
        return false;
    }

    private var counter:int = 5;

    public var exitConfirmed:Boolean = false;

    override public function confirmExit(context:Dictionary):ToggleConfirmResult {
        if (counter == 0) {
            this.exitConfirmed = true;
            counter = 5;
            return ToggleConfirmResult.SUCCESSED;
        }

        counter--;
        return ToggleConfirmResult.WAIT;
    }
}