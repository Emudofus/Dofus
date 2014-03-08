package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectMoveKamaAction extends Object implements Action
   {
      
      public function ExchangeObjectMoveKamaAction() {
         super();
      }
      
      public static function create(param1:uint) : ExchangeObjectMoveKamaAction {
         var _loc2_:ExchangeObjectMoveKamaAction = new ExchangeObjectMoveKamaAction();
         _loc2_.kamas = param1;
         return _loc2_;
      }
      
      public var kamas:uint;
   }
}
