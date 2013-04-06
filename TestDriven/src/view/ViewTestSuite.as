
package view {

    /**
    * Test suite constains all of test cases in package
    * <code>com.ssga.ssgai.common.shared.utils</code>.
    */
    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ViewTestSuite {

        /**
        * <p>
        * Test case for <code>ToggleManager</code>.
        * </p>
        */
        public var toggleHelperTest:ToggleHelperTest;

        public var toggleHelperExitConfirmTest:ToggleHelperExitConfirmTest;

        public var toggleHelperExitConfirmFailedTest:ToggleHelperExitConfirmFailedTest;

        public var toggleHelperEnterConfirmTest:ToggleHelperEnterConfirmTest;

        public var toggleHelperEnterConfirmFailedTest:ToggleHelperEnterConfirmFailedTest;
    }
}