package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GetPartsListAction extends Object implements Action
   {
      
      public function GetPartsListAction() {
         super();
      }
      
      public static function create() : GetPartsListAction {
         var _loc1_:GetPartsListAction = new GetPartsListAction();
         return _loc1_;
      }
   }
}
