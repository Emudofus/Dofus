package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MemberWarningSetAction extends Object implements Action
   {
      
      public function MemberWarningSetAction() {
         super();
      }
      
      public static function create(enable:Boolean) : MemberWarningSetAction {
         var a:MemberWarningSetAction = new MemberWarningSetAction();
         a.enable = enable;
         return a;
      }
      
      public var enable:Boolean;
   }
}
