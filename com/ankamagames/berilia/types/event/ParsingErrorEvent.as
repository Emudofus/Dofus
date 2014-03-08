package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class ParsingErrorEvent extends Event
   {
      
      public function ParsingErrorEvent(param1:String, param2:String) {
         super(ERROR);
         this._url = param1;
         this._msg = param2;
      }
      
      public static const ERROR:String = "ParsingErrorEvent_Error";
      
      private var _url:String;
      
      private var _msg:String;
      
      public function get url() : String {
         return this._url;
      }
      
      public function get msg() : String {
         return this._msg;
      }
   }
}
