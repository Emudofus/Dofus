package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeAcceptAction extends Object implements Action
   {
      
      public function ExchangeAcceptAction() {
         super();
      }
      
      public static function create() : ExchangeAcceptAction {
         var _loc1_:ExchangeAcceptAction = new ExchangeAcceptAction();
         return _loc1_;
      }
   }
}
