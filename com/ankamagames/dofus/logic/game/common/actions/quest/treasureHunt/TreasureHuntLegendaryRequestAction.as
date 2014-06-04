package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntLegendaryRequestAction extends Object implements Action
   {
      
      public function TreasureHuntLegendaryRequestAction() {
         super();
      }
      
      public static function create(legendaryId:int) : TreasureHuntLegendaryRequestAction {
         var action:TreasureHuntLegendaryRequestAction = new TreasureHuntLegendaryRequestAction();
         action.legendaryId = legendaryId;
         return action;
      }
      
      public var legendaryId:int;
   }
}
