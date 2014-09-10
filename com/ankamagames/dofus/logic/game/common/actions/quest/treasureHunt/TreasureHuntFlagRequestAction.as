package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntFlagRequestAction extends Object implements Action
   {
      
      public function TreasureHuntFlagRequestAction() {
         super();
      }
      
      public static function create(questType:int, index:int) : TreasureHuntFlagRequestAction {
         var action:TreasureHuntFlagRequestAction = new TreasureHuntFlagRequestAction();
         action.questType = questType;
         action.index = index;
         return action;
      }
      
      public var questType:int;
      
      public var index:int;
   }
}
