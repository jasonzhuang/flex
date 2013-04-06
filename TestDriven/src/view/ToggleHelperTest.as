package view {

    import event.ToggleEvent;
    
    import org.flexunit.Assert;
    import org.flexunit.Assume;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;

    public class ToggleHelperTest extends ToggleHelperTestBase {

        [Before(async, ui)]
        public function setUp():void {
            super.prepare(new ToggleContainer([new Page(), new Page()]));
            this.startToggle();
        }

        [Test(async, ui)]
        public function testOutComp():void {
            Assert.assertEquals(this.container.getPage(1), this.container.currentPage);

            Assert.assertTrue(this.container.getPage(0).existed);
            Assert.assertTrue(this.container.getPage(1).entered);
        }
    }
}

import view.TogglePage;

class Page extends TogglePage {
}