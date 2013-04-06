
package utils {

    /**
     * ABSTRACT.
     */
    public class Enum {
        private var __id:String;
        private var __name:String;

        /**
         * Constructor.
         *
         * @param theID input id
         * @param theName input name
         */
        public function Enum(theID:String, theName:String = "") {
            __id = theID;
            __name = theName;
        }

        /**
         * Getter of the id
         */
        public function get id():String {
            return __id;
        }

        public function get name():String {
            return this.__name;
        }

        /**
         * toString function of enum.
         * If its name is empty, use id instead.
         */
        public function toString():String {
            return __name == "" ? __id : __name;
        }
    }
}