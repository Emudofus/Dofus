package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendWarningSetAction extends Object implements Action
   {
      
      public function FriendWarningSetAction() {
         super();
      }
      
      public static function create(param1:Boolean) : FriendWarningSetAction {
         var _loc2_:FriendWarningSetAction = new FriendWarningSetAction();
         _loc2_.enable = param1;
         return _loc2_;
      }
      
      public var enable:Boolean;
   }
}
