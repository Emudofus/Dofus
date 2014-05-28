package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerRequestAction extends Object implements Action
   {
      
      public function ExchangePlayerRequestAction() {
         super();
      }
      
      public static function create(exchangeType:int, target:uint) : ExchangePlayerRequestAction {
         var a:ExchangePlayerRequestAction = new ExchangePlayerRequestAction();
         a.exchangeType = exchangeType;
         a.target = target;
         return a;
      }
      
      public var exchangeType:int;
      
      public var target:int;
   }
}
