package cases {
    public class Pural {
        private var _real:Number;
        private var _imaginary :Number;

        public function Pural(real:Number, imaginary:Number) {
            this._real = real;
            this._imaginary = imaginary;
        }

        public function equals(other:Pural):Boolean {
            return true;
        }
    }
}