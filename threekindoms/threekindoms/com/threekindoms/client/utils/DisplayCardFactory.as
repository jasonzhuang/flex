package com.threekindoms.client.utils
{
    import com.threekindoms.client.vo.Card;
    import com.threekindoms.client.vo.Coordinate;
    import com.threekindoms.client.vo.DisplayCard;

    public class DisplayCardFactory
    {
        public static function constrcutDisplayCard(card:Card):DisplayCard
        {
            var displayCard:DisplayCard = new DisplayCard();
            displayCard.cardId = card.cardId;
            displayCard.originalCoordinate = new Coordinate(card.x, card.y);
            displayCard.destCoordinate = new Coordinate(card.dest_x, card.dest_y);
            return displayCard;
        }
    }
}
