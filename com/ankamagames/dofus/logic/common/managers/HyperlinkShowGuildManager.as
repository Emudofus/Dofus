package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.network.messages.game.guild.GuildFactsRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowGuildManager extends Object
   {
      
      public function HyperlinkShowGuildManager() {
         super();
      }
      
      public static function showGuild(param1:uint) : void {
         var _loc2_:GuildFactsRequestMessage = new GuildFactsRequestMessage();
         _loc2_.initGuildFactsRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      public static function getGuildName(param1:uint) : String {
         var _loc2_:GuildFactSheetWrapper = SocialFrame.getInstance().getGuildById(param1);
         if(_loc2_)
         {
            return "[" + _loc2_.guildName + "]";
         }
         return "[" + I18n.getUiText("ui.common.guild") + " " + param1 + "]";
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint) : void {
         var _loc4_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc5_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(_loc5_,_loc4_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
