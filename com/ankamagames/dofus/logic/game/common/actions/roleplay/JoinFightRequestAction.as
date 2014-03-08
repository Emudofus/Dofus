package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFightRequestAction extends Object implements Action
   {
      
      public function JoinFightRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : JoinFightRequestAction {
         var _loc3_:JoinFightRequestAction = new JoinFightRequestAction();
         _loc3_.fightId = param1;
         _loc3_.teamLeaderId = param2;
         return _loc3_;
      }
      
      public var fightId:uint;
      
      public var teamLeaderId:uint;
   }
}
