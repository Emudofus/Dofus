package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class PrismFightSwapRequestAction extends Object implements Action
   {
         

      public function PrismFightSwapRequestAction() {
         super();
      }

      public static function create(targetId:uint) : PrismFightSwapRequestAction {
         var action:PrismFightSwapRequestAction = new PrismFightSwapRequestAction();
         action.targetId=targetId;
         return action;
      }

      public var targetId:uint;
   }

}