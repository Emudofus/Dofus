package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeRefuseAction extends Object implements Action
   {
      
      public function ExchangeRefuseAction() {
         super();
      }
      
      public static function create() : ExchangeRefuseAction {
         var a:ExchangeRefuseAction = new ExchangeRefuseAction();
         return a;
      }
   }
}
