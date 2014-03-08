package com.ankamagames.jerakine.lua
{
   import flash.events.Event;
   
   public class LuaPlayerEvent extends Event
   {
      
      public function LuaPlayerEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const PLAY_SUCCESS:String = "LuaPlayerEvent.PLAY_SUCCESS";
      
      public static const PLAY_ERROR:String = "LuaPlayerEvent.PLAY_ERROR";
      
      public static const PLAY_COMPLETE:String = "LuaPlayerEvent.PLAY_COMPLETE";
      
      public var stackTrace:String;
   }
}
