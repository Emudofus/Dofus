package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WarnOnHardcoreDeathAction extends Object implements Action
   {
      
      public function WarnOnHardcoreDeathAction() {
         super();
      }
      
      public static function create(enable:Boolean) : WarnOnHardcoreDeathAction {
         var a:WarnOnHardcoreDeathAction = new WarnOnHardcoreDeathAction();
         a.enable = enable;
         return a;
      }
      
      public var enable:Boolean;
   }
}
