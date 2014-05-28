package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class PrismWorldInformationRequestAction extends Object implements Action
   {
         

      public function PrismWorldInformationRequestAction() {
         super();
      }

      public static function create(join:Boolean) : PrismWorldInformationRequestAction {
         var action:PrismWorldInformationRequestAction = new PrismWorldInformationRequestAction();
         action.join=join;
         return action;
      }

      public var join:Boolean;
   }

}