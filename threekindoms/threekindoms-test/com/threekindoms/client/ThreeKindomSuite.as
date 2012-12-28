package com.threekindoms.client
{
    import com.threekindoms.client.plugins.PluginSuite;
    import com.threekindoms.client.presentmodel.PresentModelTestSuite;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ThreeKindomSuite
    {
//    	public var pluginSuite:PluginSuite;
        public var presentModelSuite:PresentModelTestSuite;
    }
}
