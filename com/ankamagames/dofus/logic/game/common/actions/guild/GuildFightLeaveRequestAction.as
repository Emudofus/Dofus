package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightLeaveRequestAction extends Object implements Action
   {
      
      public function GuildFightLeaveRequestAction() {
         super();
      }
      
      public static function create(pTaxCollectorId:uint, pCharacterId:uint, pWarning:Boolean=false) : GuildFightLeaveRequestAction {
         var action:GuildFightLeaveRequestAction = new GuildFightLeaveRequestAction();
         action.taxCollectorId = pTaxCollectorId;
         action.characterId = pCharacterId;
         action.warning = pWarning;
         return action;
      }
      
      public var taxCollectorId:uint;
      
      public var characterId:uint;
      
      public var warning:Boolean;
   }
}
