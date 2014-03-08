package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderRegisterAction extends Object implements Action
   {
      
      public function DungeonPartyFinderRegisterAction() {
         super();
      }
      
      public static function create(param1:Array) : DungeonPartyFinderRegisterAction {
         var _loc2_:DungeonPartyFinderRegisterAction = new DungeonPartyFinderRegisterAction();
         _loc2_.dungeons = param1;
         return _loc2_;
      }
      
      public var dungeons:Array;
   }
}
