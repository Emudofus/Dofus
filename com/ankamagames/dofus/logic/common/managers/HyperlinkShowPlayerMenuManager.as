package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowPlayerMenuManager extends Object
   {
      
      public function HyperlinkShowPlayerMenuManager() {
         super();
      }
      
      public static function showPlayerMenu(playerName:String, playerId:int=0, timestamp:Number=0, fingerprint:String=null, chan:uint=0) : void {
         var playerInfo:GameRolePlayCharacterInformations = null;
         var _modContextMenu:Object = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if((roleplayEntitiesFrame) && (playerId))
         {
            playerInfo = roleplayEntitiesFrame.getEntityInfos(playerId) as GameRolePlayCharacterInformations;
            if(!playerInfo)
            {
               playerInfo = new GameRolePlayCharacterInformations();
               playerInfo.contextualId = playerId;
               playerInfo.name = playerName;
            }
            _modContextMenu.createContextMenu(MenusFactory.create(playerInfo,null,[
               {
                  "id":playerId,
                  "fingerprint":fingerprint,
                  "timestamp":timestamp,
                  "chan":chan
               }]));
         }
         else
         {
            _modContextMenu.createContextMenu(MenusFactory.create(playerName));
         }
      }
      
      public static function getPlayerName(playerName:String, playerId:int=0, timestamp:Number=0, fingerprint:String=null, chan:uint=0) : String {
         var priority:* = 0;
         switch(chan)
         {
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
            case ChatActivableChannelsEnum.CHANNEL_ADMIN:
               priority = 3;
               break;
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
               priority = 4;
               break;
         }
         ChatAutocompleteNameManager.getInstance().addEntry(playerName,priority);
         return playerName;
      }
      
      public static function rollOverPlayer(pX:int, pY:int, playerName:String, playerId:int=0, timestamp:Number=0, fingerprint:String=null, chan:uint=0) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.player"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
