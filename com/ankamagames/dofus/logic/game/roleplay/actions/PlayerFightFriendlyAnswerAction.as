package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightFriendlyAnswerAction extends Object implements Action
   {
      
      public function PlayerFightFriendlyAnswerAction() {
         super();
      }
      
      public static function create(param1:Boolean=true) : PlayerFightFriendlyAnswerAction {
         var _loc2_:PlayerFightFriendlyAnswerAction = new PlayerFightFriendlyAnswerAction();
         _loc2_.accept = param1;
         return _loc2_;
      }
      
      public var accept:Boolean;
   }
}
