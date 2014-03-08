package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SwitchCreatureModeAction extends Object implements Action
   {
      
      public function SwitchCreatureModeAction() {
         super();
      }
      
      public static function create(pActivated:Boolean=false) : SwitchCreatureModeAction {
         var a:SwitchCreatureModeAction = new SwitchCreatureModeAction();
         a.isActivated = pActivated;
         return a;
      }
      
      public var isActivated:Boolean;
   }
}
