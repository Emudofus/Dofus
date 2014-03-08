package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.uiRender.UiRenderer;
   
   public class UiRenderEvent extends Event
   {
      
      public function UiRenderEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:UiRootContainer=null, param5:UiRenderer=null) {
         super(param1,param2,param3);
         this._secUiTarget = param4;
         this._uiRenderer = param5;
      }
      
      public static var UIRenderComplete:String = "UIRenderComplete";
      
      public static var UIRenderFailed:String = "UIRenderFailed";
      
      private var _secUiTarget:UiRootContainer;
      
      private var _uiRenderer:UiRenderer;
      
      public function get uiTarget() : UiRootContainer {
         return this._secUiTarget;
      }
      
      public function get uiRenderer() : UiRenderer {
         return this._uiRenderer;
      }
      
      override public function clone() : Event {
         return new UiRenderEvent(type,bubbles,cancelable,this.uiTarget,this.uiRenderer);
      }
   }
}
