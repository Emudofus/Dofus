package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import __AS3__.vec.Vector;
   
   public class ExchangeObjectTransfertListWithQuantityToInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertListWithQuantityToInvAction() {
         super();
      }
      
      public static function create(param1:Vector.<uint>, param2:Vector.<uint>) : ExchangeObjectTransfertListWithQuantityToInvAction {
         var _loc3_:ExchangeObjectTransfertListWithQuantityToInvAction = new ExchangeObjectTransfertListWithQuantityToInvAction();
         _loc3_.ids = param1;
         _loc3_.qtys = param2;
         return _loc3_;
      }
      
      public var ids:Vector.<uint>;
      
      public var qtys:Vector.<uint>;
   }
}
