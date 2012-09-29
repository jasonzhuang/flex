package dynamicAuthorize
{
    import dynamicAuthorize.PermissionManager;

    public class VIPLogin
    {
        private var _isVIP:Boolean = false;

        public function VIPLogin() {
            PermissionManager.getInstance().registerProperty("isVIP", this);
        }

        public function set isVIP(value:Boolean):void {
            this._isVIP = value;
            populate();
        }

        public function get isVIP():Boolean {
            return this._isVIP;
        }

        private function populate():void {
            if (this.isVIP) {
                trace("The user is VIP......");
            } else {
                trace("The user is not VIP....");
            }
        }
    }
}