package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.MapApi;
    import d2api.MountApi;
    import d2api.SocialApi;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.GuildInformationsFarms;
    import d2hooks.CurrentMap;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2enums.StatesEnum;
    import d2network.PaddockContentInformations;
    import d2data.SubArea;
    import d2actions.GuildFarmTeleportRequest;
    import d2hooks.*;
    import d2actions.*;

    public class GuildPaddock 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var mapApi:MapApi;
        public var mountApi:MountApi;
        public var socialApi:SocialApi;
        private var _selectedPaddock:Object;
        private var _widthName:int;
        public var grid_paddock:Grid;
        public var grid_mount:Grid;
        public var lbl_name:Label;
        public var lbl_maxObject:Label;
        public var lbl_quantity:Label;
        public var btn_join:ButtonContainer;


        public function main(... params):void
        {
            this.btn_join.soundId = SoundEnum.SPEC_BUTTON;
            this.sysApi.addHook(GuildInformationsFarms, this.onGuildInformationsFarms);
            this.sysApi.addHook(CurrentMap, this.onCurrentMap);
            this.uiApi.addComponentHook(this.btn_join, "onRelease");
            this.uiApi.addComponentHook(this.grid_mount, "onSelectItem");
            this.uiApi.addComponentHook(this.grid_mount, "onItemRollOver");
            this.uiApi.addComponentHook(this.grid_mount, "onItemRollOut");
            this.uiApi.addComponentHook(this.grid_paddock, "onSelectItem");
            this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_PADDOCKS));
            this._widthName = int(this.uiApi.me().getConstant("name_width"));
            this.lbl_name.text = "";
            this.lbl_maxObject.text = "-";
            this.lbl_quantity.text = "-";
            this.btn_join.disabled = true;
        }

        public function unload():void
        {
        }

        public function updatePaddockLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (data.paddock.abandonned)
                {
                    componentsRef.tx_abandonned.visible = true;
                    this.uiApi.addComponentHook(componentsRef.tx_abandonned, "onRollOver");
                    this.uiApi.addComponentHook(componentsRef.tx_abandonned, "onRollOut");
                    componentsRef.lbl_name.width = (this._widthName - 30);
                }
                else
                {
                    componentsRef.tx_abandonned.visible = false;
                    componentsRef.lbl_name.width = this._widthName;
                };
                componentsRef.lbl_name.text = data.text;
                componentsRef.lbl_name.visible = true;
                componentsRef.btn_paddock.visible = true;
                componentsRef.btn_paddock.selected = selected;
                componentsRef.btn_paddock.state = ((selected) ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL);
            }
            else
            {
                componentsRef.tx_abandonned.visible = false;
                componentsRef.lbl_name.visible = false;
                componentsRef.btn_paddock.visible = false;
                componentsRef.btn_paddock.selected = false;
            };
        }

        public function updateMountLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_mountType.text = this.mountApi.getMount(data.modelId).name;
                componentsRef.lbl_owner.text = data.ownerName;
            }
            else
            {
                componentsRef.lbl_mountType.text = "";
                componentsRef.lbl_owner.text = "";
            };
        }

        private function onGuildInformationsFarms():void
        {
            var paddock:PaddockContentInformations;
            var x:int;
            var y:int;
            var subArea:SubArea;
            var provider:Array = new Array();
            var farmsInformations:Object = this.socialApi.getGuildPaddocks();
            var nb:int = farmsInformations.length;
            var i:int;
            while (i < nb)
            {
                paddock = farmsInformations[i];
                if (paddock.worldX)
                {
                    x = paddock.worldX;
                }
                else
                {
                    x = this.mapApi.getMapCoords(paddock.mapId).x;
                };
                if (paddock.worldY)
                {
                    y = paddock.worldY;
                }
                else
                {
                    y = this.mapApi.getMapCoords(paddock.mapId).y;
                };
                subArea = this.dataApi.getSubArea(paddock.subAreaId);
                provider.push({
                    "paddock":paddock,
                    "text":(((((((subArea.area.name + " (") + subArea.name) + ") (") + x) + ", ") + y) + ")"),
                    "areaId":subArea.areaId,
                    "subAreaName":subArea.name,
                    "mapId":paddock.mapId
                });
                i++;
            };
            provider.sortOn(["areaId", "subAreaName", "mapId"], [Array.NUMERIC, Array.CASEINSENSITIVE, Array.NUMERIC]);
            this.grid_paddock.dataProvider = provider;
            if (farmsInformations.length == 0)
            {
                this.grid_mount.dataProvider = new Array();
            };
        }

        private function onPaddockSelected(paddock:Object):void
        {
            var mount:Object;
            this._selectedPaddock = paddock;
            this.btn_join.disabled = false;
            var mountList:Array = new Array();
            for each (mount in paddock.mountsInformations)
            {
                mountList.push(mount);
            };
            this.grid_mount.dataProvider = mountList;
            this.lbl_name.text = ((this.uiApi.getText("ui.common.mountPark") + " - ") + this.dataApi.getSubArea(paddock.subAreaId).name);
            this.lbl_maxObject.text = ((paddock.maxItems + " ") + this.uiApi.getText("ui.common.maxWord"));
            this.lbl_quantity.text = ((paddock.mountsInformations.length + " / ") + paddock.maxOutdoorMount);
        }

        private function onCurrentMap(mapId:uint):void
        {
            this.uiApi.unloadUi("socialBase");
        }

        public function onRelease(target:Object):void
        {
            if (target == this.btn_join)
            {
                if (this._selectedPaddock != null)
                {
                    this.sysApi.sendAction(new GuildFarmTeleportRequest(this._selectedPaddock.paddockId));
                    this.uiApi.unloadUi("socialBase");
                };
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.grid_paddock)
            {
                this.onPaddockSelected(this.grid_paddock.dataProvider[target.selectedIndex].paddock);
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            if (target.name.indexOf("tx_abandonned") != -1)
            {
                text = this.uiApi.getText("ui.social.paddockWithNoOwner");
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var name:String;
            if (((item) && (item.data)))
            {
                if (item.data.name)
                {
                    name = item.data.name;
                }
                else
                {
                    name = this.uiApi.getText("ui.common.noName");
                };
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(name), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}//package ui

