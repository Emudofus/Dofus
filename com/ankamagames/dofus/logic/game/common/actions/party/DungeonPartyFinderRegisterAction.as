package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderRegisterAction extends Object implements Action
   {
      
      public function DungeonPartyFinderRegisterAction() {
         super();
      }
      
      public static function create(dungeons:Array) : DungeonPartyFinderRegisterAction {
         var a:DungeonPartyFinderRegisterAction = new DungeonPartyFinderRegisterAction();
         a.dungeons = dungeons;
         return a;
      }
      
      public var dungeons:Array;
   }
}
