package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   
   public class CssEvent extends Event
   {
      
      public function CssEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:ExtendedStyleSheet = null)
      {
         super(param1,param2,param3);
         this._stylesheet = param4;
      }
      
      public static const CSS_PARSED:String = "event_css_parsed";
      
      private var _stylesheet:ExtendedStyleSheet;
      
      public function get stylesheet() : ExtendedStyleSheet
      {
         return this._stylesheet;
      }
   }
}
