package ui
{
   import flash.utils.Timer;
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2hooks.*;
   import flash.events.TimerEvent;
   
   public class TextInfoTooltipUi extends Object
   {
      
      public function TextInfoTooltipUi() {
         super();
      }
      
      private static var _currentCss:String;
      
      private static var _currentCssClass:String = "text";
      
      private var _timerHide:Timer;
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var lbl_content:Object;
      
      public var backgroundCtr:Object;
      
      public function main(oParam:Object = null) : void {
         var lastCss:String = _currentCss;
         var cssInfo:String = oParam.data.css;
         if(cssInfo == null)
         {
            _currentCss = this.uiApi.me().getConstant("css") + "/tooltip_default.css";
         }
         else
         {
            _currentCss = cssInfo;
         }
         if(oParam.data.maxWidth)
         {
            this.lbl_content.multiline = true;
            this.lbl_content.wordWrap = true;
         }
         else
         {
            this.lbl_content.multiline = false;
            this.lbl_content.wordWrap = false;
         }
         if(_currentCss != lastCss)
         {
            this.lbl_content.css = this.uiApi.createUri(_currentCss);
         }
         if(_currentCssClass != oParam.data.cssClass)
         {
            _currentCssClass = oParam.data.cssClass;
            this.lbl_content.cssClass = _currentCssClass;
         }
         this.lbl_content.text = oParam.data.content;
         if(oParam.data.bgCornerRadius)
         {
            this.backgroundCtr.bgCornerRadius = oParam.data.bgCornerRadius;
         }
         this.lbl_content.fullWidth(oParam.data.maxWidth);
         this.backgroundCtr.width = this.lbl_content.textfield.width + 3;
         this.backgroundCtr.height = this.lbl_content.textfield.height + 3;
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
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
