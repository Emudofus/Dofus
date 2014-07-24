package ui
{
   import d2api.UiApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   
   public class DelayedClosurePopup extends Object
   {
      
      public function DelayedClosurePopup() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var popCtr:GraphicContainer;
      
      public var lbl_content:Label;
      
      private var _timer:Timer;
      
      public function main(param:Object) : void {
         if(!param)
         {
            throw new Error("Can\'t load popup without properties.");
         }
         else
         {
            this.lbl_content.text = param.content;
            if(param.marginTop)
            {
               this.popCtr.y = param.marginTop;
            }
            this._timer = new Timer(param.delay);
            this._timer.addEventListener(TimerEvent.TIMER,this.closeMe);
            this._timer.start();
            this.uiApi.me().render();
            return;
         }
      }
      
      private function closeMe(pEvt:TimerEvent) : void {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.closeMe);
         this._timer = null;
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function unload() : void {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.closeMe);
            this._timer = null;
         }
      }
   }
}
