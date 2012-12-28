package com.threekindoms.client.cairngormevents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.threekindoms.client.vo.UserInfo;

	public class RegisterRemoteEvent extends CairngormEvent
	{
		public static const REGISTER:String = "com.threekindoms.client.cairngormevents.RegisterRemoteEvent";

        private var _userInfo:UserInfo;

        public function get userInfo():UserInfo {
            return this._userInfo;
        }

		public function RegisterRemoteEvent(userInfo:UserInfo)
		{
			super(REGISTER);
			this._userInfo = userInfo;
		}
		
	}
}