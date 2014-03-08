package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendsListRequestAction extends Object implements Action
   {
      
      public function FriendsListRequestAction() {
         super();
      }
      
      public static function create() : FriendsListRequestAction {
         var a:FriendsListRequestAction = new FriendsListRequestAction();
         return a;
      }
   }
}
