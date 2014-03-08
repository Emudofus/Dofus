package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class TemplateLoadedEvent extends Event
   {
      
      public function TemplateLoadedEvent(param1:String) {
         super(EVENT_TEMPLATE_LOADED,false,false);
         this._templateUrl = param1;
      }
      
      public static const EVENT_TEMPLATE_LOADED:String = "onTemplateLoadedEvent";
      
      private var _templateUrl:String;
      
      public function get templateUrl() : String {
         return this._templateUrl;
      }
   }
}
