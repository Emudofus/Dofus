package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinAsSpectatorRequestAction extends Object implements Action
   {
      
      public function JoinAsSpectatorRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : JoinAsSpectatorRequestAction {
         var _loc2_:JoinAsSpectatorRequestAction = new JoinAsSpectatorRequestAction();
         _loc2_.fightId = param1;
         return _loc2_;
      }
      
      public var fightId:uint;
   }
}
