package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntFlagRequestAction extends Object implements Action
   {
      
      public function TreasureHuntFlagRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:int) : TreasureHuntFlagRequestAction
      {
         var _loc3_:TreasureHuntFlagRequestAction = new TreasureHuntFlagRequestAction();
         _loc3_.questType = param1;
         _loc3_.index = param2;
         return _loc3_;
      }
      
      public var questType:int;
      
      public var index:int;
   }
}
