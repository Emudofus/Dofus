package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntGiveUpRequestAction extends Object implements Action
   {
      
      public function TreasureHuntGiveUpRequestAction() {
         super();
      }
      
      public static function create(questType:int) : TreasureHuntGiveUpRequestAction {
         var action:TreasureHuntGiveUpRequestAction = new TreasureHuntGiveUpRequestAction();
         action.questType = questType;
         return action;
      }
      
      public var questType:int;
   }
}
