package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntRequestAction extends Object implements Action
   {
      
      public function TreasureHuntRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:int) : TreasureHuntRequestAction
      {
         var _loc3_:TreasureHuntRequestAction = new TreasureHuntRequestAction();
         _loc3_.level = param1;
         _loc3_.questType = param2;
         return _loc3_;
      }
      
      public var level:int;
      
      public var questType:int;
   }
}
