package com.ankamagames.dofus.types.events
{
   import flash.events.Event;
   
   public class RpcEvent extends Event
   {
      
      public function RpcEvent(type:String, method:String, result:Object = null) {
         super(type,false,false);
         this._result = result;
         this._method = method;
      }
      
      public static const EVENT_DATA:String = "RpcEvent_data";
      
      public static const EVENT_ERROR:String = "RpcEvent_error";
      
      private var _result:Object;
      
      private var _method:String;
      
      public function get result() : Object {
         return this._result;
      }
      
      public function get method() : String {
         return this._method;
      }
   }
}
