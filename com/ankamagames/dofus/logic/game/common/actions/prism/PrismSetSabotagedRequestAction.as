package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSetSabotagedRequestAction extends Object implements Action
   {
      
      public function PrismSetSabotagedRequestAction() {
         super();
      }
      
      public static function create(subAreaId:uint) : PrismSetSabotagedRequestAction {
         var action:PrismSetSabotagedRequestAction = new PrismSetSabotagedRequestAction();
         action.subAreaId = subAreaId;
         return action;
      }
      
      public var subAreaId:uint;
   }
}
