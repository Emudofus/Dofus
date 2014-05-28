package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertAllFromInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertAllFromInvAction() {
         super();
      }
      
      public static function create() : ExchangeObjectTransfertAllFromInvAction {
         return new ExchangeObjectTransfertAllFromInvAction();
      }
   }
}
