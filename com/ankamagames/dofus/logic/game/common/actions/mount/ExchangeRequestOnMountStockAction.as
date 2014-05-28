package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRequestOnMountStockAction extends Object implements Action
   {
      
      public function ExchangeRequestOnMountStockAction() {
         super();
      }
      
      public static function create() : ExchangeRequestOnMountStockAction {
         return new ExchangeRequestOnMountStockAction();
      }
   }
}
