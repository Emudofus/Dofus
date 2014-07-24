package ui
{
   import d2api.SystemApi;
   import d2api.TooltipApi;
   import d2api.UiApi;
   import flash.utils.Timer;
   import d2components.GraphicContainer;
   import d2components.Label;
   import flash.events.TimerEvent;
   
   public class EffectsListDurationTooltipUi extends Object
   {
      
      public function EffectsListDurationTooltipUi() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      private var _skip:Boolean = true;
      
      private var _timerHide:Timer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_text:Label;
      
      public function main(oParam:Object = null) : void {
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function onRollOver(target:Object) : void {
      }
      
      public function onRollOut(target:Object) : void {
      }
      
      private function onTimer(e:TimerEvent) : void {
      }
      
      public function unload() : void {
      }
   }
}
