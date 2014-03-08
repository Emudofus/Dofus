package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import __AS3__.vec.Vector;
   
   public class ExchangeObjectTransfertListToInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertListToInvAction() {
         super();
      }
      
      public static function create(param1:Vector.<uint>) : ExchangeObjectTransfertListToInvAction {
         var _loc2_:ExchangeObjectTransfertListToInvAction = new ExchangeObjectTransfertListToInvAction();
         _loc2_.ids = param1;
         return _loc2_;
      }
      
      public var ids:Vector.<uint>;
   }
}
