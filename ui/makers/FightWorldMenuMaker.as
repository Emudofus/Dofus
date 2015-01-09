package makers
{
    import d2actions.ToggleDematerialization;
    import d2hooks.OrderFightersSwitched;
    import d2actions.ShowTacticMode;
    import d2hooks.HideDeadFighters;
    import d2hooks.HideSummonedFighters;

    public class FightWorldMenuMaker extends WorldMenuMaker 
    {


        private function onInvisibleModeChange(value:Boolean):void
        {
            Api.system.sendAction(new ToggleDematerialization());
        }

        private function onCellSelectionOnly(value:Boolean):void
        {
            switchOption("dofus", "cellSelectionOnly");
        }

        private function onShowMovementDistance(value:Boolean):void
        {
            switchOption("dofus", "showMovementDistance");
        }

        private function onShowUsedPaPmChange(value:Boolean):void
        {
            switchOption("dofus", "showUsedPaPm");
        }

        private function onRemindTurnChange(value:Boolean):void
        {
            switchOption("dofus", "remindTurn");
        }

        private function onOrderFightersChange(value:Boolean):void
        {
            switchOption("dofus", "orderFighters");
            Api.system.dispatchHook(OrderFightersSwitched, value);
        }

        private function onShowTacticMode(value:Boolean):void
        {
            switchOption("dofus", "showTacticMode");
            Api.system.sendAction(new ShowTacticMode());
        }

        private function onHideDeadFighters(value:Boolean):void
        {
            switchOption("dofus", "hideDeadFighters");
            Api.system.dispatchHook(HideDeadFighters, Api.system.getOption("hideDeadFighters", "dofus"));
        }

        private function onShowLogPvDetails(value:Boolean):void
        {
            switchOption("dofus", "showLogPvDetails");
        }

        private function onHideSummonedFighters(value:Boolean):void
        {
            switchOption("dofus", "hideSummonedFighters");
            Api.system.dispatchHook(HideSummonedFighters, Api.system.getOption("hideSummonedFighters", "dofus"));
        }

        private function onShowPermanentTargetsTooltips(value:Boolean):void
        {
            switchOption("dofus", "showPermanentTargetsTooltips");
        }

        private function onShowDamagesPreview(value:Boolean):void
        {
            switchOption("dofus", "showDamagesPreview");
        }

        private function onShowAlignmentWings(value:Boolean):void
        {
            switchOption("dofus", "showAlignmentWings");
        }

        private function onSpectatorAutoShowCurrentFighterInfo(value:Boolean):void
        {
            switchOption("dofus", "spectatorAutoShowCurrentFighterInfo");
        }

        private function onShowMountsInFight(value:Boolean):void
        {
            switchOption("dofus", "showMountsInFight");
        }

        override public function createMenu(data:*, param:Object):Array
        {
            var menu:Array = super.createMenu(data, param);
            var subMenu:Array = new Array();
            subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.general")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showUsedPaPm"), this.onShowUsedPaPmChange, Api.system.getOption("showUsedPaPm", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.orderFighters"), this.onOrderFightersChange, Api.system.getOption("orderFighters", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showMountsInFight"), this.onShowMountsInFight, Api.system.getOption("showMountsInFight", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.fightTargetMode"), this.onCellSelectionOnly, Api.system.getOption("cellSelectionOnly", "dofus"), "cellSelectionOnly"));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showMovementDistance"), this.onShowMovementDistance, Api.system.getOption("showMovementDistance", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.spectatorAutoShowCurrentFighterInfo"), this.onSpectatorAutoShowCurrentFighterInfo, Api.system.getOption("spectatorAutoShowCurrentFighterInfo", "dofus")));
            subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.title.rollover")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showDamagesPreview"), this.onShowDamagesPreview, Api.system.getOption("showDamagesPreview", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showAlignmentWings"), this.onShowAlignmentWings, Api.system.getOption("showAlignmentWings", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showPermanentTargetsTooltips"), this.onShowPermanentTargetsTooltips, Api.system.getOption("showPermanentTargetsTooltips", "dofus")));
            subMenu.push(ContextMenu.static_createContextMenuTitleObject(Api.ui.getText("ui.option.title.chatAndTimeline")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.showLogPvDetails"), this.onShowLogPvDetails, Api.system.getOption("showLogPvDetails", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.hideDeadFighters"), this.onHideDeadFighters, Api.system.getOption("hideDeadFighters", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.hideSummonedFighters"), this.onHideSummonedFighters, Api.system.getOption("hideSummonedFighters", "dofus")));
            subMenu.push(createItemOption(Api.ui.getText("ui.option.remindTurn"), this.onRemindTurnChange, Api.system.getOption("remindTurn", "dofus")));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.option.fightOptions"), null, null, false, subMenu));
            return (menu);
        }


    }
}//package makers

