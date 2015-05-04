package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismModuleExchangeRequestAction extends Object implements Action
   {
      
      public function PrismModuleExchangeRequestAction()
      {
         super();
      }
      
      public static function create() : PrismModuleExchangeRequestAction
      {
         var _loc1_:PrismModuleExchangeRequestAction = new PrismModuleExchangeRequestAction();
         return _loc1_;
      }
   }
}
