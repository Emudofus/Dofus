package ui
{
   import d2api.TooltipApi;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2components.Texture;
   import d2hooks.*;
   import d2data.DelayedActionItem;
   import flash.utils.getTimer;
   
   public class DelayedActionTooltipUi extends Object
   {
      
      public function DelayedActionTooltipUi() {
         super();
      }
      
      public var tooltipApi:TooltipApi;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var delayedActionBackground:Texture;
      
      private var _currentTargetTs:Number;
      
      private var _targetTs:Number;
      
      private var _lastTs:Number;
      
      public function main(oParam:Object = null) : void {
         if(oParam.zoom > 1)
         {
            this.uiApi.me().scaleX = oParam.zoom;
            this.uiApi.me().scaleY = oParam.zoom;
         }
         this._currentTargetTs = 0;
         this._targetTs = DelayedActionItem(oParam.data).endTime;
         this._lastTs = getTimer();
         this.sysApi.addEventListener(this.updateProgress,"delayed item use tooltip");
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      private function updateProgress() : void {
         this._currentTargetTs = this._currentTargetTs + (getTimer() - this._lastTs);
         this._lastTs = getTimer();
         var prc:uint = Math.min(100,Math.ceil(this._currentTargetTs / this._targetTs * 100));
         this.delayedActionBackground.gotoAndStop = prc;
      }
      
      public function unload() : void {
         this.sysApi.removeEventListener(this.updateProgress);
      }
   }
}
