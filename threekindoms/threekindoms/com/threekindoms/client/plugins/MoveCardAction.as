package com.threekindoms.client.plugins
{
    import com.threekindoms.client.events.MoveCardEvent;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.vo.Card;
    import com.electrotank.electroserver5.api.EsObject;

    import flash.events.IEventDispatcher;

    public class MoveCardAction implements IPluginAction
    {
        public function action(para:EsObject, dispatcher:IEventDispatcher):void {
            var card:Card;
            var operatingCards:Array = [];
            var serverCards:Array = para.getEsObjectArray(PluginConstants.MOVE_CARD);
            for each(var esCard:EsObject in serverCards) {
                card = convertToCard(esCard);
                operatingCards.push(card);
            }
            dispatcher.dispatchEvent(new MoveCardEvent(operatingCards));
        }

        private function convertToCard(esObject:EsObject):Card {
            var card:Card = new Card();
            card.x = esObject.getInteger(PluginConstants.X);
            card.y = esObject.getInteger(PluginConstants.Y);
            card.dest_x = esObject.getInteger(PluginConstants.DESTINATION_X);
            card.dest_y = esObject.getInteger(PluginConstants.DESTINATION_Y);
            card.cardId = esObject.getInteger(PluginConstants.CARD_ID);
            card.cardType = esObject.getInteger(PluginConstants.CARD_TYPE);
            card.cardArrtributes = esObject.getIntegerArray(PluginConstants.CARD_ARRTIBUTES);
            return card;
        }
    }
}