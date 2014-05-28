package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BasicSwitchModeAction extends Object implements Action
   {
      
      public function BasicSwitchModeAction() {
         super();
      }
      
      public static function create(pType:int) : BasicSwitchModeAction {
         var action:BasicSwitchModeAction = new BasicSwitchModeAction();
         action.type = pType;
         return action;
      }
      
      public var type:int;
   }
}
