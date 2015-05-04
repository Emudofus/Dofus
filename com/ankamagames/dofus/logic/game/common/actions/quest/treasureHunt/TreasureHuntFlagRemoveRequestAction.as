package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntFlagRemoveRequestAction extends Object implements Action
   {
      
      public function TreasureHuntFlagRemoveRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:int) : TreasureHuntFlagRemoveRequestAction
      {
         var _loc3_:TreasureHuntFlagRemoveRequestAction = new TreasureHuntFlagRemoveRequestAction();
         _loc3_.questType = param1;
         _loc3_.index = param2;
         return _loc3_;
      }
      
      public var questType:int;
      
      public var index:int;
   }
}
