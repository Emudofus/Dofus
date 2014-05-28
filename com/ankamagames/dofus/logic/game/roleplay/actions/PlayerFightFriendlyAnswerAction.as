package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightFriendlyAnswerAction extends Object implements Action
   {
      
      public function PlayerFightFriendlyAnswerAction() {
         super();
      }
      
      public static function create(accept:Boolean = true) : PlayerFightFriendlyAnswerAction {
         var o:PlayerFightFriendlyAnswerAction = new PlayerFightFriendlyAnswerAction();
         o.accept = accept;
         return o;
      }
      
      public var accept:Boolean;
   }
}
