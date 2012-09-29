package vo {
    [Bindable]
    public class BindableObject {
        public var innerObject:InnerObject;

        public var stringPro:String = "default string";

        public function BindableObject(){
            innerObject = new InnerObject();
        }

    }
}