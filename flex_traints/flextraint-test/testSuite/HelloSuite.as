package testSuite {
    import testcases.HelloTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class HelloSuite {
        public var hello:HelloTest;
    }
}