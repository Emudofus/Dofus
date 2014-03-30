package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntRequestAction extends Object implements Action
   {
      
      public function TreasureHuntRequestAction() {
         super();
      }
      
      public static function create(level:int, questType:int) : TreasureHuntRequestAction {
         var action:TreasureHuntRequestAction = new TreasureHuntRequestAction();
         action.level = level;
         action.questType = questType;
         return action;
      }
      
      public var level:int;
      
      public var questType:int;
   }
}
