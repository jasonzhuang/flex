package skin {
    import mx.controls.ComboBox;

    public class MyComboBox extends ComboBox {
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			drawRoundRect(1, 1, 200-2, 200-2, 0, 
				[0xFF0000, 0xFFFF00, 0x0000FF], 0, 
				verticalGradientMatrix(1, 1, 200-2, 200-2));
			drawRoundRect(1, 1, 200-2, 
				(200-2)/2, {tl:5,tr:5,bl:0,br:0},
				[0xFFFFFF, 0xFFFFFF], 
				0, 
				verticalGradientMatrix(0,0,200-2,(200-2)/2));
		}
    }
}