package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class UiUnloadEvent extends Event
   {
      
      public function UiUnloadEvent(param1:String, param2:String) {
         super(param1,false,false);
         this._name = param2;
      }
      
      public static const UNLOAD_UI_STARTED:String = "unloadUiStarted";
      
      public static const UNLOAD_UI_COMPLETE:String = "unloadUiComplete";
      
      private var _name:String;
      
      public function get name() : String {
         return this._name;
      }
   }
}
