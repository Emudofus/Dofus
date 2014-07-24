package ui
{
   import flash.utils.Timer;
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2hooks.*;
   import flash.events.TimerEvent;
   
   public class TooltipUi extends Object
   {
      
      public function TooltipUi() {
         super();
      }
      
      private var _timerHide:Timer;
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public function main(oParam:Object = null) : void {
         if(oParam.zoom > 1)
         {
            this.uiApi.me().scale = oParam.zoom;
         }
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset,false,-1,oParam.alwaysDisplayed);
         if(oParam.autoHide)
         {
            this._timerHide = new Timer(2500);
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.start();
         }
      }
      
      private function onTimer(e:TimerEvent) : void {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this.uiApi.hideTooltip(this.uiApi.me().name);
      }
      
      public function unload() : void {
         if(this._timerHide)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.stop();
            this._timerHide = null;
         }
      }
   }
}
