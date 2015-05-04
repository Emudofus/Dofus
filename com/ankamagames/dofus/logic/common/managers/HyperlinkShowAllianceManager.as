package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   
   public class HyperlinkShowAllianceManager extends Object
   {
      
      public function HyperlinkShowAllianceManager()
      {
         super();
      }
      
      public static function getLink(param1:*, param2:String = null, param3:String = null, param4:String = null) : String
      {
         var _loc5_:String = param2?"::" + param2:"";
         var _loc6_:String = param3?",linkColor:" + param3:"";
         var _loc7_:String = param4?",hoverColor:" + param4:"";
         return "{alliance," + param1.allianceId + "," + param1.allianceTag + _loc6_ + _loc7_ + _loc5_ + "}";
      }
      
      public static function showAlliance(... rest) : void
      {
         var _loc2_:AllianceFactsRequestMessage = new AllianceFactsRequestMessage();
         _loc2_.initAllianceFactsRequestMessage(rest[0]);
         ConnectionsHandler.getConnection().send(_loc2_);
      }
      
      public static function getAllianceName(param1:uint, param2:String) : String
      {
         return "[" + param2 + "]";
      }
      
      public static function rollOver(param1:int, param2:int, param3:uint, param4:String) : void
      {
         var _loc5_:Rectangle = new Rectangle(param1,param2,10,10);
         var _loc6_:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.shortcuts.openSocialAlliance"));
         TooltipManager.show(_loc6_,_loc5_,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
