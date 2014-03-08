package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRefuseAction extends Object implements Action
   {
      
      public function ExchangeRefuseAction() {
         super();
      }
      
      public static function create() : ExchangeRefuseAction {
         var _loc1_:ExchangeRefuseAction = new ExchangeRefuseAction();
         return _loc1_;
      }
   }
}
