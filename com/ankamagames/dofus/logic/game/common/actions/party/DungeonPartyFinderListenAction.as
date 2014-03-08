package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderListenAction extends Object implements Action
   {
      
      public function DungeonPartyFinderListenAction() {
         super();
      }
      
      public static function create(param1:uint) : DungeonPartyFinderListenAction {
         var _loc2_:DungeonPartyFinderListenAction = new DungeonPartyFinderListenAction();
         _loc2_.dungeonId = param1;
         return _loc2_;
      }
      
      public var dungeonId:uint;
   }
}
