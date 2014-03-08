package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpectatePlayerRequestAction extends Object implements Action
   {
      
      public function GameFightSpectatePlayerRequestAction() {
         super();
      }
      
      public static function create(playerId:uint) : GameFightSpectatePlayerRequestAction {
         var a:GameFightSpectatePlayerRequestAction = new GameFightSpectatePlayerRequestAction();
         a.playerId = playerId;
         return a;
      }
      
      public var playerId:uint;
   }
}
