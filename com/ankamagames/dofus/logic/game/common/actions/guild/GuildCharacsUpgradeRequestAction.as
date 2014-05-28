package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildCharacsUpgradeRequestAction extends Object implements Action
   {
      
      public function GuildCharacsUpgradeRequestAction() {
         super();
      }
      
      public static function create(pCharaTypeTarget:uint) : GuildCharacsUpgradeRequestAction {
         var action:GuildCharacsUpgradeRequestAction = new GuildCharacsUpgradeRequestAction();
         action.charaTypeTarget = pCharaTypeTarget;
         return action;
      }
      
      public var charaTypeTarget:uint;
   }
}
