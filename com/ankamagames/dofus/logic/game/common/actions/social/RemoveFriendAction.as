package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveFriendAction extends Object implements Action
   {
      
      public function RemoveFriendAction() {
         super();
      }
      
      public static function create(param1:int) : RemoveFriendAction {
         var _loc2_:RemoveFriendAction = new RemoveFriendAction();
         _loc2_.accountId = param1;
         return _loc2_;
      }
      
      public var accountId:int;
   }
}
