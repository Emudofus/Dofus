package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.JobsApi;
    import d2api.InventoryApi;
    import d2api.UtilApi;
    import d2data.LegendaryTreasureHunt;
    import d2data.QuantifiedItemWrapper;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2components.Label;
    import d2components.EntityDisplayer;
    import d2components.Texture;
    import d2components.Slot;
    import d2components.GraphicContainer;
    import d2hooks.TreasureHuntUpdate;
    import d2enums.ComponentHookList;
    import d2data.Item;
    import d2data.Recipe;
    import d2enums.LocationEnum;
    import d2actions.TreasureHuntLegendaryRequest;
    import d2enums.TreasureHuntTypeEnum;
    import d2hooks.*;
    import d2actions.*;

    public class LegendaryHunts 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var jobsApi:JobsApi;
        public var inventoryApi:InventoryApi;
        public var utilApi:UtilApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _hunts:Array;
        private var _availableHunts:Array;
        private var _showAll:Boolean = true;
        private var _selectedHunt:LegendaryTreasureHunt;
        private var _mapItem:QuantifiedItemWrapper;
        public var btn_close:ButtonContainer;
        public var gd_hunts:Grid;
        public var btn_showAll:ButtonContainer;
        public var lbl_name:Label;
        public var lbl_level:Label;
        public var ed_monster:EntityDisplayer;
        public var lbl_monsterName:Label;
        public var lbl_rewardXp:Label;
        public var tx_rewardChest:Texture;
        public var lbl_mapRecap:Label;
        public var gd_mapPieces:Grid;
        public var slot_map:Slot;
        public var ctr_map:GraphicContainer;
        public var tx_craftMap:Texture;
        public var btn_start:ButtonContainer;

        public function LegendaryHunts()
        {
            this._hunts = new Array();
            this._availableHunts = new Array();
            super();
        }

        public function main(param:Object):void
        {
            var h:LegendaryTreasureHunt;
            var id:int;
            this.sysApi.addHook(TreasureHuntUpdate, this.onTreasureHunt);
            this.uiApi.addComponentHook(this.gd_hunts, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btn_showAll, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.gd_mapPieces, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.gd_mapPieces, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_mapPieces, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_craftMap, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_craftMap, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_map, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_map, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.slot_map, ComponentHookList.ON_RELEASE);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.btn_showAll.selected = this._showAll;
            this.ed_monster.setAnimationAndDirection("AnimArtwork", 1);
            this.ed_monster.view = "turnstart";
            if (param)
            {
                for each (id in param)
                {
                    this._availableHunts.push(id);
                };
            };
            var dataHunts:Object = this.dataApi.getLegendaryTreasureHunts();
            for each (h in dataHunts)
            {
                this._hunts.push(h);
            };
            this.refreshList();
        }

        public function unload():void
        {
        }

        public function updateLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_name.text = data.name;
                if (((((this._showAll) && (!((data.id == 0))))) && ((this._availableHunts.indexOf(data.id) == -1))))
                {
                    componentsRef.lbl_name.cssClass = "p4";
                }
                else
                {
                    componentsRef.lbl_name.cssClass = "p";
                };
                componentsRef.btn_hunt.selected = selected;
                componentsRef.btn_hunt.visible = true;
            }
            else
            {
                componentsRef.lbl_name.text = "";
                componentsRef.btn_hunt.selected = false;
                componentsRef.btn_hunt.visible = false;
            };
        }

        private function displayHunt():void
        {
            var totalPieces:int;
            var ingredients:Object;
            var iw:QuantifiedItemWrapper;
            var i:int;
            this.sysApi.log(2, ("go " + this._selectedHunt.id));
            this.lbl_name.text = this._selectedHunt.name;
            this.lbl_level.text = ((this.uiApi.getText("ui.common.short.level") + " ") + this._selectedHunt.level);
            if (this._selectedHunt.monster)
            {
                this.lbl_monsterName.text = (((("{chatmonster," + this._selectedHunt.monster.id) + "::[") + this._selectedHunt.monster.name) + "]}");
                this.ed_monster.look = this._selectedHunt.monster.look;
            };
            this.lbl_rewardXp.text = this.utilApi.kamasToString(this._selectedHunt.experienceReward, "");
            var chest:Item = this.dataApi.getItem(this._selectedHunt.chestId);
            if (chest)
            {
                this.tx_rewardChest.uri = this.uiApi.createUri(((this.uiApi.me().getConstant("item_path") + chest.iconId) + ".swf"));
            };
            this._mapItem = this.inventoryApi.getQuantifiedItemByGIDInInventoryOrMakeUpOne(this._selectedHunt.mapItemId);
            this.slot_map.data = this._mapItem;
            var recipe:Recipe = this.jobsApi.getRecipe(this._selectedHunt.mapItemId);
            var myPieces:int;
            var items:Array = new Array();
            if (recipe)
            {
                ingredients = recipe.ingredients;
                totalPieces = ingredients.length;
                i = 0;
                while (i < totalPieces)
                {
                    iw = this.inventoryApi.getQuantifiedItemByGIDInInventoryOrMakeUpOne(ingredients[i].id);
                    items.push(iw);
                    if (iw.quantity > 0)
                    {
                        myPieces++;
                    };
                    i++;
                };
                this.gd_mapPieces.width = ((totalPieces * 46) + 2);
                this.gd_mapPieces.dataProvider = items;
            };
            this.lbl_mapRecap.text = this.uiApi.processText(this.uiApi.getText("ui.treasureHunt.pieces", myPieces, totalPieces), "", (myPieces <= 1));
            this.ctr_map.x = ((this.gd_mapPieces.x + this.gd_mapPieces.width) + 4);
            if (this._availableHunts.indexOf(this._selectedHunt.id) == -1)
            {
                this.btn_start.disabled = true;
            }
            else
            {
                this.btn_start.disabled = false;
            };
        }

        private function refreshList():void
        {
            var tempStartableHunts:Array;
            var h:LegendaryTreasureHunt;
            if (this._showAll)
            {
                this.gd_hunts.dataProvider = this._hunts;
            }
            else
            {
                tempStartableHunts = new Array();
                for each (h in this._hunts)
                {
                    if (((h) && ((this._availableHunts.indexOf(h.id) > -1))))
                    {
                        tempStartableHunts.push(h);
                    };
                };
                this.gd_hunts.dataProvider = tempStartableHunts;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_showAll:
                    this._showAll = this.btn_showAll.selected;
                    this.refreshList();
                    break;
                case this.btn_start:
                    this.onPopupValid();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            switch (target)
            {
                case this.slot_map:
                    if (target.data)
                    {
                        this.uiApi.showTooltip(target.data, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, "itemName", null, {
                            "showEffects":true,
                            "header":true
                        }, "ItemInfo");
                    };
                    break;
                case this.tx_craftMap:
                    this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.treasureHunt.craftMap")), target, false, "standard", 6, 2, 3, null, null, null, "TextInfo");
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (!(item.data))
            {
                return;
            };
            this.uiApi.showTooltip(item.data, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, "itemName", null, {
                "showEffects":true,
                "header":true
            }, "ItemInfo");
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
            return (true);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (target == this.gd_hunts)
            {
                this._selectedHunt = target.selectedItem;
                this.displayHunt();
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupValid():void
        {
            if (!(this._selectedHunt))
            {
                return;
            };
            this.sysApi.sendAction(new TreasureHuntLegendaryRequest(this._selectedHunt.id));
        }

        private function onTreasureHunt(treasureHuntType:uint):void
        {
            if (treasureHuntType == TreasureHuntTypeEnum.TREASURE_HUNT_LEGENDARY)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }


    }
}//package ui

