package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   
   public class CssEvent extends Event
   {
      
      public function CssEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, stylesheet:ExtendedStyleSheet=null) {
         super(type,bubbles,cancelable);
         this._stylesheet = stylesheet;
      }
      
      public static const CSS_PARSED:String = "event_css_parsed";
      
      private var _stylesheet:ExtendedStyleSheet;
      
      public function get stylesheet() : ExtendedStyleSheet {
         return this._stylesheet;
      }
   }
}
