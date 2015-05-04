package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TreasureHuntLegendaryRequestAction extends Object implements Action
   {
      
      public function TreasureHuntLegendaryRequestAction()
      {
         super();
      }
      
      public static function create(param1:int) : TreasureHuntLegendaryRequestAction
      {
         var _loc2_:TreasureHuntLegendaryRequestAction = new TreasureHuntLegendaryRequestAction();
         _loc2_.legendaryId = param1;
         return _loc2_;
      }
      
      public var legendaryId:int;
   }
}
