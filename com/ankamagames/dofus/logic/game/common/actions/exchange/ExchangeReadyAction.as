package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReadyAction extends Object implements Action
   {
      
      public function ExchangeReadyAction() {
         super();
      }
      
      public static function create(param1:Boolean) : ExchangeReadyAction {
         var _loc2_:ExchangeReadyAction = new ExchangeReadyAction();
         _loc2_.isReady = param1;
         return _loc2_;
      }
      
      public var isReady:Boolean;
   }
}
