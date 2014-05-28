package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.uiRender.UiRenderer;
   
   public class UiRenderEvent extends Event
   {
      
      public function UiRenderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, uiTarget:UiRootContainer = null, uiRenderer:UiRenderer = null) {
         super(type,bubbles,cancelable);
         this._secUiTarget = uiTarget;
         this._uiRenderer = uiRenderer;
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
