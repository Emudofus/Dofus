package com.ankamagames.dofus.types
{
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationPositionEnum;


   public dynamic class DofusOptions extends OptionManager
   {
         

      public function DofusOptions() {
         super("dofus");
         add("optimize",false);
         add("cacheMapEnabled",true);
         add("optimizeMultiAccount",true);
         add("fullScreen",false);
         add("showEveryMonsters",false);
         add("turnPicture",true);
         add("mapCoordinates",true);
         add("showEntityInfos",true);
         add("showMovementRange",false);
         add("showLineOfSight",true);
         add("remindTurn",true);
         add("showGlowOverTarget",true);
         add("confirmItemDrop",true);
         add("switchUiSkin","black");
         add("allowBannerShortcuts",true);
         add("dofusQuality",AirScanner.isStreamingVersion()?2:1);
         add("askForQualitySelection",!AirScanner.isStreamingVersion());
         add("showNotifications",true);
         add("showUsedPaPm",false);
         add("largeTooltipDelay",600);
         add("displayTooltips",true);
         add("allowSpellEffects",true);
         add("allowHitAnim",true);
         add("legalAgreementEula","fr#0");
         add("legalAgreementTou","fr#0");
         add("legalAgreementModsTou","fr#0");
         add("allowLog",(!(BuildInfos.BUILD_TYPE==BuildTypeEnum.RELEASE))&&(!AirScanner.isStreamingVersion()));
         add("flashQuality",2);
         add("cellSelectionOnly",false);
         add("orderFighters",false);
         add("showAlignmentWings",false);
         add("showTacticMode",false);
         add("showMovementDistance",false);
         add("hideDeadFighters",true);
         add("hideSummonedFighters",false);
         add("mapFilters",478);
         add("showLogPvDetails",true);
         add("notificationsAlphaWindows",false);
         add("notificationsMode",1);
         add("notificationsDisplayDuration",5);
         add("notificationsMaxNumber",5);
         add("notificationsPosition",ExternalNotificationPositionEnum.BOTTOM_RIGHT);
         add("creaturesFightMode",false);
      }




   }

}