package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFightRequestAction extends Object implements Action
   {
      
      public function JoinFightRequestAction() {
         super();
      }
      
      public static function create(fightId:uint, teamLeaderId:uint) : JoinFightRequestAction {
         var a:JoinFightRequestAction = new JoinFightRequestAction();
         a.fightId = fightId;
         a.teamLeaderId = teamLeaderId;
         return a;
      }
      
      public var fightId:uint;
      
      public var teamLeaderId:uint;
   }
}
