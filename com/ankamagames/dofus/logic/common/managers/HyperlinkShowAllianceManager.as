package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowAllianceManager extends Object
   {
      
      public function HyperlinkShowAllianceManager() {
         super();
      }
      
      public static function showAlliance(allianceId:uint) : void {
         var afrmsg:AllianceFactsRequestMessage = new AllianceFactsRequestMessage();
         afrmsg.initAllianceFactsRequestMessage(allianceId);
         ConnectionsHandler.getConnection().send(afrmsg);
      }
      
      public static function getAllianceName(allianceId:uint) : String {
         var alliance:AllianceWrapper = AllianceFrame.getInstance().getAllianceById(allianceId);
         if(alliance)
         {
            return "[" + alliance.allianceTag + "]";
         }
         return "[" + I18n.getUiText("ui.common.alliance") + " " + allianceId + "]";
      }
      
      public static function rollOver(pX:int, pY:int, allianceId:uint) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
