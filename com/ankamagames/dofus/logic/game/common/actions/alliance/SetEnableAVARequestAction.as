package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SetEnableAVARequestAction extends Object implements Action
   {
      
      public function SetEnableAVARequestAction() {
         super();
      }
      
      public static function create(enable:Boolean) : SetEnableAVARequestAction {
         var action:SetEnableAVARequestAction = new SetEnableAVARequestAction();
         action.enable = enable;
         return action;
      }
      
      public var enable:Boolean;
   }
}
