package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildFightTakePlaceRequestAction extends Object implements Action
   {
      
      public function GuildFightTakePlaceRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : GuildFightTakePlaceRequestAction {
         var _loc3_:GuildFightTakePlaceRequestAction = new GuildFightTakePlaceRequestAction();
         _loc3_.taxCollectorId = param1;
         _loc3_.replacedCharacterId = param2;
         return _loc3_;
      }
      
      public var taxCollectorId:uint;
      
      public var replacedCharacterId:uint;
   }
}
