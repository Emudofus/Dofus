package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SpouseRequestAction extends Object implements Action
   {
      
      public function SpouseRequestAction() {
         super();
      }
      
      public static function create() : SpouseRequestAction {
         var _loc1_:SpouseRequestAction = new SpouseRequestAction();
         return _loc1_;
      }
   }
}
