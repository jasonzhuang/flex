package com.threekindoms.client.utils.datamap
{
    import com.threekindoms.client.errors.SingletonError;
    
    import mx.core.ByteArrayAsset;

    public class Parser
    {
        [Embed(source="CardPositionMap.xml", mimeType="application/octet-stream")]
        private static const xmlData:Class;

        private static var xml:XML;

        private static var instance:Parser;
        private var cardManager:CardManager = new CardManager();

        public static function getInstance():Parser {
            if (instance == null) {
                instance = new Parser();
                initializeParser();
            }
            return instance;
        }

        public function Parser() {
            if (instance != null) {
                throw new SingletonError("com.threekindoms.client.utils.datamap.Parser should be singleton");
            }
            instance = this;
        }

        private static function initializeParser():XML {
            var storyByteArray:ByteArrayAsset = ByteArrayAsset(new xmlData());
            xml = new XML(storyByteArray.readUTFBytes(storyByteArray.length));
            return xml;
        }

        public function constructMap():CardManager {
            var children:XMLList = xml.children();
            for each(var cardMap:XML in children) {
                cardManager.buildMap(cardMap);
            }
            return cardManager;
        }

    }
}