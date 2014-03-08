package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderListenAction extends Object implements Action
   {
      
      public function DungeonPartyFinderListenAction() {
         super();
      }
      
      public static function create(dungeonId:uint) : DungeonPartyFinderListenAction {
         var a:DungeonPartyFinderListenAction = new DungeonPartyFinderListenAction();
         a.dungeonId = dungeonId;
         return a;
      }
      
      public var dungeonId:uint;
   }
}
