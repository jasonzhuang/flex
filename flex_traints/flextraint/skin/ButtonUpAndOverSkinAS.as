package skin
{
	import mx.skins.ProgrammaticSkin;

	public class ButtonUpAndOverSkinAS extends ProgrammaticSkin
	{
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            switch (name) {  
		       case "overSkin": {
		          graphics.lineStyle(1, 0xFF0000);
		          graphics.beginFill(0x00CCFF, 0.50);
		          graphics.drawRoundRect(0, 0, unscaledWidth, unscaledHeight, 10, 10);
		         break;
			   }
		      case "downSkin": {
		          graphics.lineStyle(1,0xFFCCCD);
		          graphics.beginFill(0xCCFDFD, 0.5);
		          graphics.drawRoundRect(0, 0, unscaledWidth, unscaledHeight, 10, 10);
		          break;
			  }
			}
	}
}