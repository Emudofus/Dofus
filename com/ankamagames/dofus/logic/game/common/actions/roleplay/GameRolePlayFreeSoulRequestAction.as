package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameRolePlayFreeSoulRequestAction extends Object implements Action
   {
      
      public function GameRolePlayFreeSoulRequestAction() {
         super();
      }
      
      public static function create() : GameRolePlayFreeSoulRequestAction {
         return new GameRolePlayFreeSoulRequestAction();
      }
   }
}
