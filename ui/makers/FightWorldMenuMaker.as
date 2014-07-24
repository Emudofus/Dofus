package makers
{
   import d2actions.ToggleDematerialization;
   import d2hooks.OrderFightersSwitched;
   import d2actions.ShowTacticMode;
   import d2hooks.HideDeadFighters;
   import d2hooks.HideSummonedFighters;
   
   public class FightWorldMenuMaker extends WorldMenuMaker
   {
      
      public function FightWorldMenuMaker() {
         super();
      }
      
      private function onInvisibleModeChange(value:Boolean) : void {
         Api.system.sendAction(new ToggleDematerialization());
      }
      
      private function onCellSelectionOnly(value:Boolean) : void {
         switchOption("dofus","cellSelectionOnly");
      }
      
      private function onShowMovementDistance(value:Boolean) : void {
         switchOption("dofus","showMovementDistance");
      }
      
      private function onShowEntityInfosChange(value:Boolean) : void {
         switchOption("dofus","showEntityInfos");
      }
      
      private function onShowUsedPaPmChange(value:Boolean) : void {
         switchOption("dofus","showUsedPaPm");
      }
      
      private function onShowMovementRangeChange(value:Boolean) : void {
         switchOption("dofus","showMovementRange");
      }
      
      private function onShowLineOfSightChange(value:Boolean) : void {
         switchOption("dofus","showLineOfSight");
      }
      
      private function onRemindTurnChange(value:Boolean) : void {
         switchOption("dofus","remindTurn");
      }
      
      private function onShowGlowOverTargetChange(value:Boolean) : void {
         switchOption("dofus","showGlowOverTarget");
      }
      
      private function onOrderFightersChange(value:Boolean) : void {
         switchOption("dofus","orderFighters");
         Api.system.dispatchHook(OrderFightersSwitched,value);
      }
      
      private function onShowTacticMode(value:Boolean) : void {
         switchOption("dofus","showTacticMode");
         Api.system.sendAction(new ShowTacticMode());
      }
      
      private function onHideDeadFighters(value:Boolean) : void {
         switchOption("dofus","hideDeadFighters");
         Api.system.dispatchHook(HideDeadFighters,Api.system.getOption("hideDeadFighters","dofus"));
      }
      
      private function onHideSummonedFighters(value:Boolean) : void {
         switchOption("dofus","hideSummonedFighters");
         Api.system.dispatchHook(HideSummonedFighters,Api.system.getOption("hideSummonedFighters","dofus"));
      }
      
      private function onShowPermanentTargetsTooltips(value:Boolean) : void {
         switchOption("dofus","showPermanentTargetsTooltips");
      }
      
      private function onShowDamagesPreview(value:Boolean) : void {
         switchOption("dofus","showDamagesPreview");
      }
      
      private function onSpectatorAutoShowCurrentFighterInfo(value:Boolean) : void {
         switchOption("dofus","spectatorAutoShowCurrentFighterInfo");
      }
      
      override public function createMenu(data:*, param:Object) : Array {
         var menu:Array = super.createMenu(data,param);
         var subMenu:Array = new Array();
         subMenu.push(createItemOption(Api.ui.getText("ui.option.fightTargetMode"),this.onCellSelectionOnly,Api.system.getOption("cellSelectionOnly","dofus"),"cellSelectionOnly"));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.entityInfos"),this.onShowEntityInfosChange,Api.system.getOption("showEntityInfos","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showUsedPaPm"),this.onShowUsedPaPmChange,Api.system.getOption("showUsedPaPm","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.entitiesMove"),this.onShowMovementRangeChange,Api.system.getOption("showMovementRange","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.lineOfSight"),this.onShowLineOfSightChange,Api.system.getOption("showLineOfSight","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.remindTurn"),this.onRemindTurnChange,Api.system.getOption("remindTurn","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showGlowOverTarget"),this.onShowGlowOverTargetChange,Api.system.getOption("showGlowOverTarget","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.orderFighters"),this.onOrderFightersChange,Api.system.getOption("orderFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showMovementDistance"),this.onShowMovementDistance,Api.system.getOption("showMovementDistance","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.hideDeadFighters"),this.onHideDeadFighters,Api.system.getOption("hideDeadFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.hideSummonedFighters"),this.onHideSummonedFighters,Api.system.getOption("hideSummonedFighters","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showPermanentTargetsTooltips"),this.onShowPermanentTargetsTooltips,Api.system.getOption("showPermanentTargetsTooltips","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.showDamagesPreview"),this.onShowDamagesPreview,Api.system.getOption("showDamagesPreview","dofus")));
         subMenu.push(createItemOption(Api.ui.getText("ui.option.spectatorAutoShowCurrentFighterInfo"),this.onSpectatorAutoShowCurrentFighterInfo,Api.system.getOption("spectatorAutoShowCurrentFighterInfo","dofus")));
         menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.fightOptions"),null,null,false,subMenu));
         return menu;
      }
   }
}
