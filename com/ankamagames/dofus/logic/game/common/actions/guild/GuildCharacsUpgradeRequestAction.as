package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildCharacsUpgradeRequestAction extends Object implements Action
   {
      
      public function GuildCharacsUpgradeRequestAction() {
         super();
      }
      
      public static function create(param1:uint) : GuildCharacsUpgradeRequestAction {
         var _loc2_:GuildCharacsUpgradeRequestAction = new GuildCharacsUpgradeRequestAction();
         _loc2_.charaTypeTarget = param1;
         return _loc2_;
      }
      
      public var charaTypeTarget:uint;
   }
}
