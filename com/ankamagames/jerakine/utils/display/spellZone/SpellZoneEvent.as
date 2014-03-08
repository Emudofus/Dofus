package com.ankamagames.jerakine.utils.display.spellZone
{
   import flash.events.Event;
   
   public class SpellZoneEvent extends Event
   {
      
      public function SpellZoneEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }
      
      public static const CELL_ROLLOVER:String = "cell_rollover";
      
      public static const CELL_ROLLOUT:String = "cell_rollout";
      
      public var cell:SpellZoneCell;
   }
}
