package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.UiData;
   
   public class UiRenderAskEvent extends Event
   {
      
      public function UiRenderAskEvent(name:String, uiData:UiData) {
         super(UI_RENDER_ASK,false,false);
         this._uiData = uiData;
         this._name = name;
      }
      
      public static const UI_RENDER_ASK:String = "UiRenderAsk";
      
      private var _uiData:UiData;
      
      private var _name:String;
      
      public function get name() : String {
         return this._name;
      }
      
      public function get uiData() : UiData {
         return this._uiData;
      }
   }
}
