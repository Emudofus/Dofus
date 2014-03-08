package com.ankamagames.jerakine.utils.display.spellZone
{
   import flash.events.Event;
   
   public class SpellZoneEvent extends Event
   {
      
      public function SpellZoneEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const CELL_ROLLOVER:String = "cell_rollover";
      
      public static const CELL_ROLLOUT:String = "cell_rollout";
      
      public var cell:SpellZoneCell;
   }
}
