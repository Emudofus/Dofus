package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import __AS3__.vec.Vector;
   
   public class ExchangeObjectTransfertListFromInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertListFromInvAction() {
         super();
      }
      
      public static function create(pIds:Vector.<uint>) : ExchangeObjectTransfertListFromInvAction {
         var a:ExchangeObjectTransfertListFromInvAction = new ExchangeObjectTransfertListFromInvAction();
         a.ids = pIds;
         return a;
      }
      
      public var ids:Vector.<uint>;
   }
}
