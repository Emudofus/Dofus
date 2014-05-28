package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaRegisterAction extends Object implements Action
   {
      
      public function ArenaRegisterAction() {
         super();
      }
      
      public static function create(fightTypeId:uint) : ArenaRegisterAction {
         var a:ArenaRegisterAction = new ArenaRegisterAction();
         a.fightTypeId = fightTypeId;
         return a;
      }
      
      public var fightTypeId:uint;
   }
}
