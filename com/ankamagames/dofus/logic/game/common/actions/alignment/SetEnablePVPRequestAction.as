package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SetEnablePVPRequestAction extends Object implements Action
   {
      
      public function SetEnablePVPRequestAction() {
         super();
      }
      
      public static function create(enable:Boolean) : SetEnablePVPRequestAction {
         var action:SetEnablePVPRequestAction = new SetEnablePVPRequestAction();
         action.enable = enable;
         return action;
      }
      
      public var enable:Boolean;
   }
}
