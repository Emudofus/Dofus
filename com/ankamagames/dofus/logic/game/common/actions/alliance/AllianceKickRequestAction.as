package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceKickRequestAction extends Object implements Action
   {
      
      public function AllianceKickRequestAction() {
         super();
      }
      
      public static function create(pGuildId:uint) : AllianceKickRequestAction {
         var action:AllianceKickRequestAction = new AllianceKickRequestAction();
         action.guildId = pGuildId;
         return action;
      }
      
      public var guildId:uint;
   }
}
