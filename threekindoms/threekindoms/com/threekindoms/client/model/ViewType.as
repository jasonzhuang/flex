package com.threekindoms.client.model
{

    public class ViewType
    {
        private var _viewName:String;

        public function ViewType(viewName:String)
        {
            this._viewName = viewName;
        }

        public function get viewName():String
        {
            return this._viewName;
        }

        public static const WaitingView:ViewType = new ViewType("waitingView");
        public static const GameFlowView:ViewType = new ViewType("gameFlowView");
        public static const LandingView:ViewType = new ViewType("landingView");
        public static const GameScreen:ViewType = new ViewType("gameScreen");
    }
}
