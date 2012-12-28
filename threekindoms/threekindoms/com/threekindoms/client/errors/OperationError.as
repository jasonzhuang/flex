package com.threekindoms.client.errors
{
	public class OperationError extends Error
	{
		public function OperationError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}