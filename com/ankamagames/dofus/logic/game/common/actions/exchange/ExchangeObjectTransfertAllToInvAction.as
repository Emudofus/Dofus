package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertAllToInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertAllToInvAction() {
         super();
      }
      
      public static function create() : ExchangeObjectTransfertAllToInvAction {
         return new ExchangeObjectTransfertAllToInvAction();
      }
   }
}
