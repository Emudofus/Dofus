package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.ContextMenuApi;
   import d2api.TooltipApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Input;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.Texture;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import d2network.ObjectItemToSellInBid;
   import d2hooks.OpenBidHouse;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.BidObjectTypeListUpdate;
   import d2hooks.SellerObjectListUpdate;
   import d2hooks.LeaveDialog;
   import d2hooks.KeyUp;
   import d2enums.ComponentHookList;
   import flash.events.TimerEvent;
   import d2actions.BidHouseStringSearch;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2actions.ExchangeBidHouseSearch;
   import d2actions.ExchangeBidHouseList;
   import d2actions.ExchangeBidHouseType;
   import d2actions.LeaveShopStock;
   import d2actions.BidSwitchToBuyerMode;
   import d2actions.BidSwitchToSellerMode;
   import d2utils.ItemTooltipSettings;
   import d2enums.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2actions.CloseInventory;
   
   public class StockBidHouse extends Object
   {
      
      public function StockBidHouse() {
         this._filterAssoc = new Object();
         this._subFilterIndex = new Object();
         this._slotList = new Dictionary(true);
         super();
      }
      
      public static const EQUIPEMENT_CATEGORY:uint = 0;
      
      public static const CONSUMABLES_CATEGORY:uint = 1;
      
      public static const RESSOURCES_CATEGORY:uint = 2;
      
      public static const ALL_CATEGORY:uint = 4.294967295E9;
      
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
      
      public var tooltipApi:TooltipApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var searchCtr:GraphicContainer;
      
      public var catCtr:GraphicContainer;
      
      public var ctr_filters:GraphicContainer;
      
      public var ctr_content:GraphicContainer;
      
      public var ctr_bottomInfos:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_quantityObject:Label;
      
      public var lbl_sumPrices:Label;
      
      public var searchInput:Input;
      
      public var btnSearch:ButtonContainer;
      
      public var btnAll:ButtonContainer;
      
      public var btnEquipable:ButtonContainer;
      
      public var btnConsumables:ButtonContainer;
      
      public var btnRessources:ButtonContainer;
      
      public var btn_info:ButtonContainer;
      
      public var btnClose:ButtonContainer;
      
      public var gd_shop:Grid;
      
      public var cbFilter:ComboBox;
      
      public var tx_icon:Texture;
      
      public var btn_center:ButtonContainer;
      
      public var btn_lbl_btn_center:Label;
      
      private var _sellerBuyerDescriptor:Object;
      
      private var _currentTypeObject:int;
      
      protected var _searchCriteria:String;
      
      protected var _searchResult:Array;
      
      protected var _filterAssoc:Object;
      
      protected var _subFilterIndex:Object;
      
      protected var _itemsStock:Array;
      
      protected var _category:Array;
      
      protected var _currentFilterBtn:Object;
      
      private var _bidTooltipText:String = "";
      
      private var _totalObjectSold:uint;
      
      private var _totalObjectPrice:Number;
      
      private var _slotList:Dictionary;
      
      private var _timer:Timer;
      
      public function main(params:Object) : void {
         var objInSale:ObjectItemToSellInBid = null;
         var nItems:* = 0;
         var i:* = 0;
         this.sysApi.dispatchHook(OpenBidHouse);
         this.btnAll.soundId = SoundEnum.TAB;
         this.btnConsumables.soundId = SoundEnum.TAB;
         this.btnEquipable.soundId = SoundEnum.TAB;
         this.btnRessources.soundId = SoundEnum.TAB;
         this._sellerBuyerDescriptor = params.sellerBuyerDescriptor;
         this.sysApi.addHook(BidObjectTypeListUpdate,this.onBidObjectTypeListUpdate);
         this.sysApi.addHook(SellerObjectListUpdate,this.onSellerObjectListUpdate);
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.searchInput,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.searchInput,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_quantityObject,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_quantityObject,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_sumPrices,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_sumPrices,ComponentHookList.ON_ROLL_OUT);
         this.gd_shop.scrollDisplay = "always";
         this.gd_shop.autoSelectMode = 0;
         this.ctr_filters.visible = false;
         this.ctr_content.y = -37;
         this.ctr_bottomInfos.visible = true;
         this._currentFilterBtn = this.btnAll;
         this._currentFilterBtn.selected = true;
         this._filterAssoc[this.btnEquipable.name] = EQUIPEMENT_CATEGORY;
         this._filterAssoc[this.btnConsumables.name] = CONSUMABLES_CATEGORY;
         this._filterAssoc[this.btnRessources.name] = RESSOURCES_CATEGORY;
         this._filterAssoc[this.btnAll.name] = ALL_CATEGORY;
         this._totalObjectSold = 0;
         this._totalObjectPrice = 0;
         if(params.objectsInfos)
         {
            this._totalObjectSold = params.objectsInfos.length;
            for each(objInSale in params.objectsInfos)
            {
               this._totalObjectPrice = this._totalObjectPrice + objInSale.objectPrice;
            }
         }
         this.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "Illus_marchands.swf|Marchand_tx_Illus_png");
         this.tx_icon.gotoAndStop = 8;
         this._timer = new Timer(2000,1);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this.changeBidTooltip(this._sellerBuyerDescriptor);
         this._itemsStock = new Array();
         this._category = new Array();
         if(params.inventory != null)
         {
            nItems = params.inventory.length;
            i = 0;
            while(i < nItems)
            {
               this.addItemInStock(params.inventory[i],false);
               i++;
            }
            this.updateStockInventory();
         }
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            this.btn_lbl_btn_center.text = this.uiApi.getText("ui.bidhouse.bigStoreModeSell");
         }
         else
         {
            this.btn_lbl_btn_center.text = this.uiApi.getText("ui.bidhouse.bigStoreModeBuy");
         }
         this.changeBidHouseMode(true);
      }
      
      public function updateItemLine(data:*, components:*, selected:Boolean) : void {
         var itemWrapper:Object = null;
         var itemObject:Object = null;
         var newWidthName:uint = 0;
         components.slot_item.allowDrag = false;
         if(data)
         {
            if(!this._slotList[components.slot_item.name])
            {
               this.uiApi.addComponentHook(components.slot_item,"onRightClick");
               this.uiApi.addComponentHook(components.slot_item,"onRollOut");
               this.uiApi.addComponentHook(components.slot_item,"onRollOver");
            }
            this._slotList[components.slot_item.name] = data;
            components.btn_item.selected = selected;
            itemWrapper = data.itemWrapper;
            itemObject = this.dataApi.getItem(itemWrapper.objectGID);
            if((isNaN(Number(data.price))) || (data.price == null) || (data.price == 0))
            {
               components.lbl_ItemPrice.text = "";
            }
            else
            {
               components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price);
            }
            newWidthName = components.lbl_ItemPrice.x + components.lbl_ItemPrice.width - components.lbl_ItemName.x - 10 - components.lbl_ItemPrice.textfield.textWidth;
            components.lbl_ItemName.width = newWidthName;
            components.lbl_ItemName.text = itemWrapper.shortName;
            components.slot_item.data = itemWrapper;
            components.tx_backgroundItem.visible = true;
            if(itemObject.etheral)
            {
               components.lbl_ItemName.cssClass = "itemetheral";
            }
            else if(itemObject.itemSetId != -1)
            {
               components.lbl_ItemName.cssClass = "itemset";
            }
            else
            {
               components.lbl_ItemName.cssClass = "p";
            }
            
         }
         else
         {
            components.lbl_ItemName.text = "";
            components.lbl_ItemPrice.text = "";
            components.slot_item.data = null;
            components.tx_backgroundItem.visible = false;
            components.btn_item.selected = false;
         }
      }
      
      public function changeBidTooltip(sellerBuyerDescriptor:Object) : void {
         var nTypes:int = sellerBuyerDescriptor.types.length;
         var lsTypes:Array = new Array(nTypes);
         var i:int = 0;
         while(i < nTypes)
         {
            lsTypes[i] = this.dataApi.getItemType(sellerBuyerDescriptor.types[i]);
            i++;
         }
         lsTypes.sort();
         var typesList:String = " - " + lsTypes.join("\n - ");
         this._bidTooltipText = this.uiApi.getText("ui.common.maxLevel") + this.uiApi.getText("ui.common.colon") + sellerBuyerDescriptor.maxItemLevel + "\n" + this.uiApi.getText("ui.bidhouse.bigStoreTax") + this.uiApi.getText("ui.common.colon") + sellerBuyerDescriptor.taxPercentage + "%" + "\n" + this.uiApi.getText("ui.bidhouse.bigStoreModificationTax") + this.uiApi.getText("ui.common.colon") + sellerBuyerDescriptor.taxModificationPercentage + "%" + "\n" + this.uiApi.getText("ui.bidhouse.bigStoreMaxItemPerAccount") + this.uiApi.getText("ui.common.colon") + sellerBuyerDescriptor.maxItemPerAccount + "\n" + this.uiApi.getText("ui.bidhouse.bigStoreMaxSellTime") + this.uiApi.getText("ui.common.colon") + sellerBuyerDescriptor.unsoldDelay + " " + this.uiApi.processText(this.uiApi.getText("ui.time.hours"),"n",sellerBuyerDescriptor.unsoldDelay < 2) + "\n\n" + this.uiApi.getText("ui.bidhouse.bigStoreTypes") + " : \n" + typesList;
      }
      
      public function changeBidHouseMode(init:Boolean = false) : void {
         this.searchCtr.visible = false;
         this.catCtr.visible = true;
         this._searchCriteria = null;
         this.searchInput.text = "";
         this.btnSearch.selected = false;
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            if(!init)
            {
               this.uiApi.getUi("itemBidHouseSell").uiClass.displayUi(false);
               this.uiApi.getUi("itemBidHouseBuy").uiClass.displayUi(true);
            }
            this.btn_lbl_btn_center.text = this.uiApi.getText("ui.bidhouse.bigStoreModeSell");
            this.lbl_title.text = this.uiApi.getText("ui.bidhouse.bigStoreItemList");
            this.updateLabelQuantitySoldObject();
            this.comboBoxBuyMode();
            this.btnEquipable.disabled = true;
            this.btnConsumables.disabled = true;
            this.btnRessources.disabled = true;
            this.btnAll.disabled = true;
            this.gd_shop.dataProvider = new Array();
         }
         else
         {
            if(!init)
            {
               this.uiApi.getUi("itemBidHouseSell").uiClass.displayUi(true);
               this.uiApi.getUi("itemBidHouseBuy").uiClass.displayUi(false);
            }
            this.gd_shop.dataProvider = new Array();
            this.btn_lbl_btn_center.text = this.uiApi.getText("ui.bidhouse.bigStoreModeBuy");
            this.lbl_title.text = this.uiApi.getText("ui.common.shopStock");
            this.updateLabelQuantitySoldObject();
            this.btnEquipable.disabled = false;
            this.btnConsumables.disabled = false;
            this.btnRessources.disabled = false;
            this.btnAll.disabled = false;
         }
      }
      
      protected function addItemInStock(pItem:Object, pUpdate:Boolean = true) : void {
         this._itemsStock.push(pItem);
         var cat:Object = this.dataApi.getItem(pItem.itemWrapper.objectGID).category;
         this._category[pItem.itemWrapper.objectUID] = cat;
         if(pUpdate)
         {
            this.selectTab(pItem);
            this.updateStockInventory();
         }
      }
      
      private function comboBoxBuyMode() : void {
         var id:* = 0;
         var nTypes:int = this._sellerBuyerDescriptor.types.length;
         var cbProvider:Array = new Array(nTypes);
         var i:int = 0;
         while(i < nTypes)
         {
            id = this._sellerBuyerDescriptor.types[i];
            cbProvider[i] = 
               {
                  "label":this.dataApi.getItemType(id),
                  "type":id
               };
            i++;
         }
         cbProvider = cbProvider.sortOn("label");
         this.cbFilter.dataProvider = cbProvider;
         this.cbFilter.value = cbProvider[0];
      }
      
      protected function updateCombobox() : void {
         var it:Object = null;
         var cbProvider:Array = null;
         var selectedItem:Object = null;
         var tmp:Object = null;
         var type:Object = null;
         var item:Object = null;
         var types:Array = new Array();
         var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
         for each(it in this._itemsStock)
         {
            item = this.dataApi.getItem(it.itemWrapper.objectGID);
            if((item.category == filter) || (filter == ALL_CATEGORY))
            {
               types[item.typeId] = item.type;
            }
         }
         cbProvider = new Array();
         for each(type in types)
         {
            tmp = 
               {
                  "label":type.name,
                  "filterType":type.id
               };
            if(type.id == this._subFilterIndex[this._currentFilterBtn.name])
            {
               selectedItem = tmp;
            }
            cbProvider.push(tmp);
         }
         cbProvider = cbProvider.sort();
         tmp = 
            {
               "label":this.uiApi.getText("ui.common.allTypesForObject"),
               "filterType":-1
            };
         if(!selectedItem)
         {
            selectedItem = tmp;
         }
         cbProvider.unshift(tmp);
         this.cbFilter.dataProvider = cbProvider;
         this.cbFilter.value = selectedItem;
      }
      
      private function selectTab(pItem:Object) : void {
         var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
         var itemObject:Object = this.dataApi.getItem(pItem.objectGID);
         if((!(itemObject.category == filter)) && (!(filter == ALL_CATEGORY)))
         {
            switch(itemObject.category)
            {
               case EQUIPEMENT_CATEGORY:
                  this._currentFilterBtn = this.btnEquipable;
                  this.btnEquipable.selected = true;
                  break;
               case CONSUMABLES_CATEGORY:
                  this._currentFilterBtn = this.btnConsumables;
                  this.btnConsumables.selected = true;
                  break;
               case RESSOURCES_CATEGORY:
                  this._currentFilterBtn = this.btnRessources;
                  this.btnRessources.selected = true;
                  break;
               default:
                  this._currentFilterBtn = this.btnAll;
                  this.btnAll.selected = true;
            }
         }
      }
      
      protected function updateStockInventory() : void {
         var it:Object = null;
         var item:Object = null;
         var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            this.comboBoxBuyMode();
         }
         else
         {
            this.updateCombobox();
         }
         var result:Array = new Array();
         var types:Array = new Array();
         for each(it in this._itemsStock)
         {
            item = this.dataApi.getItem(it.itemWrapper.objectGID);
            if(((this._category[it.itemWrapper.objectUID] == filter) || (filter == ALL_CATEGORY)) && ((!this.cbFilter.value) || (this.cbFilter.value.filterType == -1) || (this.cbFilter.value.filterType == item.typeId)) && ((!this._searchCriteria) || (!(item.name.toLowerCase().indexOf(this._searchCriteria) == -1))))
            {
               types[item.typeId] = item.type;
               result.push(it);
            }
         }
         this.gd_shop.dataProvider = result;
      }
      
      protected function updateLabelQuantitySoldObject() : void {
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            this.lbl_quantityObject.visible = false;
            this.lbl_sumPrices.visible = false;
         }
         else
         {
            this.lbl_quantityObject.visible = true;
            this.lbl_sumPrices.visible = true;
            this.lbl_quantityObject.text = this._totalObjectSold + "/" + this._sellerBuyerDescriptor.maxItemPerAccount;
            this.lbl_sumPrices.text = this.utilApi.kamasToString(this._totalObjectPrice);
         }
      }
      
      public function onSellerObjectListUpdate(vendorObjects:Object) : void {
         this._totalObjectSold = vendorObjects.length;
         this._totalObjectPrice = 0;
         this._itemsStock = new Array();
         this._category = new Array();
         var nItems:int = vendorObjects.length;
         var i:int = 0;
         while(i < nItems)
         {
            this.addItemInStock(vendorObjects[i],false);
            this._totalObjectPrice = this._totalObjectPrice + vendorObjects[i].price;
            i++;
         }
         this.updateLabelQuantitySoldObject();
         this.updateStockInventory();
      }
      
      public function onBidObjectTypeListUpdate(objectGIDs:Object, refreshEvenIfInSearch:Boolean = false) : void {
         var i:* = 0;
         if((TradeCenter.SEARCH_MODE) && (!refreshEvenIfInSearch))
         {
            return;
         }
         var nTypes:int = objectGIDs.length;
         var items:Array = new Array(nTypes);
         if(TradeCenter.SEARCH_MODE)
         {
            this._searchResult = new Array();
            i = 0;
            while(i < nTypes)
            {
               items[i] = {"itemWrapper":this.dataApi.getItemWrapper(objectGIDs[i])};
               this._searchResult.push({"itemWrapper":this.dataApi.getItemWrapper(objectGIDs[i])});
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < nTypes)
            {
               items[i] = {"itemWrapper":this.dataApi.getItemWrapper(objectGIDs[i].GIDObject)};
               i++;
            }
         }
         items.sort(this.sortShop);
         if((this._searchResult) && (this._searchResult.length))
         {
            this._searchResult.sort(this.sortShop);
         }
         this.gd_shop.dataProvider = items;
      }
      
      private function sortShop(a:Object, b:Object) : int {
         if(a.itemWrapper.level < b.itemWrapper.level)
         {
            return -1;
         }
         if(a.itemWrapper.level > b.itemWrapper.level)
         {
            return 1;
         }
         if(a.itemWrapper.name < b.itemWrapper.name)
         {
            return -1;
         }
         if(a.itemWrapper.name > b.itemWrapper.name)
         {
            return 1;
         }
         return 0;
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.searchCtr)
         {
            if((this.searchCtr.visible) && (this.searchInput.haveFocus))
            {
               if(this.searchInput.text.length > 2)
               {
                  this._searchCriteria = this.searchInput.text.toLowerCase();
               }
               else
               {
                  if(this._searchCriteria)
                  {
                     this._searchCriteria = null;
                  }
                  this.gd_shop.dataProvider = new Array();
               }
               if(this._searchCriteria)
               {
                  if(TradeCenter.BID_HOUSE_BUY_MODE)
                  {
                     this.sysApi.sendAction(new BidHouseStringSearch(this._searchCriteria));
                  }
                  else
                  {
                     this.updateStockInventory();
                  }
               }
            }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         var e:* = undefined;
         switch(target)
         {
            case this.gd_shop:
               if(TradeCenter.BID_HOUSE_BUY_MODE)
               {
                  if(target)
                  {
                     item = this.gd_shop.selectedItem.itemWrapper;
                     if(TradeCenter.SEARCH_MODE)
                     {
                        if(selectMethod != GridItemSelectMethodEnum.AUTO)
                        {
                           this.sysApi.sendAction(new ExchangeBidHouseSearch(this.dataApi.getItem(item.objectGID).typeId,item.objectGID));
                        }
                     }
                     else
                     {
                        this.sysApi.sendAction(new ExchangeBidHouseList(item.objectGID));
                     }
                  }
               }
               else
               {
                  this.uiApi.getUi("itemBidHouseSell").uiClass.onSelectItemFromStockBidHouse(this.gd_shop.selectedItem);
               }
               break;
            case this.cbFilter:
               if(TradeCenter.BID_HOUSE_BUY_MODE)
               {
                  if(target.value.type != 0)
                  {
                     this._currentTypeObject = target.value.type;
                  }
                  this.sysApi.sendAction(new ExchangeBidHouseType(this._currentTypeObject));
               }
               else if((isNewSelection) && (!(selectMethod == 2)))
               {
                  e = target.value;
                  this._subFilterIndex[this._currentFilterBtn.name] = target.value.filterType;
                  this.updateStockInventory();
               }
               
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnEquipable:
            case this.btnConsumables:
            case this.btnRessources:
            case this.btnAll:
               this._currentFilterBtn = target;
               this.updateStockInventory();
               break;
            case this.btnSearch:
               this.searchCtr.visible = !this.searchCtr.visible;
               this.catCtr.visible = !this.searchCtr.visible;
               TradeCenter.SEARCH_MODE = this.searchCtr.visible;
               if(TradeCenter.SEARCH_MODE)
               {
                  this._searchCriteria = this.searchInput.text.toLowerCase();
                  this.searchInput.focus();
                  this.tx_icon.gotoAndStop = 9;
                  if(this._searchCriteria.length > 2)
                  {
                     if(TradeCenter.BID_HOUSE_BUY_MODE)
                     {
                        this.gd_shop.dataProvider = this._searchResult;
                     }
                     else
                     {
                        this.updateStockInventory();
                     }
                  }
                  else
                  {
                     this.gd_shop.dataProvider = new Array();
                  }
               }
               else
               {
                  this.tx_icon.gotoAndStop = 8;
                  this._searchCriteria = null;
                  this.updateStockInventory();
               }
               break;
            case this.btnClose:
               this.sysApi.sendAction(new LeaveShopStock());
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_center:
               if(this._timer.running == false)
               {
                  this.btn_center.disabled = true;
                  this._timer.reset();
                  this._timer.start();
                  TradeCenter.SWITCH_MODE = true;
                  TradeCenter.BID_HOUSE_BUY_MODE = !TradeCenter.BID_HOUSE_BUY_MODE;
                  if(TradeCenter.SEARCH_MODE)
                  {
                     TradeCenter.SEARCH_MODE = false;
                     this.tx_icon.gotoAndStop = 8;
                     this._searchCriteria = null;
                  }
                  if(TradeCenter.BID_HOUSE_BUY_MODE)
                  {
                     this.sysApi.sendAction(new BidSwitchToBuyerMode());
                  }
                  else
                  {
                     this.sysApi.sendAction(new BidSwitchToSellerMode());
                  }
               }
               break;
         }
      }
      
      public function isSwitching() : Boolean {
         return TradeCenter.SWITCH_MODE;
      }
      
      public function onRollOver(target:Object) : void {
         var info:String = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var pos:Object = 
            {
               "point":10,
               "relativePoint":1
            };
         switch(target)
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
               info = this.uiApi.getText("ui.common.allTypes");
               break;
            case this.btn_info:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._bidTooltipText),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
               break;
            case this.lbl_quantityObject:
               info = this.uiApi.getText("ui.bidhouse.quantityObjectSold",this._totalObjectSold,this._sellerBuyerDescriptor.maxItemPerAccount);
               break;
            case this.lbl_sumPrices:
               info = this.uiApi.getText("ui.bidhouse.totalPrice");
               break;
            case this.searchInput:
               info = this.uiApi.getText("ui.common.searchFilterTooltip");
               break;
            default:
               if(target.name.indexOf("slot_item") != -1)
               {
                  itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
                  if(itemTooltipSettings == null)
                  {
                     itemTooltipSettings = this.tooltipApi.createItemSettings();
                     this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
                  }
                  if(this.sysApi.getOption("displayTooltips","dofus"))
                  {
                     this.uiApi.showTooltip(this._slotList[target.name].itemWrapper,target,false,"standard",3,3,0,null,null,itemTooltipSettings);
                  }
                  else
                  {
                     this.uiApi.showTooltip(this._slotList[target.name].itemWrapper,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,"itemName",null,itemTooltipSettings,"ItemInfo");
                  }
               }
         }
         if(info)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.name.indexOf("slot_item") != -1)
         {
            data = this._slotList[target.name];
            contextMenu = this.menuApi.create(data.itemWrapper);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         if(s == "validUi")
         {
            if(this.searchInput.haveFocus)
            {
               this.searchInput.focus();
               return true;
            }
         }
         return false;
      }
      
      protected function onTimerEvent(e:TimerEvent) : void {
         this.btn_center.disabled = false;
      }
      
      public function unload() : void {
         this._timer.stop();
         this.uiApi.unloadUi(UIEnum.BIDHOUSE_BUY);
         this.uiApi.unloadUi(UIEnum.BIDHOUSE_SELL);
         TradeCenter.SEARCH_MODE = false;
         this.sysApi.sendAction(new CloseInventory());
      }
      
      public function onLeaveDialog() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
