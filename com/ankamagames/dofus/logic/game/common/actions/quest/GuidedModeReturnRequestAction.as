package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuidedModeReturnRequestAction extends Object implements Action
   {
      
      public function GuidedModeReturnRequestAction()
      {
         super();
      }
      
      public static function create() : GuidedModeReturnRequestAction
      {
         return new GuidedModeReturnRequestAction();
      }
   }
}
