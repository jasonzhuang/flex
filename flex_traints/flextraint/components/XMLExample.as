package components {
    public class XMLExample {

        private var _employees:XML;

        public function XMLExample() {
            this._employees =
                <employees>
	                    <employee ssn="123-123-1234">
	                        <name>
	                            Joe
	                        </name>
	                        <address>
	                            <street>11 Main St.</street>
	                            <city>San Francisco</city>
	                            <state>CA</state>
	                            <zip>98765</zip>
	                        </address>
	                    </employee>
	                    <employee ssn="789-789-7890">
	                        <name>
	                            jaosn
	                        </name>
	                        <address>
	                            <street>99 Broad St.</street>
	                            <city>Newton</city>
	                            <state>MA</state>
	                            <zip>01234</zip>
	                        </address>
	                    </employee>
                </employees>;
        }

        public function get employees():XML {
            return this._employees;
        }
    }
}