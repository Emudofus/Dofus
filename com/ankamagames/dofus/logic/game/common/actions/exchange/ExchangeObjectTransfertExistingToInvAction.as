package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertExistingToInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertExistingToInvAction() {
         super();
      }
      
      public static function create() : ExchangeObjectTransfertExistingToInvAction {
         return new ExchangeObjectTransfertExistingToInvAction();
      }
   }
}
