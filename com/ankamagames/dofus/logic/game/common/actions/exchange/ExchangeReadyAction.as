package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReadyAction extends Object implements Action
   {
      
      public function ExchangeReadyAction() {
         super();
      }
      
      public static function create(pIsReady:Boolean) : ExchangeReadyAction {
         var a:ExchangeReadyAction = new ExchangeReadyAction();
         a.isReady = pIsReady;
         return a;
      }
      
      public var isReady:Boolean;
   }
}
