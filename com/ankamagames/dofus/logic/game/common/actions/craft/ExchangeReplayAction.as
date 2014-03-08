package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReplayAction extends Object implements Action
   {
      
      public function ExchangeReplayAction() {
         super();
      }
      
      public static function create(param1:int) : ExchangeReplayAction {
         var _loc2_:ExchangeReplayAction = new ExchangeReplayAction();
         _loc2_.count = param1;
         return _loc2_;
      }
      
      public var count:int;
   }
}
