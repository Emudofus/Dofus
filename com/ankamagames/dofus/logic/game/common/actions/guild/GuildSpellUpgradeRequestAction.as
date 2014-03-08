package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSpellUpgradeRequestAction extends Object implements Action
   {
      
      public function GuildSpellUpgradeRequestAction() {
         super();
      }
      
      public static function create(pSpellId:uint) : GuildSpellUpgradeRequestAction {
         var action:GuildSpellUpgradeRequestAction = new GuildSpellUpgradeRequestAction();
         action.spellId = pSpellId;
         return action;
      }
      
      public var spellId:uint;
   }
}
