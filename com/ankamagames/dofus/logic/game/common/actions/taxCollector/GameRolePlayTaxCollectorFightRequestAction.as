package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameRolePlayTaxCollectorFightRequestAction extends Object implements Action
   {
      
      public function GameRolePlayTaxCollectorFightRequestAction() {
         super();
      }
      
      public static function create(pTaxCollectorId:uint) : GameRolePlayTaxCollectorFightRequestAction {
         var action:GameRolePlayTaxCollectorFightRequestAction = new GameRolePlayTaxCollectorFightRequestAction();
         action.taxCollectorId = pTaxCollectorId;
         return action;
      }
      
      public var taxCollectorId:uint;
   }
}
