package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerRequestAction extends Object implements Action
   {
      
      public function ExchangePlayerRequestAction() {
         super();
      }
      
      public static function create(param1:int, param2:uint) : ExchangePlayerRequestAction {
         var _loc3_:ExchangePlayerRequestAction = new ExchangePlayerRequestAction();
         _loc3_.exchangeType = param1;
         _loc3_.target = param2;
         return _loc3_;
      }
      
      public var exchangeType:int;
      
      public var target:int;
   }
}
