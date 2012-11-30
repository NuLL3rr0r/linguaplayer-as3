package
{
    import flash.display.Sprite;
    import flash.events.Event;
    /**
     * ...
     * @author Andreas Rønning
     */
    public class DialogManager extends Sprite
    {
        
        private var dialogQueue:Array = []; //The queue that holds all dialogs to be displayed
        private var activeDialog:Dialog = null; //A pointer to the currently displaying dialog
        
        //Singleton instance of the DialogManager
        private static var INSTANCE:DialogManager;
        //Public static getter for the instance, so it can be referred to application-wide
        public static function get instance():DialogManager {
            if (!INSTANCE) INSTANCE = new DialogManager();
            return INSTANCE;
        }
        public function DialogManager() 
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
            visible = false; //Initially invisible
        }
        private function init(e:Event):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true); //Listen to stage
            onStageResize();
        }
        private function onStageResize(e:Event = null):void 
        {
            // We draw a stage-covering background on our manager Sprite to ensure background clicks won't pass through
            graphics.clear();
            graphics.beginFill(0, .2); //A little darkening to show that the background is inactive
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            
            if (activeDialog != null) {
                //if there's a dialog active, realign it to stage center. NICE STYLE MOVE!
                activeDialog.x = stage.stageWidth / 2 - activeDialog.width / 2;
                activeDialog.y = stage.stageHeight / 2 - activeDialog.height / 2;
            }
        }
        /**
         * Our basic createDialog method for adding dialogs to the queue
         * @param   textprompt
         * The main text of the dialog
         * @param   okText
         * The text on the "OK" button
         * @param   onOK
         * The function to call when the OK button is clicked. This is optional. 
         * Clicking either OK or Cancel will destroy the dialog anyway, letting you use it for simple alerts
         * @param   cancelText
         * The text on the "Cancel" button
         * @param   onCancel
         * The function to call when "Cancel" is clicked. This is optional.
         * If you leave this argument out, the cancel button simply won't be rendered.
         */
        public function createDialog(textprompt:String, okText:String, onOK:Function = null, cancelText:String = "cancel", onCancel:Function = null):void {
            //Don't display the dialog immediatly, add it to the quuee
            dialogQueue.push(new Dialog(this, textprompt, okText, onOK, cancelText, onCancel)); 
            //Then check the queue
            updateQueue(); 
        }
        private function updateQueue():void
        {
            //If there is no active dialog and one is waiting in the buffer, display it
            if (activeDialog == null && dialogQueue.length > 0) {
                activeDialog = dialogQueue.shift(); //First in First out
                displayDialog(activeDialog);
            }
        }
        public function displayDialog(d:Dialog):void
        {
            visible = true; //Reveal yourself!
            parent.setChildIndex(this, parent.numChildren - 1); //make sure we're on top
            addChild(d);
            //Align to center
            d.x = stage.stageWidth / 2 - d.width / 2;
            d.y = stage.stageHeight / 2 - d.height / 2;
        }
        public function destroyDialog(d:Dialog):void {
            removeChild(d);
            visible = false; //hide ourselves
            activeDialog = null; //destroy the pointer
            updateQueue(); //check if there are more dialogs to be handled
        }
    }
}


