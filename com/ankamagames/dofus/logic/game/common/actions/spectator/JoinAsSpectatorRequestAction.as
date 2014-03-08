package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinAsSpectatorRequestAction extends Object implements Action
   {
      
      public function JoinAsSpectatorRequestAction() {
         super();
      }
      
      public static function create(fightId:uint) : JoinAsSpectatorRequestAction {
         var a:JoinAsSpectatorRequestAction = new JoinAsSpectatorRequestAction();
         a.fightId = fightId;
         return a;
      }
      
      public var fightId:uint;
   }
}
