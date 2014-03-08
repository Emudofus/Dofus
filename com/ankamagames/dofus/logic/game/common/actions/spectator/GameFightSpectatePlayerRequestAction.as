package com.ankamagames.dofus.logic.game.common.actions.spectator
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpectatePlayerRequestAction extends Object implements Action
   {
      
      public function GameFightSpectatePlayerRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : GameFightSpectatePlayerRequestAction {
         var _loc2_:GameFightSpectatePlayerRequestAction = new GameFightSpectatePlayerRequestAction();
         _loc2_.playerId = param1;
         return _loc2_;
      }
      
      public var playerId:uint;
   }
}
