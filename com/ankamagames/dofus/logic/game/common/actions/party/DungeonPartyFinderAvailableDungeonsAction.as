package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderAvailableDungeonsAction extends Object implements Action
   {
      
      public function DungeonPartyFinderAvailableDungeonsAction() {
         super();
      }
      
      public static function create() : DungeonPartyFinderAvailableDungeonsAction {
         var _loc1_:DungeonPartyFinderAvailableDungeonsAction = new DungeonPartyFinderAvailableDungeonsAction();
         return _loc1_;
      }
   }
}
