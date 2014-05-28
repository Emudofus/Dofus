package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   
   public class HyperlinkShowAchievementManager extends Object
   {
      
      public function HyperlinkShowAchievementManager() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static var _achList:Array;
      
      private static var _achId:uint = 0;
      
      public static function showAchievement(achId:uint) : void {
         var data:Object = new Object();
         data.achievementId = achId;
         data.forceOpen = true;
         KernelEventsManager.getInstance().processCallback(HookList.OpenBook,"achievementTab",data);
      }
      
      public static function addAchievement(achId:uint) : String {
         var code:String = null;
         var ach:Achievement = Achievement.getAchievementById(achId);
         if(ach)
         {
            _achList[_achId] = ach;
            code = "{chatachievement," + achId + "::[" + ach.name + "]}";
            _achId++;
            return code;
         }
         return "[null]";
      }
      
      public static function getAchievementName(achId:uint) : String {
         var ach:Achievement = Achievement.getAchievementById(achId);
         if(ach)
         {
            return "[" + ach.name + "]";
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, achId:uint = 0) : void {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.achievement"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
