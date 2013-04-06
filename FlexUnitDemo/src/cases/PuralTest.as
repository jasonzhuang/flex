package cases {
    import org.flexunit.Assert;

    public class PuralTest {
        private var pural:Pural;

        [Before]
        public function setUp():void {
            pural = new Pural(5, 3);
        }

        [Test]
        public function testEqual():void {
            var other:Pural = new Pural(5, 3);
            Assert.assertEquals(true, pural.equals(other));
        }

    }
}