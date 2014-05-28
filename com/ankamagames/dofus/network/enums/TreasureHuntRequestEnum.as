package com.ankamagames.dofus.network.enums
{
   public class TreasureHuntRequestEnum extends Object
   {
      
      public function TreasureHuntRequestEnum() {
         super();
      }
      
      public static const TREASURE_HUNT_ERROR_UNDEFINED:uint = 0;
      
      public static const TREASURE_HUNT_ERROR_NO_QUEST_FOUND:uint = 2;
      
      public static const TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST:uint = 3;
      
      public static const TREASURE_HUNT_OK:uint = 1;
   }
}
