package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismUseRequestAction extends Object implements Action
   {
      
      public function PrismUseRequestAction() {
         super();
      }
      
      public static function create() : PrismUseRequestAction {
         var action:PrismUseRequestAction = new PrismUseRequestAction();
         return action;
      }
   }
}
