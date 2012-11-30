package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import fl.text.TLFTextField;
    import flash.text.*;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
    /**
     * ...
     * @author Andreas Rønning
     */
    public class Dialog extends Sprite
    {
        //A constant common size for all dialog windows. 
        public static const DIMS:Rectangle = new Rectangle(0, 0, 550, 400);
        //The top/left/right/bot margin for buttons and the textfield in pixels
        public static const MARGIN:int = 10;
        
        //A reference to the manager object
        protected var manager:DialogManager;
        //The text prompt
        protected var textprompt:String;
        //A reference to the function to call when "OK" is pushed
        protected var onOK:Function;
        //A reference to the function to call when "Cancel" is pushed
        protected var onCancel:Function;
        //The "OK" button text
        protected var okText:String;
        //The "cancel" button text
        protected var cancelText:String;
        
        //References to two instances of the internal DialogButton class
        protected var okButton:DialogButton;
        protected var cancelButton:DialogButton;
        
        //The textfield for our prompt
        protected var tf:TLFTextField;
        public function Dialog(manager:DialogManager, textprompt:String, okText:String, onOK:Function = null, cancelText:String = "cancel", onCancel:Function = null) 
        {
            //Store all the properties we need...
            this.manager = manager;
            this.onCancel = onCancel;
            this.onOK = onOK;
            this.textprompt = textprompt;
            this.okText = okText;
            this.cancelText = cancelText;
            //Then draw. There's no real reason the draw() body isn't in this constructor. 
            //Just keeping it clean for now.
            draw();
        }
        
        private function draw():void
        {
            //This stuff is obvious but I'll comment it anyway
            //Draw our outlined background
            graphics.beginFill(0xFFFFFF);
            graphics.lineStyle(0, 0);
            graphics.drawRect(0, 0, DIMS.width, DIMS.height);
            
            //Grab and display a textfield from our internal createNiceTextfield method
            tf = new TLFTextField();

			var format:TextFormat = new TextFormat(); 
			format.align = TextFormatAlign.JUSTIFY;
			format.font = "Tahoma";
			format.leading = 16.0;
			format.size = 21.0;
		
			tf.defaultTextFormat = format;

			tf.direction = Direction.RTL;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.selectable = false;
			tf.wordWrap = true;
			tf.mouseEnabled = false;
			tf.embedFonts = true;
		
			// good for right-aligned or centered dynamic text
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.gridFitType = GridFitType.SUBPIXEL;

			tf.textFlow = TextConverter.importToFlow(textprompt, TextConverter.TEXT_FIELD_HTML_FORMAT);
			//tf.text = textprompt;

            //Align it and scale it to fit into our window, leaaving space for buttons
            tf.x = MARGIN + 20.0;
            tf.y = MARGIN + 20.0;
            tf.width = DIMS.width - MARGIN - 40.0;
            tf.height = DIMS.height - MARGIN - 40.0;
            addChild(tf);
            
            //Create and display our "Ok" Button, using the internal class DialogButton
            okButton = new DialogButton();
            //Initialize it with our okText property
            okButton.initialize(okText); 
            //And set it up for hot click action
            okButton.addEventListener(MouseEvent.CLICK, onOkClick, false, 0, true);
            addChild(okButton);
            
            //Align it to the bottom left + the margin
            okButton.x = MARGIN;
            okButton.y = DIMS.height - okButton.height - MARGIN;
            
            //If onCancel has been defined, create a cancel button in the same way
            if(onCancel!=null){
                cancelButton = new DialogButton();
                cancelButton.initialize(cancelText);
                cancelButton.addEventListener(MouseEvent.CLICK, onCancelClick, false, 0, true);
                addChild(cancelButton);
                
                //Align to bottom right
                cancelButton.x = DIMS.width - cancelButton.width - MARGIN;
                cancelButton.y = DIMS.height - okButton.height - MARGIN;
            }
        }
        protected function onOkClick(e:Event):void {
            if(onOK!=null) onOK(); //If the onOK function is defined, call it
            destroy(); 
        }
        protected function onCancelClick(e:Event):void {
            //this listener isn't set up if onCancel does not exist, so no check
            onCancel(); 
            destroy();
        }
        protected function destroy():void {
            //Tell the manager we are good to go
            manager.destroyDialog(this); 
        }
        
    }

}
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import fl.text.TLFTextField;
import flash.text.*;
import flashx.textLayout.formats.TextDecoration;
import flashx.textLayout.formats.Direction;
import flashx.textLayout.conversion.TextConverter;
import flashx.textLayout.elements.LinkElement;
import flashx.textLayout.events.FlowElementMouseEvent;

internal class DialogButton extends Sprite {
    /**
     * Internal classes don't like constructors
     * This method creates a simple button that scales to its label
     * @param   text
     */
    public function initialize(text:String):void {
        var tf:TLFTextField = createNiceTextfield(text);
        tf.autoSize = TextFieldAutoSize.LEFT;
        graphics.beginFill(0xFFFFFF);
        graphics.lineStyle(0, 0);
        graphics.drawRect(0, 0, tf.width + 5, tf.height + 5);
        addChild(tf);
        tf.y = 2.5;
        tf.x = 2.5;
        buttonMode = true;
    }
}
/**
 * Internal function  for grabbing a textfield with no mouse and a default textformat
 * @param   text
 * @return
 */
internal function createNiceTextfield(text:String = ""):TLFTextField {
    var tf:TLFTextField = new TLFTextField();

	var format:TextFormat = new TextFormat(); 
	format.align = TextFormatAlign.LEFT;
	format.font = "Tahoma";
	format.size = 24.0;

	tf.defaultTextFormat = format;
	
	tf.direction = Direction.LTR;
	tf.autoSize = TextFieldAutoSize.LEFT;
	tf.selectable = false;
	tf.wordWrap = false;
	tf.mouseEnabled = false;
	tf.embedFonts = true;

	tf.antiAliasType = AntiAliasType.ADVANCED;
	tf.gridFitType = GridFitType.PIXEL;

	tf.text = text;

    return tf;
}


