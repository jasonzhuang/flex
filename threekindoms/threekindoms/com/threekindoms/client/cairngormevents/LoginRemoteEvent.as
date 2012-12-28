package com.threekindoms.client.cairngormevents
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoginRemoteEvent extends CairngormEvent
	{
		public static const LOGIN:String = "com.threekindoms.client.cairngormevents.LoginRemoteEvent";

        private var _userName:String;
        private var _password:String;

		public function LoginRemoteEvent(userName:String, password:String)
		{
			super(LOGIN);
			this._userName = userName;
			this._password = password;
		}
	
	    public function get userName():String {
	        return this._userName;
	    }
	   	
	   	public function get password():String {
	   		return this._password;
	   	}
	}
}