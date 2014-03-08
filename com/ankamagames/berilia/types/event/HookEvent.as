package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.Hook;
   
   public class HookEvent extends Event
   {
      
      public function HookEvent(param1:String, param2:Hook) {
         super(param1,false,false);
         this._hook = param2;
      }
      
      public static const DISPATCHED:String = "hooDispatched";
      
      private var _hook:Hook;
      
      public function get hook() : Hook {
         return this._hook;
      }
   }
}
