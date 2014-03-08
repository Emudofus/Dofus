package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GameFightSpellCastAction extends Object implements Action
   {
      
      public function GameFightSpellCastAction() {
         super();
      }
      
      public static function create(param1:uint) : GameFightSpellCastAction {
         var _loc2_:GameFightSpellCastAction = new GameFightSpellCastAction();
         _loc2_.spellId = param1;
         return _loc2_;
      }
      
      public var spellId:uint;
   }
}
