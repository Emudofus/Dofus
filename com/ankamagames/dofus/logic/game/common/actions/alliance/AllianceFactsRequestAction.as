package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceFactsRequestAction extends Object implements Action
   {
      
      public function AllianceFactsRequestAction() {
         super();
      }
      
      public static function create(allianceId:uint) : AllianceFactsRequestAction {
         var action:AllianceFactsRequestAction = new AllianceFactsRequestAction();
         action.allianceId = allianceId;
         return action;
      }
      
      public var allianceId:uint;
   }
}
