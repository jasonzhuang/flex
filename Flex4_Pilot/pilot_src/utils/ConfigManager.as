package utils
{
	import errors.ReflectError;
	
	import flash.utils.*;
	
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	
	public class ConfigManager
	{
		public static function generateSingle(target:String):Object {
			var obj:Object;
			try {
				var clazz:Class = getDefinitionByName(target) as Class;
				obj = new clazz();
			} catch(e:Error) {
				throw new ReflectError("generate class error: " + e.message);
			}
			
			return obj;
		}
		
		public static function generateBatch(config:XML):Object {
			var container:Object;
			var childObj:Object;
			try {
				var containerName:String = config.widgetContainer.@type;
				container = generateSingle(containerName);
				var childList:XMLList = config.widgetContainer.children();
				for each(var childItem:XML in childList) {
					childObj = generateSingle(childItem.@type);
					container.addElement(childObj);
				}
			} catch(e:Error) {
				throw new ReflectError("generate class error: " + e.message);
			}
			return container;
		}
	}
}