package com.ankamagames.tiphon.events
{
   import flash.events.Event;
   
   public class SwlEvent extends Event
   {
      
      public function SwlEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false) {
         super(param1,param3,param4);
         this._url = param2;
      }
      
      public static const SWL_LOADED:String = "onSwfLoaded";
      
      private var _url:String;
      
      override public function clone() : Event {
         return new SwlEvent(type,this.url,bubbles,cancelable);
      }
      
      public function get url() : String {
         return this._url;
      }
   }
}
