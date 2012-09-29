package vo {
    import com.adobe.cairngorm.vo.IValueObject;

    [Bindable]
    [RemoteClass(alias="vo.Employee")]

    public class Employee implements IValueObject{
        public var id:int;
        public var name:String;

        public function Employee() {
        }
    }
}