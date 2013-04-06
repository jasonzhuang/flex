package view {

    import event.ToggleEvent;

    import org.flexunit.Assert;
    import org.flexunit.Assume;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    public class ToggleHelperExitConfirmFailedTest extends ToggleHelperTestBase {

        [Before(async, ui)]
        public function setUp():void {
            super.prepare(new ToggleContainer([new Page(), new Page()]));
            Assume.assumeTrue(!(this.container..getPage(0) as Page).rentered);

            super.startToggle();
        }

        [Test(async, ui)]
        public function testOutComp():void {
            Assert.assertEquals(this.container.getPage(0), this.container.currentPage);

            Assert.assertFalse(this.container.getPage(0).existed);
            Assert.assertFalse(this.container.getPage(1).entered);
            Assert.assertTrue((this.container.getPage(0) as Page).rentered);
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

    override public function confirmExit(context:Dictionary):ToggleConfirmResult {
        if (counter == 0) {
            counter = 5;
            return ToggleConfirmResult.FAILED;
        }

        counter--;
        return ToggleConfirmResult.WAIT;
    }

    public var rentered:Boolean = false;

    override public function reenter(context:Dictionary):void {
        this.rentered = true;
    }
}