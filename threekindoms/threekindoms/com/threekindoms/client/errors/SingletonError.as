package com.threekindoms.client.errors
{
	public class SingletonError extends Error
	{
		public function SingletonError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}