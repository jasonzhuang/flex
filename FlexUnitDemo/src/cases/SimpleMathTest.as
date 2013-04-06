package cases {
    import org.flexunit.Assert;

    public class SimpleMathTest {
        private var simpleMath:SimpleMath;

        [Before]
        public function runBeforeEveryTest():void {
            simpleMath = new SimpleMath();
        }

        [After]
        public function runAfterEveryTest():void {
            simpleMath = null;
        }

        [Test]
        public function addition():void {
            Assert.assertEquals(12, simpleMath.add(7, 5));
        }

        [Test]
        public function subtraction():void {
            Assert.assertEquals(9, simpleMath.subtract(12, 3));
        }

        //[Test(expects="TypeError")]
        [Test]
        public function divisionWithException():void {
            try {
                simpleMath.divide( 11, 0 );
                Assert.fail("should throw an error!");
            } catch (expected:TypeError){
                Assert.assertEquals("Cannot divide by 0", expected.message);
            }
//            Assert.assertEquals(5, simpleMath.divide(10, 0));
        }

        [Test]
        public function testAddExtreme():void {
            Assert.assertEquals(5, simpleMath.addExtreme(15, 3));
        }
    }
}