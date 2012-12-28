package com.threekindoms.client.plugins
{
	import flash.events.IEventDispatcher;
    import com.electrotank.electroserver5.api.EsObject;

	public interface IPluginAction
	{
		function action(para:EsObject, dispatcher:IEventDispatcher):void;
	}
}