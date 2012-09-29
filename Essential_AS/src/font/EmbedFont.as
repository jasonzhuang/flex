package font {
    import flash.display.Sprite;

    /**
    * Note:
    * 1).when a text field is rendered using embedded fonts and a given character’s
    * font is not available in the list of embedded fonts,then the character is not rendered at all,
    * and no text appears on screen!
    * 2).To determine the list of device fonts and embedded fonts available at runtime, use
    * the Font class’s static method enumerateFonts()
    */
    public class EmbedFont extends Sprite {
        public function EmbedFont() {
            var t:TextField = new TextField( );
            t.embedFonts = true;
            //assume font <Verdana> is embedded
            t.htmlText = "<FONT FACE='Verdana'>Hello <b>world</b></FONT>";
            var fonts:Array = Font.enumerateFonts(true);
            fonts.sortOn("fontName", Array.CASEINSENSITIVE);
            for (var i:int = 0; i < fonts.length; i++) {
                trace(fonts[i].fontType + ": "
                + fonts[i].fontName + ", " + fonts[i].fontStyle);
            }
        }
    }
}