package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.network.messages.game.guild.GuildFactsRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowGuildManager extends Object
   {
      
      public function HyperlinkShowGuildManager() {
         super();
      }
      
      public static function getLink(pGuild:*, pText:String = null) : String {
         var text:String = pText?"::" + pText:"";
         return "{guild," + pGuild.guildId + "," + escape(pGuild.guildName) + text + "}";
      }
      
      public static function showGuild(guildId:uint, guildName:String) : void {
         var gfrmsg:GuildFactsRequestMessage = new GuildFactsRequestMessage();
         gfrmsg.initGuildFactsRequestMessage(guildId);
         ConnectionsHandler.getConnection().send(gfrmsg);
      }
      
      public static function getGuildName(guildId:uint, guildName:String) : String {
         return "[" + unescape(guildName) + "]";
      }
      
      public static function rollOver(pX:int, pY:int, guildId:uint) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
