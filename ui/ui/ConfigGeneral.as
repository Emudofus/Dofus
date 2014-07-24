package ui
{
   import d2api.BindsApi;
   import d2api.SocialApi;
   import d2components.ButtonContainer;
   import types.ConfigProperty;
   import d2hooks.FriendWarningState;
   import d2hooks.FriendOrGuildMemberLevelUpWarningState;
   import d2hooks.FriendGuildWarnOnAchievementCompleteState;
   import d2actions.FriendOrGuildMemberLevelUpWarningSet;
   import d2actions.FriendGuildSetWarnOnAchievementComplete;
   import d2actions.FriendWarningSet;
   import d2hooks.OrderFightersSwitched;
   import d2hooks.HideDeadFighters;
   import d2hooks.HideSummonedFighters;
   
   public class ConfigGeneral extends ConfigUi
   {
      
      public function ConfigGeneral() {
         super();
      }
      
      public var bindsApi:BindsApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var btn_showEntityInfos:ButtonContainer;
      
      public var btn_alwaysShowGrid:ButtonContainer;
      
      public var btn_transparentOverlayMode:ButtonContainer;
      
      public var btn_showMapCoordinates:ButtonContainer;
      
      public var btn_showMovementRange:ButtonContainer;
      
      public var btn_showLineOfSight:ButtonContainer;
      
      public var btn_remindTurn:ButtonContainer;
      
      public var btn_warnWhenFriendOrGuildMemberLvlUp:ButtonContainer;
      
      public var btn_warnWhenFriendIsOnline:ButtonContainer;
      
      public var btn_warnWhenFriendOrGuildAchieves:ButtonContainer;
      
      public var btn_warnOnGuildItemAgression:ButtonContainer;
      
      public var btn_showUSedPaPm:ButtonContainer;
      
      public var btn_showGlowOverTarget:ButtonContainer;
      
      public var btn_cellSelectionOnly:ButtonContainer;
      
      public var btn_orderFighters:ButtonContainer;
      
      public var btn_showAlignmentWings:ButtonContainer;
      
      public var btn_showInsideAutoZoom:ButtonContainer;
      
      public var btn_showMovementDistance:ButtonContainer;
      
      public var btn_hideDeadFighters:ButtonContainer;
      
      public var btn_hideSummonedFighters:ButtonContainer;
      
      public var btn_showLogPvDetails:ButtonContainer;
      
      public var btn_showPermanentTargetsTooltips:ButtonContainer;
      
      public var btn_showDamagesPreview:ButtonContainer;
      
      public var btn_autoShowCurrentFighterInfo:ButtonContainer;
      
      private var btn_zoomOnMouseWheel:ButtonContainer;
      
      private var btn_skipTurnWhenDone:ButtonContainer;
      
      public function main(args:*) : void {
         var properties:Array = new Array();
         properties.push(new ConfigProperty("btn_alwaysShowGrid","alwaysShowGrid","atouin"));
         properties.push(new ConfigProperty("btn_transparentOverlayMode","transparentOverlayMode","atouin"));
         properties.push(new ConfigProperty("btn_showMapCoordinates","mapCoordinates","dofus"));
         properties.push(new ConfigProperty("btn_showInsideAutoZoom","useInsideAutoZoom","atouin"));
         properties.push(new ConfigProperty("btn_zoomOnMouseWheel","zoomOnMouseWheel","dofus"));
         properties.push(new ConfigProperty("btn_showEntityInfos","showEntityInfos","dofus"));
         properties.push(new ConfigProperty("btn_showMovementRange","showMovementRange","dofus"));
         properties.push(new ConfigProperty("btn_showLineOfSight","showLineOfSight","dofus"));
         properties.push(new ConfigProperty("btn_remindTurn","remindTurn","dofus"));
         properties.push(new ConfigProperty("btn_showUSedPaPm","showUsedPaPm","dofus"));
         properties.push(new ConfigProperty("btn_showGlowOverTarget","showGlowOverTarget","dofus"));
         properties.push(new ConfigProperty("btn_cellSelectionOnly","cellSelectionOnly","dofus"));
         properties.push(new ConfigProperty("btn_orderFighters","orderFighters","dofus"));
         properties.push(new ConfigProperty("btn_showAlignmentWings","showAlignmentWings","dofus"));
         properties.push(new ConfigProperty("btn_showMovementDistance","showMovementDistance","dofus"));
         properties.push(new ConfigProperty("btn_hideDeadFighters","hideDeadFighters","dofus"));
         properties.push(new ConfigProperty("btn_hideSummonedFighters","hideSummonedFighters","dofus"));
         properties.push(new ConfigProperty("btn_showLogPvDetails","showLogPvDetails","dofus"));
         properties.push(new ConfigProperty("btn_showPermanentTargetsTooltips","showPermanentTargetsTooltips","dofus"));
         properties.push(new ConfigProperty("btn_showDamagesPreview","showDamagesPreview","dofus"));
         properties.push(new ConfigProperty("btn_spectatorAutoShowCurrentFighterInfo","spectatorAutoShowCurrentFighterInfo","dofus"));
         properties.push(new ConfigProperty("btn_warnOnGuildItemAgression","warnOnGuildItemAgression","dofus"));
         sysApi.addHook(FriendWarningState,this.onFriendWarningState);
         sysApi.addHook(FriendOrGuildMemberLevelUpWarningState,this.onFriendOrGuildMemberLevelUpWarningState);
         sysApi.addHook(FriendGuildWarnOnAchievementCompleteState,this.onFriendGuildWarnOnAchievementCompleteState);
         this.btn_warnWhenFriendIsOnline.selected = this.socialApi.getWarnOnFriendConnec();
         this.btn_warnWhenFriendOrGuildAchieves.selected = this.socialApi.getWarnWhenFriendOrGuildMemberAchieve();
         this.btn_warnWhenFriendOrGuildMemberLvlUp.selected = this.socialApi.getWarnWhenFriendOrGuildMemberLvlUp();
         uiApi.addComponentHook(this.btn_showGlowOverTarget,"onRollOver");
         uiApi.addComponentHook(this.btn_showGlowOverTarget,"onRollOut");
         uiApi.addComponentHook(this.btn_cellSelectionOnly,"onRollOver");
         uiApi.addComponentHook(this.btn_cellSelectionOnly,"onRollOut");
         uiApi.addComponentHook(this.btn_showMovementDistance,"onRollOver");
         uiApi.addComponentHook(this.btn_showMovementDistance,"onRollOut");
         uiApi.addComponentHook(this.btn_orderFighters,"onRollOver");
         uiApi.addComponentHook(this.btn_orderFighters,"onRollOut");
         uiApi.addComponentHook(this.btn_showLogPvDetails,"onRollOver");
         uiApi.addComponentHook(this.btn_showLogPvDetails,"onRollOut");
         init(properties);
      }
      
      override public function reset() : void {
         super.reset();
         init(_properties);
         this.btn_warnWhenFriendIsOnline.selected = true;
         this.btn_warnWhenFriendOrGuildMemberLvlUp.selected = true;
         this.btn_warnWhenFriendOrGuildAchieves.selected = true;
         this.btn_warnOnGuildItemAgression.selected = true;
         sysApi.sendAction(new FriendOrGuildMemberLevelUpWarningSet(true));
         sysApi.sendAction(new FriendGuildSetWarnOnAchievementComplete(true));
         sysApi.sendAction(new FriendWarningSet(true));
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
      }
      
      override public function onRelease(target:Object) : void {
         super.onRelease(target);
         switch(target)
         {
            case this.btn_warnWhenFriendOrGuildMemberLvlUp:
               sysApi.sendAction(new FriendOrGuildMemberLevelUpWarningSet(this.btn_warnWhenFriendOrGuildMemberLvlUp.selected));
               break;
            case this.btn_warnWhenFriendIsOnline:
               sysApi.sendAction(new FriendWarningSet(this.btn_warnWhenFriendIsOnline.selected));
               break;
            case this.btn_warnWhenFriendOrGuildAchieves:
               sysApi.sendAction(new FriendGuildSetWarnOnAchievementComplete(this.btn_warnWhenFriendOrGuildAchieves.selected));
               break;
            case this.btn_orderFighters:
               sysApi.dispatchHook(OrderFightersSwitched,this.btn_orderFighters.selected);
               break;
            case this.btn_hideDeadFighters:
               sysApi.dispatchHook(HideDeadFighters,this.btn_hideDeadFighters.selected);
               break;
            case this.btn_hideSummonedFighters:
               sysApi.dispatchHook(HideSummonedFighters,this.btn_hideSummonedFighters.selected);
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_showGlowOverTarget:
               tooltipText = uiApi.getText("ui.option.showGlowOverTargetTooltip");
               break;
            case this.btn_cellSelectionOnly:
               tooltipText = uiApi.getText("ui.option.fightTargetModeTooltip");
               break;
            case this.btn_orderFighters:
               tooltipText = uiApi.getText("ui.option.orderFightersTooltip");
               break;
            case this.btn_showMovementDistance:
               tooltipText = uiApi.getText("ui.option.showMovementDistanceTooltip");
               break;
            case this.btn_showLogPvDetails:
               tooltipText = uiApi.getText("ui.option.showLogPvDetailsTooltip");
               break;
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
      
      private function onFriendWarningState(enable:Boolean) : void {
         this.btn_warnWhenFriendIsOnline.selected = enable;
      }
      
      private function onFriendOrGuildMemberLevelUpWarningState(enable:Boolean) : void {
         this.btn_warnWhenFriendOrGuildMemberLvlUp.selected = enable;
      }
      
      private function onFriendGuildWarnOnAchievementCompleteState(enable:Boolean) : void {
         this.btn_warnWhenFriendOrGuildAchieves.selected = enable;
      }
   }
}
