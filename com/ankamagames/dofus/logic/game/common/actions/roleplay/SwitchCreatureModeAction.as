package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SwitchCreatureModeAction extends Object implements Action
   {
      
      public function SwitchCreatureModeAction() {
         super();
      }
      
      public static function create(param1:Boolean=false) : SwitchCreatureModeAction {
         var _loc2_:SwitchCreatureModeAction = new SwitchCreatureModeAction();
         _loc2_.isActivated = param1;
         return _loc2_;
      }
      
      public var isActivated:Boolean;
   }
}
