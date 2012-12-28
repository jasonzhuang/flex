package com.threekindoms.client.presentmodel
{
    import com.electrotank.electroserver5.api.EsObject;
    import com.threekindoms.client.events.MoveCardEvent;
    import com.threekindoms.client.model.PluginConstants;
    import com.threekindoms.client.plugins.MoveCardAction;
    import com.threekindoms.client.utils.DisplayCardFactory;
    import com.threekindoms.client.utils.datamap.CardManager;
    import com.threekindoms.client.utils.datamap.Parser;
    import com.threekindoms.client.vo.Card;
    import com.threekindoms.client.vo.Coordinate;
    import com.threekindoms.client.vo.DisplayCard;
    
    import flash.events.EventDispatcher;
    
    import org.flexunit.Assert;
    import org.flexunit.async.Async;

    public class PlaygamePmTest
    {
        private var playgamePm:PlayGamePm;
        private static var cardManager:CardManager;

        [BeforeClass]
        public static function setEnv():void {
            cardManager = Parser.getInstance().constructMap();
        }

        [AfterClass]
        public static function clearEnv():void {
            cardManager = null;
        }

        [Before]
        public function setUp():void {
            playgamePm = new PlayGamePm(new EventDispatcher());
        }

        [After]
        public function tearDown():void {
            playgamePm = null;
        }

        [Test(async)]
        public function testMoveCard():void {
            var async:Function = Async.asyncHandler(this, moveCardHandler, 10000, null, timeourHandler);
            playgamePm.addEventListener(MoveCardEvent.MOVE_CARD, async, false, 0, true);
            var moveCardAction:MoveCardAction = new MoveCardAction();
            var para:EsObject = new EsObject();
            var mockedCards:Array = constructEsObjectCards();
            para.setEsObjectArray(PluginConstants.MOVE_CARD, mockedCards);
            moveCardAction.action(para, playgamePm);
        }

        private function moveCardHandler(event:MoveCardEvent, data:Object):void {
            var cards:Array = event.cards;
            Assert.assertNotNull(cards);
            var displayCard:DisplayCard;
            var displayCards:Array = [];
            for each (var card:Card in cards) {
                displayCard = DisplayCardFactory.constrcutDisplayCard(card);
                displayCards.push(displayCard);
            }
            displayCard = displayCards[0] as DisplayCard;
            var coordinate:Coordinate = cardManager.getLocationFromIdentifier(displayCard.destCoordinate);
            Assert.assertEquals(coordinate.locationX, 20);
            Assert.assertEquals(coordinate.locationY, 5);
        }

        private function timeourHandler(data:Object):void {
            Assert.fail("moveCard time out");
        }

        private function constructEsObjectCards():Array
        {
            var cards:Array = [];
            var card:EsObject;
            for (var i:int = 0; i<5; i++) {
                card = new EsObject();
                card.setInteger(PluginConstants.X, 0);
                card.setInteger(PluginConstants.Y, i);
                card.setInteger(PluginConstants.DESTINATION_X, 0);
                card.setInteger(PluginConstants.DESTINATION_Y, i);
                card.setInteger(PluginConstants.CARD_ID, i);
                card.setInteger(PluginConstants.CARD_TYPE, 1);
                card.setIntegerArray(PluginConstants.CARD_ARRTIBUTES, []);
                cards.push(card);
            }
            return cards;
        }
    }
}