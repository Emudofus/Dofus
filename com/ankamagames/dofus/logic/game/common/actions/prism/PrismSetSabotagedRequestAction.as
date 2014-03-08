package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSetSabotagedRequestAction extends Object implements Action
   {
      
      public function PrismSetSabotagedRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : PrismSetSabotagedRequestAction {
         var _loc2_:PrismSetSabotagedRequestAction = new PrismSetSabotagedRequestAction();
         _loc2_.subAreaId = param1;
         return _loc2_;
      }
      
      public var subAreaId:uint;
   }
}
