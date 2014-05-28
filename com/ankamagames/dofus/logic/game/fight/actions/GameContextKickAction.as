package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameContextKickAction extends Object implements Action
   {
      
      public function GameContextKickAction() {
         super();
      }
      
      public static function create(targetId:uint) : GameContextKickAction {
         var a:GameContextKickAction = new GameContextKickAction();
         a.targetId = targetId;
         return a;
      }
      
      public var targetId:uint;
   }
}
