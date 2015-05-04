package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectTransfertExistingFromInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertExistingFromInvAction()
      {
         super();
      }
      
      public static function create(param1:Boolean = false) : ExchangeObjectTransfertExistingFromInvAction
      {
         return new ExchangeObjectTransfertExistingFromInvAction();
      }
   }
}
