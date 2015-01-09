package makers
{
    import d2actions.FriendSpouseFollow;
    import d2enums.CompassTypeEnum;
    import d2actions.PartyStopFollowingMember;
    import d2hooks.RemoveMapFlag;
    import d2data.Quest;
    import d2hooks.OpenBook;
    import d2actions.*;
    import d2hooks.*;

    public class MapFlagMenuMaker 
    {

        private var disabled:Boolean = false;
        private var _worldMapId:int;


        private function askRemoveFlag(flagId:String):void
        {
            var flagType:int;
            if (flagId.indexOf("flag_srv") == 0)
            {
                flagType = int(flagId.substring(8, 9));
                switch (flagType)
                {
                    case CompassTypeEnum.COMPASS_TYPE_SPOUSE:
                        Api.system.sendAction(new FriendSpouseFollow(false));
                        break;
                    case CompassTypeEnum.COMPASS_TYPE_PARTY:
                        Api.system.sendAction(new PartyStopFollowingMember(Api.party.getPartyId(), int(flagId.substring(10))));
                        break;
                    default:
                        Api.system.dispatchHook(RemoveMapFlag, flagId, this._worldMapId);
                };
            }
            else
            {
                Api.system.dispatchHook(RemoveMapFlag, flagId, this._worldMapId);
            };
        }

        private function askOpenQuest(flagId:String):void
        {
            var data:Object;
            var questId:int = int(flagId.split("_")[2]);
            var quest:Quest = Api.data.getQuest(questId);
            if (quest)
            {
                data = new Object();
                data.quest = quest;
                data.forceOpen = true;
                Api.system.dispatchHook(OpenBook, "questTab", data);
            };
        }

        public function createMenu(data:*, param:Object):Array
        {
            var menu:Array = new Array();
            if (((data) && ((data.id.indexOf("flag_") == 0))))
            {
                this._worldMapId = param[0];
                if (data.canBeManuallyRemoved)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.popup.delete"), this.askRemoveFlag, [data.id], this.disabled));
                };
                if (data.id.indexOf(("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST)) == 0)
                {
                    menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.shortcuts.openBookQuest"), this.askOpenQuest, [data.id], this.disabled));
                };
            };
            return (menu);
        }


    }
}//package makers

