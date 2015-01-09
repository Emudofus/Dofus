package ui
{
    import flash.utils.Dictionary;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Grid;
    import d2components.ComboBox;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.Input;
    import d2components.EntityDisplayer;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.StorageApi;
    import d2api.ContextMenuApi;
    import d2api.TooltipApi;
    import d2api.DataApi;
    import d2api.AveragePricesApi;
    import d2api.SoundApi;
    import d2api.UtilApi;
    import d2api.PlayedCharacterApi;
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import ui.behavior.IStorageBehavior;
    import d2hooks.KeyUp;
    import d2hooks.DropStart;
    import d2hooks.DropEnd;
    import flash.geom.ColorTransform;
    import flash.events.TimerEvent;
    import d2enums.SoundTypeEnum;
    import d2enums.SelectMethodEnum;
    import d2enums.LocationEnum;
    import d2utils.ItemTooltipSettings;
    import util.StorageBehaviorManager;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import __AS3__.vec.*;

    public class AbstractStorageUi 
    {

        public static const ALL_CATEGORY:int = -1;
        public static const EQUIPEMENT_CATEGORY:int = 0;
        public static const CONSUMABLES_CATEGORY:int = 1;
        public static const RESSOURCES_CATEGORY:int = 2;
        public static const QUEST_CATEGORY:int = 3;
        public static const OTHER_CATEGORY:int = 4;
        public static const SUBFILTER_ID_TOKEN:int = 148;
        public static const SUBFILTER_ID_PRECIOUS_STONE:int = 50;
        protected static const SORT_ON_WEIGHT:int = 2;
        protected static const SORT_ON_QTY:int = 3;
        protected static const SORT_ON_NAME:int = 1;
        protected static const SORT_ON_DEFAULT:int = 0;
        protected static const SORT_ON_NONE:int = -1;
        protected static const SORT_ON_LOT_WEIGHT:int = 4;
        protected static const SORT_ON_AVERAGEPRICE:int = 5;
        protected static const SORT_ON_LOT_AVERAGEPRICE:int = 6;
        protected static const SORT_ON_LEVEL:int = 7;
        protected static const SORT_ON_ITEM_TYPE:int = 8;
        protected static var _tabFilter:Dictionary = new Dictionary();

        public var mainCtr:GraphicContainer;
        public var commonCtr:GraphicContainer;
        public var kamaCtr:GraphicContainer;
        public var txBackground:Texture;
        public var txWeightBar:Texture;
        public var grid:Grid;
        public var cbFilter:ComboBox;
        public var lblKama:Label;
        public var lblTitle:Label;
        public var btnClose:ButtonContainer;
        public var btnMoveAll:ButtonContainer;
        public var btnAll:ButtonContainer;
        public var btnEquipable:ButtonContainer;
        public var btnConsumables:ButtonContainer;
        public var btnRessources:ButtonContainer;
        public var btnQuest:ButtonContainer;
        public var btnCheckCraft:ButtonContainer;
        public var btnSearch:ButtonContainer;
        public var searchCtr:GraphicContainer;
        public var searchInput:Input;
        public var playerLook:EntityDisplayer;
        public var estimatedValueCtr:GraphicContainer;
        public var lblItemsEstimatedValue:Label;
        public var txKamaEstimatedValue:Texture;
        public var txKamaBackground:Texture;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var storageApi:StorageApi;
        public var menuApi:ContextMenuApi;
        public var tooltipApi:TooltipApi;
        public var dataApi:DataApi;
        public var averagePricesApi:AveragePricesApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var soundApi:SoundApi;
        public var utilApi:UtilApi;
        public var playerApi:PlayedCharacterApi;
        public var itemsDisplayed:Vector.<uint>;
        private var _inventory:Object;
        private var _currentCategoryFilter:int;
        private var _currentTooltipedData;
        private var _updateTimer:Timer;
        private var _delayUseObject:Boolean = false;
        private var _delayUseObjectTimer:Timer;
        private var _hasWorldInteraction:Boolean;
        private var _gridAllowDrop:Dictionary;
        private var _sorts:Array;
        private var _currentSort:int = -1;
        private var _searchCategory:Dictionary;
        private var _sortCategory:Dictionary;
        protected var _storageBehavior:IStorageBehavior;
        protected var _storageBehaviorName:String;
        public var subFilterIndex:Object;
        protected var _dataProvider:Object;
        protected var _searchCriteria:String;
        protected var _lastSearchCriteria:String;
        protected var _searchTimer:Timer;
        protected var _weight:uint;
        protected var _weightMax:uint;
        protected var _hasSlot:Boolean = false;
        protected var _slotsMax:uint;
        protected var _ignoreQuestItems:Boolean = false;

        public function AbstractStorageUi()
        {
            this._gridAllowDrop = new Dictionary();
            this._searchCategory = new Dictionary();
            this._sortCategory = new Dictionary();
            this.subFilterIndex = new Object();
            super();
        }

        public function getWeightMax():uint
        {
            return (this._weightMax);
        }

        public function getWeight():uint
        {
            return (this._weight);
        }

        public function set categoryFilter(category:int):void
        {
            this.saveTabState();
            if (((!(this.questVisible)) && ((category == QUEST_CATEGORY))))
            {
                category = EQUIPEMENT_CATEGORY;
            };
            this._currentCategoryFilter = category;
            this.resumeTabState();
            var button:ButtonContainer = this.getButtonFromCategory(category);
            button.selected = true;
            if (this.subFilter != 0)
            {
                this.subFilter = this.subFilter;
            }
            else
            {
                if (_tabFilter[category])
                {
                    this.subFilter = _tabFilter[category];
                }
                else
                {
                    this.subFilter = -1;
                };
            };
        }

        private function resumeTabState():void
        {
            var oldCategory:Object;
            if (this.searchCtr.visible)
            {
                oldCategory = this._searchCategory[this._currentCategoryFilter];
                if (((oldCategory) && (!((oldCategory == this._currentCategoryFilter)))))
                {
                    this.searchInput.text = this._searchCategory[this._currentCategoryFilter];
                }
                else
                {
                    this.searchInput.text = "";
                };
                this._searchCriteria = this._searchCategory[this._currentCategoryFilter];
            }
            else
            {
                if (((!(oldCategory)) && (!((this._currentCategoryFilter == ALL_CATEGORY)))))
                {
                    this._searchCriteria = "";
                };
            };
            var oldSort:Object = this._sortCategory[this._currentCategoryFilter];
            if (((oldSort) && (!((oldSort == this._currentSort)))))
            {
                this._currentSort = int(oldSort);
                this.sortOn(int(oldSort));
            }
            else
            {
                if (((!(oldSort)) && (!((this._currentSort == SORT_ON_NONE)))))
                {
                    this._currentSort = -1;
                    this.sortOn(SORT_ON_NONE);
                };
            };
        }

        private function saveTabState():void
        {
            this._searchCategory[this._currentCategoryFilter] = this._searchCriteria;
            this._sortCategory[this._currentCategoryFilter] = this._currentSort;
        }

        public function get categoryFilter():int
        {
            return (this._currentCategoryFilter);
        }

        public function set subFilter(filter:int):void
        {
            var button:ButtonContainer = this.getButtonFromCategory(this.categoryFilter);
            this.subFilterIndex[button.name] = filter;
        }

        public function get subFilter():int
        {
            var button:ButtonContainer = this.getButtonFromCategory(this.categoryFilter);
            return (this.subFilterIndex[button.name]);
        }

        public function get currentStorageBehavior():IStorageBehavior
        {
            return (this._storageBehavior);
        }

        public function set questVisible(quest:Boolean):void
        {
            this.btnQuest.visible = quest;
            if (((!(this.btnQuest.visible)) && ((this.categoryFilter == QUEST_CATEGORY))))
            {
                this.categoryFilter = EQUIPEMENT_CATEGORY;
            };
        }

        public function get questVisible():Boolean
        {
            return (this.btnQuest.visible);
        }

        public function get kamas():int
        {
            return (this.utilApi.stringToKamas(this.lblKama.text, ""));
        }

        public function main(param:Object):void
        {
            var value:int;
            this.initSound();
            this._sorts = new Array();
            this._sorts[SORT_ON_NAME] = this.uiApi.getText("ui.common.sortBy.name");
            this._sorts[SORT_ON_WEIGHT] = this.uiApi.getText("ui.common.sortBy.weight");
            this._sorts[SORT_ON_LOT_WEIGHT] = this.uiApi.getText("ui.common.sortBy.weight.lot");
            this._sorts[SORT_ON_QTY] = this.uiApi.getText("ui.common.sortBy.quantity");
            this._sorts[SORT_ON_AVERAGEPRICE] = this.uiApi.getText("ui.common.sortBy.averageprice");
            this._sorts[SORT_ON_LOT_AVERAGEPRICE] = this.uiApi.getText("ui.common.sortBy.averageprice.lot");
            this._sorts[SORT_ON_LEVEL] = this.uiApi.getText("ui.common.sortBy.level");
            this._sorts[SORT_ON_ITEM_TYPE] = this.uiApi.getText("ui.common.sortBy.category");
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            this.sysApi.addHook(DropStart, this.onDropStart);
            this.sysApi.addHook(DropEnd, this.onDropEnd);
            this.uiApi.addComponentHook(this.btnSearch, "onRelease");
            this.uiApi.addComponentHook(this.btnSearch, "onDoubleClick");
            this.uiApi.addComponentHook(this.btnAll, "onRelease");
            this.uiApi.addComponentHook(this.btnAll, "onRollOver");
            this.uiApi.addComponentHook(this.btnAll, "onRollOut");
            this.uiApi.addComponentHook(this.btnSearch, "onRollOver");
            this.uiApi.addComponentHook(this.btnSearch, "onRollOut");
            this.uiApi.addComponentHook(this.btnEquipable, "onRelease");
            this.uiApi.addComponentHook(this.btnEquipable, "onRollOver");
            this.uiApi.addComponentHook(this.btnEquipable, "onRollOut");
            this.uiApi.addComponentHook(this.btnConsumables, "onRelease");
            this.uiApi.addComponentHook(this.btnConsumables, "onRollOver");
            this.uiApi.addComponentHook(this.btnConsumables, "onRollOut");
            this.uiApi.addComponentHook(this.btnRessources, "onRelease");
            this.uiApi.addComponentHook(this.btnRessources, "onRollOver");
            this.uiApi.addComponentHook(this.btnRessources, "onRollOut");
            this.uiApi.addComponentHook(this.btnQuest, "onRelease");
            this.uiApi.addComponentHook(this.btnQuest, "onRollOver");
            this.uiApi.addComponentHook(this.btnQuest, "onRollOut");
            this.uiApi.addComponentHook(this.btnCheckCraft, "onRelease");
            this.uiApi.addComponentHook(this.btnCheckCraft, "onRollOver");
            this.uiApi.addComponentHook(this.btnCheckCraft, "onRollOut");
            this.uiApi.addComponentHook(this.cbFilter, "onSelectItem");
            this.uiApi.addComponentHook(this.kamaCtr, "onRelease");
            this.uiApi.addComponentHook(this.btnClose, "onRelease");
            this.uiApi.addComponentHook(this.txWeightBar, "onRollOver");
            this.uiApi.addComponentHook(this.txWeightBar, "onRollOut");
            this.uiApi.addComponentHook(this.btnMoveAll, "onRollOver");
            this.uiApi.addComponentHook(this.btnMoveAll, "onRollOut");
            this.uiApi.addComponentHook(this.grid, "onItemRightClick");
            this.uiApi.addComponentHook(this.grid, "onItemRollOver");
            this.uiApi.addComponentHook(this.grid, "onItemRollOut");
            this.uiApi.addComponentHook(this.grid, "onSelectItem");
            this.uiApi.addShortcutHook("closeUi", this.onShortCut);
            this.grid.renderer.dropValidatorFunction = this.dropValidator;
            this.grid.renderer.processDropFunction = this.processDrop;
            this.grid.renderer.removeDropSourceFunction = this.removeDropSourceFunction;
            this.questVisible = true;
            this.grid.renderer.allowDrop = true;
            this.btnMoveAll.visible = false;
            if (((this._hasSlot) && (!((this._slotsMax == 0)))))
            {
                value = Math.floor(((100 * this._inventory.length) / this._slotsMax));
                this.txWeightBar.gotoAndStop = (((value > 100)) ? 100 : value);
            };
            this.switchBehavior(param.storageMod);
            this.txKamaEstimatedValue.colorTransform(new ColorTransform(0.1, 0.1, 0.1, 1, 150, 150, 150));
        }

        public function unload():void
        {
            this._searchCriteria = null;
            this._lastSearchCriteria = null;
            if (this._searchTimer)
            {
                this._searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
                this._searchTimer = null;
            };
            if (this._updateTimer)
            {
                this._updateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onUpdateTimerComplete);
                this._updateTimer = null;
            };
            if (this.uiApi.getUi("quantityPopup"))
            {
                this.uiApi.unloadUi("quantityPopup");
            };
            if (this._storageBehavior)
            {
                this._storageBehavior.onUnload();
            };
            this._storageBehavior.detach();
            this._storageBehavior = null;
            this.soundApi.playSound(SoundTypeEnum.INVENTORY_CLOSE);
            this.uiApi.hideTooltip();
            this.uiApi.unloadUi("livingObject");
            if (this.uiApi.getUi("checkCraft"))
            {
                this.uiApi.unloadUi("checkCraft");
            };
            if (this._hasWorldInteraction)
            {
                Api.system.enableWorldInteraction();
            };
        }

        protected function onInventoryUpdate(items:Object, kama:uint):void
        {
            this._inventory = items;
            if (((((((this.cbFilter) && (this.cbFilter.dataProvider))) && (((!(this._inventory)) || (!(this._inventory.length)))))) && (!((this.subFilter == -1)))))
            {
                this.cbFilter.selectedItem = this.cbFilter.dataProvider[0];
                this.onSelectItem(this.cbFilter, SelectMethodEnum.CLICK, true);
                return;
            };
            this.onKamasUpdate(kama);
            if (!(this._updateTimer))
            {
                this._updateTimer = new Timer(50, 1);
                this._updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onUpdateTimerComplete);
            };
            if (!(this._updateTimer.running))
            {
                this._updateTimer.start();
            };
        }

        protected function onKamasUpdate(kama:uint):void
        {
            this.lblKama.text = this.utilApi.kamasToString(kama, "");
        }

        protected function onInventoryWeight(currentWeight:uint, maxWeight:uint):void
        {
            var value:int;
            this._weight = currentWeight;
            this._weightMax = maxWeight;
            if (this.txWeightBar)
            {
                value = Math.floor(((100 * currentWeight) / maxWeight));
                if (value > 100)
                {
                    value = 100;
                };
                this.txWeightBar.gotoAndStop = value;
            };
        }

        protected function onUpdateTimerComplete(e:TimerEvent):void
        {
            this._updateTimer.reset();
            this.updateInventory();
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.searchCtr.visible) && (this.searchInput.haveFocus)))
            {
                if (this.searchInput.text.length)
                {
                    this._searchCriteria = this.utilApi.noAccent(this.searchInput.text).toLowerCase();
                }
                else
                {
                    if (this._searchCriteria)
                    {
                        this._searchCriteria = null;
                        this._lastSearchCriteria = null;
                    };
                };
                this._searchTimer.reset();
                this._searchTimer.start();
            };
        }

        protected function onDropStart(src:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                this._hasWorldInteraction = Api.system.hasWorldInteraction();
                if (this._hasWorldInteraction)
                {
                    Api.system.disableWorldInteraction();
                };
            };
        }

        protected function onDropEnd(src:Object):void
        {
            if (src.getUi() == this.uiApi.me())
            {
                if (this._hasWorldInteraction)
                {
                    Api.system.enableWorldInteraction();
                };
            };
        }

        protected function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (this._storageBehavior.dropValidator(target, data, source));
        }

        protected function processDrop(target:Object, data:Object, source:Object):void
        {
            return (this._storageBehavior.processDrop(target, data, source));
        }

        protected function removeDropSourceFunction(target:Object):void
        {
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnAll:
                case this.btnEquipable:
                case this.btnConsumables:
                case this.btnRessources:
                    this.setDropAllowed(true, "filter");
                    this.onReleaseCategoryFilter((target as ButtonContainer));
                    break;
                case this.btnCheckCraft:
                    this.OnReleaseCheckCraftBtn();
                    break;
                case this.btnSearch:
                    this.onReleaseSearchBtn();
                    break;
                case this.btnClose:
                    this.onClose();
                    break;
                default:
                    this._storageBehavior.onRelease(target);
            };
        }

        public function onDoubleClick(target:Object):void
        {
            switch (target)
            {
                case this.btnSearch:
                    this.onReleaseSearchBtn();
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            switch (target)
            {
                case this.btnAll:
                    text = this.uiApi.getText("ui.common.all");
                    break;
                case this.btnEquipable:
                    text = this.uiApi.getText("ui.common.equipement");
                    break;
                case this.btnConsumables:
                    text = this.uiApi.getText("ui.common.usableItems");
                    break;
                case this.btnRessources:
                    text = this.uiApi.getText("ui.common.ressources");
                    break;
                case this.btnQuest:
                    text = this.uiApi.getText("ui.common.quest.objects");
                    break;
                case this.btnSearch:
                    text = this.uiApi.getText("ui.common.sortOrSearch");
                    break;
                case this.btnMoveAll:
                    text = this.uiApi.getText("ui.storage.advancedTransferts");
                    break;
                case this.txWeightBar:
                    if (this._hasSlot)
                    {
                        text = this.uiApi.getText("ui.common.player.slot", (((this._slotsMax <= 0)) ? "0" : this.utilApi.kamasToString(this._inventory.length, "")), this.utilApi.kamasToString(this._slotsMax, ""));
                    }
                    else
                    {
                        text = this.uiApi.getText("ui.common.player.weight", this.utilApi.kamasToString(this._weight, ""), this.utilApi.kamasToString(this._weightMax, ""));
                    };
                    break;
                case this.lblItemsEstimatedValue:
                    text = this.uiApi.getText("ui.storage.estimatedValue");
                    break;
                case this.lblKama:
                    text = this.uiApi.getText("ui.storage.ownedKamas");
                    break;
                case this.btnCheckCraft:
                    text = this.uiApi.getText("ui.craft.possibleRecipesTitle");
                    break;
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var e:Object;
            switch (target)
            {
                case this.cbFilter:
                    if (((((isNewSelection) && (!((selectMethod == SelectMethodEnum.AUTO))))) && (!((selectMethod == SelectMethodEnum.MANUAL)))))
                    {
                        e = target.value;
                        this.subFilter = e.filterType;
                        _tabFilter[this.categoryFilter] = e.filterType;
                        this.releaseHooks();
                    };
                    return;
                default:
                    this._storageBehavior.onSelectItem(target, selectMethod, isNewSelection);
            };
        }

        public function onItemRightClick(target:Object, item:Object):void
        {
            if (item.data == null)
            {
                return;
            };
            var data:Object = item.data;
            var contextMenu:Object = this.menuApi.create(data);
            var disabled:Boolean = contextMenu.content[0].disabled;
            this.fillContextMenu(contextMenu, data, disabled);
            this.uiApi.hideTooltip();
            this.modContextMenu.createContextMenu(contextMenu);
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                this.displayItemTooltip(item.container, item.data);
            };
        }

        protected function displayItemTooltip(target:Object, item:Object, settings:Object=null):void
        {
            var setting:String;
            if (!(settings))
            {
                settings = new Object();
            };
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
            if (itemTooltipSettings == null)
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
            };
            for each (setting in this.sysApi.getObjectVariables(itemTooltipSettings))
            {
                settings[setting] = itemTooltipSettings[setting];
            };
            this.uiApi.showTooltip(item, target, false, "standard", LocationEnum.POINT_BOTTOMRIGHT, LocationEnum.POINT_TOPLEFT, 0, "itemName", null, settings, "ItemInfo");
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            this.uiApi.hideTooltip();
        }

        protected function onShortCut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                if (this.searchCtr.visible)
                {
                    this.onRelease(this.btnSearch);
                }
                else
                {
                    this.uiApi.unloadUi(this.uiApi.me().name);
                };
                return (true);
            };
            return (false);
        }

        public function getButtonFromCategory(category:int):ButtonContainer
        {
            switch (category)
            {
                case ALL_CATEGORY:
                    return (this.btnAll);
                case EQUIPEMENT_CATEGORY:
                    return (this.btnEquipable);
                case CONSUMABLES_CATEGORY:
                    return (this.btnConsumables);
                case RESSOURCES_CATEGORY:
                    return (this.btnRessources);
                default:
                    throw (new Error(("Invalid category : " + category)));
            };
        }

        public function getCategoryFromButton(button:ButtonContainer):int
        {
            switch (button)
            {
                case this.btnAll:
                    return (ALL_CATEGORY);
                case this.btnEquipable:
                    return (EQUIPEMENT_CATEGORY);
                case this.btnConsumables:
                    return (CONSUMABLES_CATEGORY);
                case this.btnRessources:
                    return (RESSOURCES_CATEGORY);
                default:
                    throw (new Error(("Invalid button : " + button)));
            };
        }

        public function switchBehavior(behaviorName:String):void
        {
            if (this._storageBehavior)
            {
                this._storageBehavior.detach();
            };
            this._storageBehavior = StorageBehaviorManager.makeBehavior(behaviorName);
            this._storageBehavior.attach(this);
            this._storageBehaviorName = behaviorName;
        }

        public function updateInventory():void
        {
            var item:Object;
            var l:int;
            var i:int;
            var filteredInventory:Array;
            var reusingDataProvider:Boolean;
            var inventory:*;
            var value:int;
            if (this._inventory)
            {
                filteredInventory = new Array();
                this.itemsDisplayed = new Vector.<uint>();
                this.updateSubFilter(this.getStorageTypes(this.categoryFilter));
                if (this._searchCriteria)
                {
                    reusingDataProvider = ((((this._lastSearchCriteria) && ((this._lastSearchCriteria.length < this._searchCriteria.length)))) && (!((this._searchCriteria.indexOf(this._lastSearchCriteria) == -1))));
                    inventory = ((reusingDataProvider) ? this.grid.dataProvider : this._inventory);
                    l = inventory.length;
                    i = 0;
                    for (;i < l;i++)
                    {
                        item = inventory[i];
                        if (((this._ignoreQuestItems) && (!(reusingDataProvider))))
                        {
                            if (item.category == QUEST_CATEGORY)
                            {
                                continue;
                            };
                        };
                        if (item.undiatricalName.indexOf(this._searchCriteria) != -1)
                        {
                            filteredInventory.push(item);
                            this.itemsDisplayed.push(item.objectUID);
                        };
                    };
                    this.grid.dataProvider = filteredInventory;
                    this._lastSearchCriteria = this._searchCriteria;
                }
                else
                {
                    l = this._inventory.length;
                    i = 0;
                    for (;i < l;i++)
                    {
                        item = this._inventory[i];
                        if (this._ignoreQuestItems)
                        {
                            if (item.category == QUEST_CATEGORY)
                            {
                                continue;
                            };
                            filteredInventory.push(item);
                        };
                        this.itemsDisplayed.push(item.objectUID);
                    };
                    if (this._ignoreQuestItems)
                    {
                        this._inventory = filteredInventory;
                    };
                    this.grid.dataProvider = this._inventory;
                    this._lastSearchCriteria = null;
                };
                this._ignoreQuestItems = false;
                if (((this._hasSlot) && (!((this._slotsMax == 0)))))
                {
                    value = Math.floor(((100 * this._inventory.length) / this._slotsMax));
                    this.txWeightBar.gotoAndStop = (((value > 100)) ? 100 : value);
                };
                this.updateItemsEstimatedValue();
            };
        }

        public function name():String
        {
            return (this.uiApi.me().name);
        }

        protected function releaseHooks():void
        {
            throw (new Error("Error : releaseHooks is an abstract method. It's shouldn't be called"));
        }

        public function setDropAllowed(allow:Boolean, category:String):void
        {
            var eachAllow:Boolean;
            this._gridAllowDrop[category] = allow;
            for each (eachAllow in this._gridAllowDrop)
            {
                if (!(eachAllow))
                {
                    this.grid.renderer.allowDrop = false;
                    return;
                };
            };
            this.grid.renderer.allowDrop = true;
        }

        protected function onReleaseCategoryFilter(target:ButtonContainer):void
        {
            this._lastSearchCriteria = null;
            this.categoryFilter = this.getCategoryFromButton(target);
            this.releaseHooks();
        }

        protected function onReleaseSearchBtn():void
        {
            this.searchCtr.visible = !(this.searchCtr.visible);
            this.cbFilter.visible = !(this.searchCtr.visible);
            if (this.searchCtr.visible)
            {
                this._searchCriteria = this._searchCategory[this._currentCategoryFilter];
                this.searchInput.focus();
                this.searchInput.text = this._searchCriteria;
                if (!(this._searchTimer))
                {
                    this._searchTimer = new Timer(200, 1);
                    this._searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
                };
                if (this._searchCriteria)
                {
                    this._searchTimer.start();
                };
            }
            else
            {
                this._searchCriteria = null;
                this._lastSearchCriteria = null;
                this.searchInput.text = "";
                this._searchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSearchTimerComplete);
                this._searchTimer = null;
                this.updateInventory();
            };
        }

        protected function OnReleaseCheckCraftBtn():void
        {
            var checkCraftUi:Object = this.uiApi.getUi("checkCraft");
            if (!(checkCraftUi))
            {
                this.uiApi.loadUi("Ankama_Job::checkCraft", "checkCraft", {"storage":this._storageBehaviorName});
            }
            else
            {
                if (checkCraftUi.uiClass.storage != this._storageBehaviorName)
                {
                    checkCraftUi.uiClass.main({"storage":this._storageBehaviorName});
                }
                else
                {
                    this.uiApi.unloadUi("checkCraft");
                };
            };
        }

        protected function onClose():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        protected function fillContextMenu(contextMenu:Object, data:Object, disabled:Boolean):void
        {
            var secondarySorts:Array;
            var sort:*;
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
            if (!(itemTooltipSettings))
            {
                itemTooltipSettings = this.tooltipApi.createItemSettings();
                this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
            };
            if (contextMenu.content.length)
            {
                contextMenu.content.push(this.modContextMenu.createContextMenuSeparatorObject());
            };
            if (Api.system.getOption("displayTooltips", "dofus"))
            {
                contextMenu.content.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.tooltip"), null, null, false, [this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.name"), this.onTooltipDisplayOption, ["header"], disabled, null, itemTooltipSettings.header, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "", false), this.onTooltipDisplayOption, ["effects"], disabled, null, itemTooltipSettings.effects, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.conditions"), this.onTooltipDisplayOption, ["conditions"], disabled, null, itemTooltipSettings.conditions, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.description"), this.onTooltipDisplayOption, ["description"], disabled, null, itemTooltipSettings.description, false), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.item.averageprice"), this.onTooltipDisplayOption, ["averagePrice"], disabled, null, itemTooltipSettings.averagePrice, false)], disabled));
            };
            var sortField:int = this.getSortFields()[0];
            var sortMenu:Object = this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort"), null, null, false, null, disabled);
            var sortMenuChildren:Array = new Array();
            sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sortBy.default"), this.updateSort, [SORT_ON_NONE], disabled, null, (sortField == SORT_ON_NONE), true));
            for (sort in this._sorts)
            {
                sortMenuChildren.push(this.modContextMenu.createContextMenuItemObject(this._sorts[sort], this.updateSort, [sort], disabled, null, (sortField == sort), true));
                if (((!((sortField == SORT_ON_NONE))) && (!((sort == sortField)))))
                {
                    if (!(secondarySorts))
                    {
                        secondarySorts = new Array();
                    };
                    secondarySorts.push(this.modContextMenu.createContextMenuItemObject(this._sorts[sort], this.addSort, [sort], false, null, !((this.getSortFields().indexOf(sort) == -1)), true));
                };
            };
            sortMenuChildren.push(this.modContextMenu.createContextMenuSeparatorObject(), this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.sort.secondary"), null, null, (sortField == SORT_ON_NONE), secondarySorts, false));
            sortMenu.child = sortMenuChildren;
            contextMenu.content.push(sortMenu);
        }

        protected function getSortFields():Object
        {
            throw (new Error("getSortField is abstract function, it must be implemented"));
        }

        protected function getStorageTypes(categoryFilter:int):Object
        {
            throw (new Error("Error : getStorageTypes is abstract function. It must be override"));
        }

        protected function initSound():void
        {
            this.btnAll.soundId = SoundEnum.TAB;
            this.btnSearch.soundId = SoundEnum.CHECKBOX_CHECKED;
            this.btnEquipable.soundId = SoundEnum.TAB;
            this.btnConsumables.soundId = SoundEnum.TAB;
            this.btnRessources.soundId = SoundEnum.TAB;
            this.btnClose.isMute = true;
        }

        private function onTooltipDisplayOption(field:String):void
        {
            var itemTooltipSettings:ItemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
            itemTooltipSettings[field] = !(itemTooltipSettings[field]);
            this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
        }

        protected function updateSubFilter(types:Object):void
        {
            var selectedItem:Object;
            var tmp:Object;
            var type:Object;
            var cbProvider:Array = new Array();
            for each (type in types)
            {
                tmp = {
                    "label":type.name,
                    "filterType":type.id
                };
                if (type.id == this.subFilterIndex[this.getButtonFromCategory(this.categoryFilter).name])
                {
                    selectedItem = tmp;
                };
                cbProvider.push(tmp);
            };
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
            if (this.cbFilter.value != selectedItem)
            {
                this.cbFilter.value = selectedItem;
            };
        }

        private function updateItemsEstimatedValue():void
        {
            var item:Object;
            var averagePrice:int;
            var itemsValue:Number = 0;
            for each (item in this.grid.dataProvider)
            {
                averagePrice = this.averagePricesApi.getItemAveragePrice(item.objectGID);
                itemsValue = (itemsValue + (averagePrice * item.quantity));
            };
            this.lblItemsEstimatedValue.text = this.utilApi.kamasToString(itemsValue, "");
        }

        private function updateSort(property:int, numeric:Boolean=false):void
        {
            this._currentSort = property;
            this.sortOn(property, numeric);
        }

        protected function sortOn(property:int, numeric:Boolean=false):void
        {
            throw (new Error("sortOn is an abstract method, it shouldn't be called"));
        }

        protected function addSort(property:int):void
        {
            throw (new Error("addSort is an abstract method, it shouldn't be called"));
        }

        private function onSearchTimerComplete(e:TimerEvent):void
        {
            this._searchTimer.reset();
            this.updateInventory();
        }


    }
}//package ui

