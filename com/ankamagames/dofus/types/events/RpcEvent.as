package com.ankamagames.dofus.types.events
{
   import flash.events.Event;
   
   public class RpcEvent extends Event
   {
      
      public function RpcEvent(param1:String, param2:String, param3:Object=null) {
         super(param1,false,false);
         this._result = param3;
         this._method = param2;
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
