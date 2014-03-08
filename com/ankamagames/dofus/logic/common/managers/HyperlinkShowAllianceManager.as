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
      
      public static function showAlliance(param1:uint) : void {
         var _loc2_:AllianceFactsRequestMessage = new AllianceFactsRequestMessage();
         _loc2_.initAllianceFactsRequestMessage(param1);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      public static function getAllianceName(param1:uint) : String {
         var _loc2_:AllianceWrapper = AllianceFrame.getInstance().getAllianceById(param1);
         if(_loc2_)
         {
            return "[" + _loc2_.allianceTag + "]";
         }
         return "[" + I18n.getUiText("ui.common.alliance") + " " + param1 + "]";
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint) : void {
         var _loc4_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc5_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(_loc5_,_loc4_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
