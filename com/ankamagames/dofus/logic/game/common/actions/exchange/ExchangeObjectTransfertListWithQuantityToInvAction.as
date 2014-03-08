package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   import __AS3__.vec.Vector;
   
   public class ExchangeObjectTransfertListWithQuantityToInvAction extends Object implements Action
   {
      
      public function ExchangeObjectTransfertListWithQuantityToInvAction() {
         super();
      }
      
      public static function create(pIds:Vector.<uint>, pQtys:Vector.<uint>) : ExchangeObjectTransfertListWithQuantityToInvAction {
         var a:ExchangeObjectTransfertListWithQuantityToInvAction = new ExchangeObjectTransfertListWithQuantityToInvAction();
         a.ids = pIds;
         a.qtys = pQtys;
         return a;
      }
      
      public var ids:Vector.<uint>;
      
      public var qtys:Vector.<uint>;
   }
}
