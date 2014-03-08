package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightTakePlaceRequestAction extends Object implements Action
   {
      
      public function GuildFightTakePlaceRequestAction() {
         super();
      }
      
      public static function create(pTaxCollectorId:uint, replacedCharacterId:uint) : GuildFightTakePlaceRequestAction {
         var action:GuildFightTakePlaceRequestAction = new GuildFightTakePlaceRequestAction();
         action.taxCollectorId = pTaxCollectorId;
         action.replacedCharacterId = replacedCharacterId;
         return action;
      }
      
      public var taxCollectorId:uint;
      
      public var replacedCharacterId:uint;
   }
}
