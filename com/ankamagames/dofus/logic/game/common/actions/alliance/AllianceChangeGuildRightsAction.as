package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceChangeGuildRightsAction extends Object implements Action
   {
      
      public function AllianceChangeGuildRightsAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : AllianceChangeGuildRightsAction {
         var _loc3_:AllianceChangeGuildRightsAction = new AllianceChangeGuildRightsAction();
         _loc3_.guildId = param1;
         _loc3_.rights = param2;
         return _loc3_;
      }
      
      public var guildId:uint;
      
      public var rights:uint;
   }
}
