package utils
{
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    public class ClassUtil
    {
        public static function getClassFromName(obj:Object):Class {
            var className:String = getQualifiedClassName(obj);
            //following is equal
            var klass:Class = getDefinitionByName(className) as Class;
            //var clazz:Class = Klass.getClassFromName(className);
            return klass;
        }

        public static function getClassShortName(obj:Object):String {
            var classFullName:String = getQualifiedClassName(obj);
            var begin:int = classFullName.lastIndexOf(":");
            var className:String = classFullName.substr(begin+1, classFullName.length);
            return className;
        }
    }
}