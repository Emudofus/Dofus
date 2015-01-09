package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.UtilApi;
    import d2api.ContextMenuApi;
    import d2api.SoundApi;
    import d2api.InventoryApi;
    import d2api.TooltipApi;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ComboBox;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.Input;
    import d2components.EntityDisplayer;
    import flash.utils.Dictionary;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2data.Npc;
    import d2hooks.KeyUp;
    import d2hooks.ObjectQuantity;
    import d2hooks.ObjectDeleted;
    import d2data.ItemWrapper;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;
    import flash.ui.Keyboard;
    import d2actions.ExchangeShopStockMouvmentRemove;
    import d2hooks.CloseStore;
    import d2utils.ItemTooltipSettings;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
    import d2hooks.ClickItemStore;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;

    public class StockNpcStore 
    {

        public static const EQUIPEMENT_CATEGORY:uint = 0;
        public static const CONSUMABLES_CATEGORY:uint = 1;
        public static const RESSOURCES_CATEGORY:uint = 2;
        public static const ALL_CATEGORY:uint = uint.MAX_VALUE;//0xFFFFFFFF
        public static const OTHER_CATEGORY:uint = 4;
        private static const SORT_ON_PRICE:String = "price";
        private static const SORT_ON_WEIGHT:String = "weight";
        private static const SORT_ON_QTY:String = "quantity";
        private static const SORT_ON_NAME:String = "name";
        private static const SORT_ON_DEFAULT:String = "objectUID";

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var utilApi:UtilApi;
        public var menuApi:ContextMenuApi;
        public var soundApi:SoundApi;
        public var inventoryApi:InventoryApi;
        public var tooltipApi:TooltipApi;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var tx_shop:Texture;
        public var tx_border:Texture;
        public var tx_background:Texture;
        public var gd_shop:Grid;
        public var lbl_title:Label;
        public var cbFilter:ComboBox;
        public var btnEquipable:ButtonContainer;
        public var btnConsumables:ButtonContainer;
        public var btnRessources:ButtonContainer;
        public var btnAll:ButtonContainer;
        public var btnSearch:ButtonContainer;
        public var btnClose:ButtonContainer;
        public var ctr_filter:GraphicContainer;
        public var btn_filter:ButtonContainer;
        public var searchCtr:GraphicContainer;
        public var catCtr:GraphicContainer;
        public var searchInput:Input;
        public var merchantLook:EntityDisplayer;
        public var centerCtr:GraphicContainer;
        public var ctr_bottomInfos:GraphicContainer;
        protected var _searchCriteria:String;
        protected var _filterAssoc:Object;
        protected var _subFilterIndex:Object;
        protected var _shopStock:Object;
        protected var _category:Object;
        protected var _currentFilterBtn:Object;
        private var _waitingObject:Object;
        private var _slotList:Dictionary;
        private var _tokenType:int;
        private var _sellItemFromItemNameLabel:Dictionary;

        public function StockNpcStore()
        {
            this._filterAssoc = new Object();
            this._subFilterIndex = new Object();
            this._slotList = new Dictionary(true);
            this._sellItemFromItemNameLabel = new Dictionary();
            super();
        }

        public function main(pParam:Object):void
        {
            var item:Object;
            this.uiApi.loadUi(UIEnum.NPC_ITEM, UIEnum.NPC_ITEM);
            this.btnEquipable.soundId = SoundEnum.TAB;
            this.btnConsumables.soundId = SoundEnum.TAB;
            this.btnRessources.soundId = SoundEnum.TAB;
            this.btnAll.soundId = SoundEnum.TAB;
            var npc:Npc = this.dataApi.getNpc(pParam.NPCSellerId);
            this._tokenType = pParam.TokenId;
            if (this._tokenType)
            {
                this.ctr_filter.visible = true;
                this.gd_shop.height = (this.gd_shop.height - 49);
                this.tx_shop.height = (this.tx_shop.height - 49);
                this.tx_border.height = (this.tx_border.height - 49);
                this.tx_background.height = (this.tx_background.height - 25);
            };
            this.uiApi.addShortcutHook("closeUi", this.onShortCut);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(ObjectQuantity, this.onObjectQuantity);
            this.sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            this.uiApi.addComponentHook(this.btnSearch, "onRelease");
            this.uiApi.addComponentHook(this.btnSearch, "onRollOver");
            this.uiApi.addComponentHook(this.btnSearch, "onRollOut");
            this.uiApi.addComponentHook(this.searchInput, "onRollOver");
            this.uiApi.addComponentHook(this.searchInput, "onRollOut");
            this.uiApi.addComponentHook(this.btn_filter, "onRelease");
            this.centerCtr.visible = false;
            this.ctr_bottomInfos.visible = false;
            this.gd_shop.scrollDisplay = "always";
            this.gd_shop.autoSelectMode = 0;
            this._currentFilterBtn = this.btnAll;
            this.btnAll.selected = true;
            this._filterAssoc[this.btnEquipable.name] = EQUIPEMENT_CATEGORY;
            this._filterAssoc[this.btnConsumables.name] = CONSUMABLES_CATEGORY;
            this._filterAssoc[this.btnRessources.name] = RESSOURCES_CATEGORY;
            this._filterAssoc[this.btnAll.name] = ALL_CATEGORY;
            this.lbl_title.text = this.uiApi.getText("ui.common.shop");
            this._shopStock = new Array();
            for each (item in pParam.Objects)
            {
                this._shopStock.push(item);
            };
            this._shopStock.sort(this.shopStockSort);
            this._category = new Array();
            this.merchantLook.look = pParam.Look;
            this.updateStockInventory();
        }

        public function updateItemLine(data:*, components:*, selected:Boolean):void
        {
            var itemWrapper:Object;
            var itemObject:Object;
            var newWidthName:uint;
            var item:ItemWrapper;
            components.slot_item.allowDrag = false;
            if (!(this._slotList[components.slot_item.name]))
            {
                this.uiApi.addComponentHook(components.slot_item, "onRightClick");
                this.uiApi.addComponentHook(components.slot_item, "onRollOut");
                this.uiApi.addComponentHook(components.slot_item, "onRollOver");
                this.uiApi.addComponentHook(components.slot_TokenPrice, "onRightClick");
                this.uiApi.addComponentHook(components.slot_TokenPrice, "onRollOut");
                this.uiApi.addComponentHook(components.slot_TokenPrice, "onRollOver");
                this.uiApi.addComponentHook(components.btn_item, "onRollOut");
                this.uiApi.addComponentHook(components.btn_item, "onRollOver");
            };
            this._slotList[components.slot_item.name] = data;
            if (data)
            {
                this._sellItemFromItemNameLabel[components.btn_item] = data;
                components.btn_item.selected = selected;
                itemWrapper = data.item;
                itemObject = this.dataApi.getItem(itemWrapper.objectGID);
                if (!(this._tokenType))
                {
                    if (((((isNaN(Number(data.price))) || ((data.price == null)))) || ((data.price == 0))))
                    {
                        components.lbl_ItemPrice.text = "";
                    }
                    else
                    {
                        components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price);
                    };
                    newWidthName = ((((components.lbl_ItemPrice.x + components.lbl_ItemPrice.width) - components.lbl_ItemName.x) - 10) - components.lbl_ItemPrice.textfield.textWidth);
                }
                else
                {
                    newWidthName = ((components.slot_TokenPrice.x - components.lbl_ItemName.x) - 5);
                };
                components.lbl_ItemName.width = newWidthName;
                components.lbl_ItemName.text = itemWrapper.name;
                if (itemObject.etheral)
                {
                    components.lbl_ItemName.cssClass = "itemetheral";
                }
                else
                {
                    if (itemObject.itemSetId != -1)
                    {
                        components.lbl_ItemName.cssClass = "itemset";
                    }
                    else
                    {
                        components.lbl_ItemName.cssClass = "p";
                    };
                };
                if (!(data.criterion.isRespected))
                {
                    components.lbl_ItemName.cssClass = "malus";
                };
                if (this._tokenType)
                {
                    components.lbl_ItemPrice.visible = false;
                    components.slot_TokenPrice.visible = true;
                    item = this.dataApi.getItemWrapper(this._tokenType, 0, 0, data.price);
                    components.slot_TokenPrice.data = item;
                }
                else
                {
                    components.lbl_ItemPrice.visible = true;
                    components.slot_TokenPrice.visible = false;
                    components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price);
                };
                components.slot_item.data = itemWrapper;
                components.tx_backgroundItem.visible = true;
            }
            else
            {
                components.lbl_ItemName.text = "";
                components.lbl_ItemPrice.text = "";
                components.slot_item.data = null;
                components.tx_backgroundItem.visible = false;
                components.btn_item.selected = false;
                components.slot_TokenPrice.data = null;
                this._sellItemFromItemNameLabel[components.btn_item] = null;
            };
        }

        public function unload():void
        {
            this.uiApi.unloadUi(UIEnum.NPC_ITEM);
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.sysApi.sendAction(new CloseInventory());
            this.sysApi.enableWorldInteraction();
            this.uiApi.hideTooltip();
        }

        protected function updateStockInventory():void
        {
            var it:Object;
            var item:Object;
            var tokenCount:int;
            var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
            this.updateCombobox();
            var result:Object = new Array();
            var types:Object = new Array();
            for each (it in this._shopStock)
            {
                item = this.dataApi.getItem(it.item.objectGID);
                if (this._tokenType)
                {
                    tokenCount = this.inventoryApi.getItemQty(this._tokenType);
                };
                if ((((((((((it.item.category == filter)) || ((filter == ALL_CATEGORY)))) && (((((!(this.cbFilter.value)) || ((this.cbFilter.value.filterType == -1)))) || ((this.cbFilter.value.filterType == item.typeId)))))) && (((!(this._searchCriteria)) || (!((item.name.toLowerCase().indexOf(this._searchCriteria) == -1))))))) && (((!(this.btn_filter.selected)) || (((it.criterion.isRespected) && (((!(this._tokenType)) || ((it.price <= tokenCount))))))))))
                {
                    types[item.typeId] = item.type;
                    result.push(it);
                };
            };
            this.gd_shop.dataProvider = result;
        }

        protected function updateCombobox():void
        {
            var it:Object;
            var cbProvider:Array;
            var selectedItem:Object;
            var tmp:Object;
            var type:Object;
            var types:Object = new Array();
            var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
            for each (it in this._shopStock)
            {
                if ((((it.item.category == filter)) || ((filter == ALL_CATEGORY))))
                {
                    types[it.item.typeId] = it.item.type;
                };
            };
            cbProvider = new Array();
            for each (type in types)
            {
                tmp = {
                    "label":type.name,
                    "filterType":type.id
                };
                if (type.id == this._subFilterIndex[this._currentFilterBtn.name])
                {
                    selectedItem = tmp;
                };
                cbProvider.push(tmp);
            };
            cbProvider = cbProvider.sortOn("label", Array.CASEINSENSITIVE);
            tmp = {
                "label":this.uiApi.getText("ui.common.allTypesForObject"),
                "filterType":-1
            };
            if (!(selectedItem))
            {
                selectedItem = tmp;
            };
            cbProvider.unshift(tmp);
            this.cbFilter.dataProvider = cbProvider;
            this.cbFilter.value = selectedItem;
        }

        protected function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if (data == null)
            {
                return (false);
            };
            if ((data is ItemWrapper))
            {
                if (data.position != 63)
                {
                    return (true);
                };
            };
            return (false);
        }

        protected function processDrop(target:Object, data:Object, source:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Object;
            var _local_3:Boolean;
            var _local_4:Boolean;
            switch (target)
            {
                case this.btnEquipable:
                case this.btnConsumables:
                case this.btnRessources:
                case this.btnAll:
                    this._currentFilterBtn = target;
                    this.updateStockInventory();
                    if (this.gd_shop.dataProvider.length > 0)
                    {
                        this.gd_shop.selectedIndex = -1;
                    };
                    break;
                case this.btnSearch:
                    this.searchCtr.visible = !(this.searchCtr.visible);
                    this.catCtr.visible = !(this.searchCtr.visible);
                    if (this.searchCtr.visible)
                    {
                        this.searchInput.focus();
                        this._searchCriteria = this.searchInput.text.toLowerCase();
                        if (this._searchCriteria.length < 3)
                        {
                            this.gd_shop.dataProvider = new Array();
                        }
                        else
                        {
                            this.updateStockInventory();
                        };
                    }
                    else
                    {
                        this._searchCriteria = null;
                        this.updateStockInventory();
                    };
                    break;
                case this.btn_filter:
                    this.updateStockInventory();
                    break;
                case this.gd_shop:
                    _local_2 = this.gd_shop.selectedItem;
                    _local_3 = this.uiApi.keyIsDown(Keyboard.CONTROL);
                    _local_4 = this.uiApi.keyIsDown(Keyboard.SHIFT);
                    if (((_local_3) && (_local_4)))
                    {
                        this.sysApi.sendAction(new ExchangeShopStockMouvmentRemove(_local_2.objectUID, _local_2.quantity));
                    };
                    break;
                case this.btnClose:
                    this.sysApi.dispatchHook(CloseStore);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var info:String;
            var itemTooltipSettings:ItemTooltipSettings;
            var sellItem:Object;
            var pos:Object = {
                "point":LocationEnum.POINT_RIGHT,
                "relativePoint":LocationEnum.POINT_RIGHT
            };
            var offset:int = 9;
            switch (target)
            {
                case this.btnEquipable:
                    info = this.uiApi.getText("ui.common.equipement");
                    break;
                case this.btnConsumables:
                    info = this.uiApi.getText("ui.common.usableItems");
                    break;
                case this.btnRessources:
                    info = this.uiApi.getText("ui.common.ressources");
                    break;
                case this.btnAll:
                    info = this.uiApi.getText("ui.common.all");
                    break;
                case this.btnSearch:
                    info = this.uiApi.getText("ui.common.sortOrSearch");
                    pos.point = LocationEnum.POINT_BOTTOM;
                    pos.relativePoint = LocationEnum.POINT_TOP;
                    offset = 3;
                    break;
                case this.searchInput:
                    info = this.uiApi.getText("ui.common.searchFilterTooltip");
                    pos.point = LocationEnum.POINT_BOTTOM;
                    pos.relativePoint = LocationEnum.POINT_TOP;
                    offset = 3;
                    break;
                default:
                    if (target.name.indexOf("slot_") != -1)
                    {
                        itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
                        if (itemTooltipSettings == null)
                        {
                            itemTooltipSettings = this.tooltipApi.createItemSettings();
                            this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
                        };
                        if (this.sysApi.getOption("displayTooltips", "dofus"))
                        {
                            this.uiApi.showTooltip(target.data, target, false, "standard", 3, 3, 0, null, null, itemTooltipSettings);
                        }
                        else
                        {
                            this.uiApi.showTooltip(target.data, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPRIGHT, 0, "itemName", null, itemTooltipSettings, "ItemInfo");
                        };
                    }
                    else
                    {
                        if (target.name.indexOf("btn_item") != -1)
                        {
                            sellItem = this._sellItemFromItemNameLabel[target];
                            if (((((sellItem) && (sellItem.criterion))) && ((sellItem.criterion.inlineCriteria.length > 0))))
                            {
                                this.uiApi.showTooltip(sellItem.criterion, target, false, "standard", pos.point, pos.relativePoint, offset, "sellCriterion");
                            };
                        };
                    };
            };
            if (info)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info), target, false, "standard", pos.point, pos.relativePoint, offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            var e:*;
            switch (target)
            {
                case this.gd_shop:
                    _local_4 = this.gd_shop.selectedItem;
                    switch (selectMethod)
                    {
                        case 0:
                            this.sysApi.log(2, "select item shop");
                            this.sysApi.dispatchHook(ClickItemStore, _local_4, this._tokenType);
                            break;
                        case 1:
                            break;
                    };
                    break;
                case this.cbFilter:
                    if (((isNewSelection) && (!((selectMethod == 2)))))
                    {
                        e = target.value;
                        this._subFilterIndex[this._currentFilterBtn.name] = target.value.filterType;
                        this.updateStockInventory();
                    };
                    break;
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
        }

        public function onItemUseOnCell(item:Object):void
        {
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target.name.indexOf("slot_") != -1)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.searchCtr.visible) && (this.searchInput.haveFocus)))
            {
                if (this.searchInput.text.length > 2)
                {
                    this._searchCriteria = this.searchInput.text.toLowerCase();
                    this.updateStockInventory();
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this._searchCriteria = null;
                    };
                    this.gd_shop.dataProvider = new Array();
                };
            };
        }

        private function showTransfertUI(pInterface:String, pShow:Boolean=true):void
        {
            if (((pShow) && (!(this.uiApi.getUi(pInterface)))))
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
            };
            if (((!(pShow)) && (this.uiApi.getUi(pInterface))))
            {
                this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_CLOSE);
            };
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.sysApi.dispatchHook(CloseStore);
            };
            return (false);
        }

        private function onCloseInventory():void
        {
            this.sysApi.dispatchHook(CloseStore);
        }

        private function shopStockSort(a:Object, b:Object):int
        {
            if (a.price < b.price)
            {
                return (-1);
            };
            if (a.price > b.price)
            {
                return (1);
            };
            if (a.item.typeId < b.item.typeId)
            {
                return (-1);
            };
            if (a.item.typeId > b.item.typeId)
            {
                return (1);
            };
            if (a.name < b.name)
            {
                return (-1);
            };
            if (a.name > b.name)
            {
                return (1);
            };
            return (0);
        }

        private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int):void
        {
            if ((((item.objectGID == this._tokenType)) && (this.btn_filter.selected)))
            {
                this.updateStockInventory();
            };
        }

        private function onObjectDeleted(item:ItemWrapper):void
        {
            if ((((item.objectGID == this._tokenType)) && (this.btn_filter.selected)))
            {
                this.updateStockInventory();
            };
        }


    }
}//package ui

