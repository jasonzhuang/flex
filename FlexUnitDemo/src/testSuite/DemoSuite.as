package testSuite {

    import cases.AsynTest;
    import cases.AsynTestSetUp;
    import cases.DemoPmTest;
    import cases.PuralTest;
    import cases.SimpleMathTest;
    import cases.UIComponentTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class DemoSuite {
        public var simpleMathTest:SimpleMathTest;
        public var asynSetUpTest:AsynTestSetUp;
        public var asynTest:AsynTest;
        public var uiTest:UIComponentTest
        public var demoPmTest:DemoPmTest;
        //public var puralTest:PuralTest;
    }
}