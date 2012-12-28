package com.netease {
	/**
	 *	ConfigManager
	 */
	public class ConfigManager {

		private static var configData:ConfigData;
		
		public static function parseXML(xml:XML):void {
			configData = new ConfigData();
			
			parseRecommendTemplate(xml.recommendTemplate);
			parseChoosableTemplates(xml.templates);
			
			constructTemplateCategory();
			EventLocator.getInstance().dispatchEvent(new DataNotifyEvent(DataNotifyEvent.CONFIG_LOADED, configData));
		}
		
		private static function parseRecommendTemplate(recommendXML:XMLList):void {
			var recommandTemplate:Template = new Template();
			recommandTemplate.templateId = recommendXML.@id;
			recommandTemplate.type = Template.RECOMMEND;
			var list:XMLList = recommendXML.children();
			for each(var child:XML in list) {
				var item:Object = {};
				//convert XML type to String
				item.index = String(child.@index);
				item.url = String(child.@url);
				recommandTemplate.list.push(item);
			}
			configData.recommendTemplate = recommandTemplate;
		}
		
		private static function parseChoosableTemplates(templates:XMLList):void {
			var templateList:XMLList = templates.children();
			for each(var child:XML in templateList) {
				var template:Template = new Template();
				template.templateId = String(child.@id);
				template.type = String(child.@type);
				template.previewImg = String(child.previewImg.@url);
				template.categoryName = String(child.@categoryName);
				for each(var templateItem:XML in child..item) {
					var item:Object = {};
					item.index = String(templateItem.@index);
					item.url = String(templateItem.@url);
					template.list.push(item);
				}
				configData.choosableTemplates.push(template);
			}
		}
		
		private static function constructTemplateCategory():void {
			var categoryTemplate:Template = new Template();
			categoryTemplate.type = Template.CATEGORY;
			var templates:Array = configData.choosableTemplates;
			for each(var template:Template in templates) {
				categoryTemplate.list.push(template);
			}
			
			configData.templateCategory = categoryTemplate;
		}
	}
}