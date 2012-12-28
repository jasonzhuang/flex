package com.threekindoms.client.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.threekindoms.client.errors.UnImplementationError;

	public class BaseCommand implements ICommand
	{
		public function BaseCommand()
		{
		}

        /**
        * should use handleExecute() instead of execute()
        */ 
		public function execute(event:CairngormEvent):void
		{
			handleExecute(event);
		}
		
		public function handleExecute(event:CairngormEvent):void {
			throw new UnImplementationError("execute() is not implemented");
		}
	}
}