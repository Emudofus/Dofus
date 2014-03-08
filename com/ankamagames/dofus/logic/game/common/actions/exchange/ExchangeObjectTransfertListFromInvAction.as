package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import __AS3__.vec.Vector;
   
   public class ExchangeObjectTransfertListFromInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertListFromInvAction() {
         super();
      }
      
      public static function create(param1:Vector.<uint>) : ExchangeObjectTransfertListFromInvAction {
         var _loc2_:ExchangeObjectTransfertListFromInvAction = new ExchangeObjectTransfertListFromInvAction();
         _loc2_.ids = param1;
         return _loc2_;
      }
      
      public var ids:Vector.<uint>;
   }
}
