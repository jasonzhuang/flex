package {
	import flash.display.Sprite;
	
	/**
	 *	CutomerButtonTest
	 */
	public class CutomerButtonTest extends Sprite {
		public function CutomerButtonTest()
		{
			var button1:RectangleButton = new RectangleButton( "Button 1", 60, 100 );
			button1.x = 20;
			button1.y = 20;
			var button2:RectangleButton = new RectangleButton( "Button 2", 80, 30 );
			button2.x = 90;
			button2.y = 20;
			var button3:RectangleButton = new RectangleButton( "Button 3", 100, 40 );
			button3.x = 100;
			button3.y = 60;
			// Add the buttons to the display list so they appear on-screen
			addChild( button1 );
			addChild( button2 );
			addChild( button3 );
		}
	}
}

import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class RectangleButton extends SimpleButton {
	// The text to appear on the button
	private var _text:String;
	// Save the width and height of the rectangle
	private var _width:Number;
	private var _height:Number;
	
	public function RectangleButton( text:String, width:Number, height:Number ) {
		// Save the values to use them to create the button states
		_text = text;
		_width = width;
		_height = height;
		// Create the button states based on width, height, and text value
		upState = createUpState( );
		overState = createOverState( );
		downState = createDownState( );
		hitTestState = upState;
	}
	
	private function createUpState( ):Sprite {
		var sprite:Sprite = new Sprite( );
		var background:Shape = createdColoredRectangle( 0x33FF66 );
		var textField:TextField = createTextField( false );
		sprite.addChild( background );
		sprite.addChild( textField );
		return sprite;
	}
	
	private function createOverState( ):Sprite {
		var sprite:Sprite = new Sprite( );
		var background:Shape = createdColoredRectangle( 0x70FF94 );
		var textField:TextField = createTextField( false );
		sprite.addChild( background );
		sprite.addChild( textField );
		return sprite;
	}
	
	private function createDownState( ):Sprite {
		var sprite:Sprite = new Sprite( );
		var background:Shape = createdColoredRectangle( 0xCCCCCC );
		var textField:TextField = createTextField( true );
		sprite.addChild( background );
		sprite.addChild( textField );
		return sprite;
	}
	
	private function createdColoredRectangle( color:uint ):Shape {
		var rect:Shape = new Shape( );
		rect.graphics.lineStyle( 1, 0x000000 );
		rect.graphics.beginFill( color );
		rect.graphics.drawRoundRect( 0, 0, _width, _height, 15 );
		rect.graphics.endFill( );
		rect.filters = [ new DropShadowFilter(2) ];
		return rect;
	}
	
	private function createTextField( downState:Boolean ):TextField {
		var textField:TextField = new TextField( );
		textField.text = _text;
		textField.width = _width;
		// Center the text horizontally
		var format:TextFormat = new TextFormat( );
		format.align = TextFormatAlign.CENTER;
		textField.setTextFormat( format );
		// Center the text vertically
		textField.y = ( _height - textField.textHeight ) / 2;
		textField.y -= 2; // Subtract 2 pixels to adjust for offset
		// The down state places the text down and to the right
		// further than the other states
		if ( downState ) {
			textField.x += 1;
			textField.y += 1;
		}
		return textField;
	}
}