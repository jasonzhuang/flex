package com.threekindoms.client.plugins
{
    import com.threekindoms.client.events.OperationEvent;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.vo.OperationInfo;
    import com.electrotank.electroserver5.api.EsObject;

    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    public class OperationAction implements IPluginAction
    {
        public function action(para:EsObject, dispatcher:IEventDispatcher):void
        {
            var operations:Array;
            var operation:OperationInfo;
            var data:Array = para.getEsObjectArray(PluginConstants.OPERATION_LIST);
            for each (var es:EsObject in data) {
                operation = convertToOperation(es);
                operations.push(es);
            }
            dispatcher.dispatchEvent(new OperationEvent(operations));
        }

        private function convertToOperation(para:EsObject):OperationInfo {
            var operationInfo:OperationInfo = new OperationInfo();
            operationInfo.operation = para.getString(PluginConstants.OPERATION);
            return operationInfo;
        }
    }
}