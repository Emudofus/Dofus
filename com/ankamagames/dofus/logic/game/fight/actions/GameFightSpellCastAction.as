package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpellCastAction extends Object implements Action
   {
      
      public function GameFightSpellCastAction() {
         super();
      }
      
      public static function create(spellId:uint) : GameFightSpellCastAction {
         var a:GameFightSpellCastAction = new GameFightSpellCastAction();
         a.spellId = spellId;
         return a;
      }
      
      public var spellId:uint;
   }
}
