package utils{
    import flash.net.SharedObject;
    import mx.collections.ArrayCollection;
    
    public class ShareObjectHandler {
        private var shareObject:SharedObject;
        private var ac:ArrayCollection;
        private var solType:String;

        public function ShareObjectHandler(name:String) {
            this.solType = name;
            this.ac = new ArrayCollection();
            this.shareObject = SharedObject.getLocal(name, "/");
            if(getObjects()) {
                ac = getObjects();
            }
        }

        public function clear():void {
            this.shareObject.clear();
        }

        public function flush():void {
            this.shareObject.flush();
        }

        public function get data():Object {
            return this.shareObject.data;
        }

        public function getObjects():ArrayCollection {
            return shareObject.data[solType];
        }

        public function addObject(o:Object):void {
            ac.addItem(o);
            updateShareObject();
        }

        private function updateShareObject():void {
            this.shareObject.data[solType] = ac;
            this.shareObject.flush();
        }
    }
}