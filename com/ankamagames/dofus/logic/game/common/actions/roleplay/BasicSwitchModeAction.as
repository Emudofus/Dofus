package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BasicSwitchModeAction extends Object implements Action
   {
      
      public function BasicSwitchModeAction() {
         super();
      }
      
      public static function create(param1:int) : BasicSwitchModeAction {
         var _loc2_:BasicSwitchModeAction = new BasicSwitchModeAction();
         _loc2_.type = param1;
         return _loc2_;
      }
      
      public var type:int;
   }
}
