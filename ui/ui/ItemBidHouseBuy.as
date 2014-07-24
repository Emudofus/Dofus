package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2components.Grid;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.ComboBox;
   import d2components.Input;
   import d2hooks.ExchangeBidPrice;
   import d2hooks.BidObjectListUpdate;
   import d2hooks.ExchangeError;
   import d2enums.ShortcutHookListEnum;
   import d2enums.ComponentHookList;
   import flash.utils.clearTimeout;
   import d2actions.ExchangeBidHousePrice;
   import flash.utils.Dictionary;
   import d2data.EffectInstance;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import d2data.ItemWrapper;
   import d2data.Monster;
   import d2enums.ExchangeErrorEnum;
   import d2actions.ExchangeBidHouseBuy;
   import d2enums.SelectMethodEnum;
   
   public class ItemBidHouseBuy extends Object
   {
      
      public function ItemBidHouseBuy() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      private var _sellerBuyerDescriptor:Object;
      
      private var _itemName:String;
      
      private var _listObjects:Object;
      
      private var _currentSort:int = 1;
      
      private var _item:Object;
      
      private var _selectedItem:Object;
      
      private var _isTheoricalItem:Boolean = false;
      
      private var _currentGrid:Grid;
      
      private var _detailView:Boolean;
      
      private var _currentFilter:String;
      
      private var _allText:String;
      
      private var _cancelSearch:Boolean;
      
      public var currentCase:int = -1;
      
      public var mainCtr:GraphicContainer;
      
      public var classicItemCtr:GraphicContainer;
      
      public var detailItemCtr:GraphicContainer;
      
      public var ctr_item:GraphicContainer;
      
      public var lbl_averagePrice:Label;
      
      public var lbl_averagePriceTitle:Label;
      
      public var lbl_selectItem:Label;
      
      public var lbl_tabQty1:Label;
      
      public var lbl_tabQty2:Label;
      
      public var lbl_tabQty3:Label;
      
      public var btn_tabQty1:ButtonContainer;
      
      public var btn_tabQty2:ButtonContainer;
      
      public var btn_tabQty3:ButtonContainer;
      
      public var btn_name:ButtonContainer;
      
      public var btn_price:ButtonContainer;
      
      public var btn_size:ButtonContainer;
      
      public var btn_reset:ButtonContainer;
      
      public var btn_buy:ButtonContainer;
      
      public var gd_classicList:Grid;
      
      public var gd_detailList:Grid;
      
      public var cb_filter:ComboBox;
      
      public var searchCtr:GraphicContainer;
      
      public var inp_search:Input;
      
      public var btn_search:ButtonContainer;
      
      public function main(params:Object) : void {
         this.sysApi.addHook(ExchangeBidPrice,this.onExchangeBidPrice);
         this.sysApi.addHook(BidObjectListUpdate,this.onBidObjectListUpdate);
         this.sysApi.addHook(ExchangeError,this.onExchangeError);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.lbl_averagePriceTitle,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_averagePriceTitle,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_averagePrice,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_averagePrice,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_tabQty1,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabQty2,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabQty3,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.cb_filter,ComponentHookList.ON_SELECT_ITEM);
         this._allText = this.uiApi.getText("ui.common.all");
         this._sellerBuyerDescriptor = params.sellerBuyerDescriptor;
         this.lbl_tabQty1.text = "x " + this._sellerBuyerDescriptor.quantities[0];
         this.lbl_tabQty2.text = "x " + this._sellerBuyerDescriptor.quantities[1];
         this.lbl_tabQty3.text = "x " + this._sellerBuyerDescriptor.quantities[2];
         this.lbl_selectItem.visible = false;
         this.gd_classicList.autoSelectMode = 0;
         this.gd_classicList.dataProvider = new Array();
         this.gd_detailList.autoSelectMode = 1;
         this.gd_detailList.dataProvider = new Array();
         this._currentGrid = this.gd_classicList;
         this.btn_buy.disabled = true;
         this.mainCtr.visible = false;
      }
      
      public function displayUi(value:Boolean) : void {
         if(value)
         {
            this.gd_classicList.dataProvider = new Array();
            this.gd_detailList.dataProvider = new Array();
            this.btn_buy.disabled = true;
         }
         else
         {
            this.mainCtr.visible = false;
         }
      }
      
      private var _progressPopupName:String;
      
      private var _searchSettimoutId:uint;
      
      private function onCancelSearch() : void {
         clearTimeout(this._searchSettimoutId);
         if(this._progressPopupName)
         {
            this.uiApi.unloadUi(this._progressPopupName);
            this._progressPopupName = null;
         }
      }
      
      private function onBidObjectListUpdate(listObjects:Object, update:Boolean = false, newObjectType:Boolean = false) : void {
         var itemw:Object = null;
         var itemo:Object = null;
         if(newObjectType)
         {
            if(this._detailView)
            {
               this._currentGrid.selectedIndex = 0;
            }
            else
            {
               this._currentGrid.selectedIndex = -1;
            }
         }
         this.currentCase = -1;
         if(this._currentGrid.selectedItem)
         {
            this.currentCase = this._currentGrid.selectedItem.currentCase;
         }
         this._listObjects = listObjects;
         this.refreshBidObjectList(!update);
         if((!update) && (!(this._listObjects[0] == null)))
         {
            this.sysApi.sendAction(new ExchangeBidHousePrice(this._listObjects[0].itemWrapper.objectGID));
            itemw = this._listObjects[0].itemWrapper;
            itemo = this.dataApi.getItem(itemw.objectGID);
            this._itemName = itemo.name;
            this._item = itemw;
            this.modCommon.createItemBox("itemBox",this.ctr_item,itemw,true);
            this.btn_reset.visible = false;
         }
      }
      
      private function refreshbidObjectListStep(keepScroll:Boolean, lcFilter:String, gridProvider:Array, cbDictionary:Dictionary, nObjects:uint, offset:uint = 0) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function refreshbidObjectListEnd(keepScroll:Boolean, gridProvider:Array, cbDictionary:Dictionary) : void {
         var temp:* = 0;
         var index:uint = 0;
         var scrollItem:Object = null;
         var scrollIndex:* = 0;
         var selectedIndex:* = 0;
         var cbProvider:Array = null;
         var entry:String = null;
         this.onCancelSearch();
         if(this._currentSort < 0)
         {
            temp = this._currentSort * -1;
            if(this._currentSort == -4)
            {
               gridProvider.sortOn("name",Array.DESCENDING);
            }
            else if(this._currentSort == -5)
            {
               gridProvider.sortOn("size",Array.NUMERIC | Array.DESCENDING);
            }
            else
            {
               gridProvider.sortOn("p" + temp,Array.NUMERIC | Array.DESCENDING);
            }
            
         }
         else if(this._currentSort == 4)
         {
            gridProvider.sortOn("name");
         }
         else if(this._currentSort == 5)
         {
            gridProvider.sortOn("size",Array.NUMERIC);
         }
         else
         {
            gridProvider.sortOn("p" + this._currentSort,Array.NUMERIC);
         }
         
         
         this.mainCtr.visible = true;
         if(this._detailView)
         {
            this._currentGrid = this.gd_detailList;
            this.classicItemCtr.visible = false;
            this.detailItemCtr.visible = true;
            index = 0;
            scrollIndex = -1;
            selectedIndex = this.gd_detailList.selectedIndex;
            if(selectedIndex < 0)
            {
               selectedIndex = 0;
            }
            if(keepScroll)
            {
               index = 0;
               while(index < this.gd_detailList.dataProvider.length)
               {
                  if(!this.gd_detailList.indexIsInvisibleSlot(index))
                  {
                     scrollIndex = index;
                     scrollItem = this.gd_detailList.dataProvider[index];
                     break;
                  }
                  index++;
               }
            }
            this.gd_detailList.dataProvider = gridProvider;
            if(keepScroll)
            {
               if(scrollItem)
               {
                  index = 0;
                  while(index < gridProvider.length)
                  {
                     if(gridProvider[index].name == scrollItem.name)
                     {
                        scrollIndex = index;
                        break;
                     }
                     index++;
                  }
               }
               this.gd_detailList.moveTo(scrollIndex,true);
               if(this.gd_detailList.selectedIndex != selectedIndex)
               {
                  this.gd_detailList.selectedIndex = selectedIndex;
               }
            }
            cbProvider = new Array();
            for(entry in cbDictionary)
            {
               cbProvider.push(entry);
            }
            cbProvider.sort();
            cbProvider.unshift(this._allText);
            if((cbProvider.length < 2) || (this.cb_filter.dataProvider.length < 2) || (!(cbProvider.length == this.cb_filter.dataProvider.length)))
            {
               this.cb_filter.selectedIndex = 0;
               this.cb_filter.dataProvider = cbProvider;
               this.inp_search.text = "";
            }
         }
         else
         {
            this._currentGrid = this.gd_classicList;
            this.classicItemCtr.visible = true;
            this.detailItemCtr.visible = false;
            this.gd_classicList.dataProvider = gridProvider;
         }
      }
      
      private function refreshBidObjectList(keepScroll:Boolean = true) : void {
         var nObjects:* = 0;
         var gridProvider:Array = null;
         var cbDictionary:Dictionary = null;
         var lcFilter:String = null;
         if((!this._listObjects) || (this._listObjects.length == 0))
         {
            this.mainCtr.visible = false;
         }
         else
         {
            nObjects = this._listObjects.length;
            gridProvider = new Array();
            cbDictionary = new Dictionary();
            this._detailView = this.useDetailView(this._listObjects);
            if((this._currentGrid == this.gd_classicList) && (this._detailView) || (this._currentGrid == this.gd_detailList) && (!this._detailView))
            {
               this._currentFilter = "";
               this.inp_search.text = "";
            }
            lcFilter = this._currentFilter?this._currentFilter.toLowerCase():"";
            this.onCancelSearch();
            this.refreshbidObjectListStep(keepScroll,lcFilter,gridProvider,cbDictionary,nObjects);
         }
      }
      
      private function addToCombobox(dictionary:Dictionary, name:String) : void {
         var n:String = null;
         var names:Array = name.split(", ");
         for each(n in names)
         {
            if(!dictionary.hasOwnProperty(n))
            {
               dictionary[n] = true;
            }
         }
      }
      
      private function filtered(filter:String, item:ItemWrapper) : Boolean {
         var effect:EffectInstance = null;
         var monster:Monster = null;
         if(filter.length == 0)
         {
            return false;
         }
         if(filter.length < 3)
         {
            return true;
         }
         if(item.name.toLowerCase().indexOf(filter) != -1)
         {
            return false;
         }
         while(true)
         {
            loop0:
            for each(effect in item.effects)
            {
               switch(effect.effectId)
               {
                  case 623:
                  case 628:
                     monster = this.dataApi.getMonsterFromId(int(effect.parameter2));
                     if(monster.name.toLowerCase().indexOf(filter) != -1)
                     {
                        break loop0;
                     }
                     continue;
                  default:
                     continue;
               }
            }
            return true;
         }
         return false;
      }
      
      private function onExchangeError(errorId:int) : void {
         if(errorId == ExchangeErrorEnum.BID_SEARCH_ERROR)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.bidhouse.bigStore"),this.uiApi.getText("ui.bidhouse.itemNotInBigStore"),[this.uiApi.getText("ui.common.ok")]);
            this.mainCtr.visible = false;
         }
      }
      
      private function onExchangeBidPrice(genericId:uint, averagePrice:int) : void {
         this.lbl_averagePrice.text = !(averagePrice == -1)?this.utilApi.kamasToString(averagePrice):this.uiApi.getText("ui.item.averageprice.unavailable");
      }
      
      private function onConfirmBuyObject() : void {
         var quantity:* = 0;
         var price:uint = 0;
         if(this.currentCase > -1)
         {
            quantity = this._sellerBuyerDescriptor.quantities[this.currentCase];
            price = this._selectedItem.prices[this.currentCase];
            this.sysApi.sendAction(new ExchangeBidHouseBuy(this._selectedItem.itemWrapper.objectUID,quantity,price));
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.bidhouse.bigStore"),this.uiApi.getText("ui.bidhouse.itemNotInBigStore"),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function onCancelBuyObject() : void {
      }
      
      public function onRelease(target:Object) : void {
         var quantityIndex:* = 0;
         var price:* = 0;
         if(target == this.btn_buy)
         {
            if((!(this._currentGrid.selectedItem == null)) && (!(this.currentCase == -1)))
            {
               this._selectedItem = this._currentGrid.selectedItem;
               quantityIndex = this.currentCase;
               price = this._selectedItem.prices[quantityIndex];
               if(price > 0)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.bidhouse.doUBuyItemBigStore",this._sellerBuyerDescriptor.quantities[quantityIndex] + " x " + this._itemName,this.utilApi.kamasToString(int(price / int(this._sellerBuyerDescriptor.quantities[quantityIndex]))),this.utilApi.kamasToString(price)),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmBuyObject,this.onCancelBuyObject],this.onConfirmBuyObject,this.onCancelBuyObject);
               }
            }
         }
         else if(target == this.btn_reset)
         {
            if(!this._isTheoricalItem)
            {
               this.modCommon.createItemBox("itemBox",this.ctr_item,this._item,true);
               this._isTheoricalItem = true;
            }
            else
            {
               this.modCommon.createItemBox("itemBox",this.ctr_item,this._item);
               this._isTheoricalItem = false;
            }
         }
         else if((target == this.btn_tabQty1) || (target == this.btn_price))
         {
            if(this._currentSort == 1)
            {
               this._currentSort = -1;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
            else
            {
               this._currentSort = 1;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
         }
         else if(target == this.btn_tabQty2)
         {
            if(this._currentSort == 2)
            {
               this._currentSort = -2;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
            else
            {
               this._currentSort = 2;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
         }
         else if(target == this.btn_tabQty3)
         {
            if(this._currentSort == 3)
            {
               this._currentSort = -3;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
            else
            {
               this._currentSort = 3;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
         }
         else if(target == this.btn_name)
         {
            if(this._currentSort == 4)
            {
               this._currentSort = -4;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
            else
            {
               this._currentSort = 4;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
         }
         else if(target == this.btn_size)
         {
            if(this._currentSort == 5)
            {
               this._currentSort = -5;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
            else
            {
               this._currentSort = 5;
               this.onBidObjectListUpdate(this._listObjects,true);
            }
         }
         else if(target == this.btn_search)
         {
            this._currentFilter = null;
            if(this.btn_search.selected)
            {
               this.searchCtr.visible = true;
               this.cb_filter.visible = false;
               this._currentFilter = this.inp_search.text;
               this.cb_filter.selectedIndex = 0;
               this.inp_search.focus();
            }
            else
            {
               this.searchCtr.visible = false;
               this.cb_filter.visible = true;
               if(this.cb_filter.dataProvider[this.cb_filter.selectedIndex] != this._allText)
               {
                  this._currentFilter = this.cb_filter.dataProvider[this.cb_filter.selectedIndex];
               }
               this.inp_search.text = "";
            }
            this.refreshBidObjectList(false);
         }
         
         
         
         
         
         
         
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var newSelection:* = false;
         switch(target)
         {
            case this._currentGrid:
               if(this._currentGrid.selectedItem)
               {
                  this.onObjectSelected(this._currentGrid.selectedItem.itemWrapper);
                  if((!(this.currentCase == -1)) && (this._currentGrid.selectedItem.prices[this.currentCase] > 0))
                  {
                     this.btn_buy.disabled = false;
                  }
                  else
                  {
                     this.btn_buy.disabled = true;
                  }
               }
               break;
            case this.cb_filter:
               if(selectMethod != SelectMethodEnum.AUTO)
               {
                  newSelection = !(this._currentFilter == this.cb_filter.dataProvider[this.cb_filter.selectedIndex]);
                  this._currentFilter = this.cb_filter.dataProvider[this.cb_filter.selectedIndex];
                  if(this._currentFilter == this._allText)
                  {
                     this._currentFilter = null;
                  }
                  if(newSelection)
                  {
                     this.refreshBidObjectList(true);
                  }
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:Object = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.lbl_averagePriceTitle:
            case this.lbl_averagePrice:
               tooltipText = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.bidhouse.bigStoreMiddlePrice"));
               break;
            case this.btn_reset:
               tooltipText = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.item.genericObject"));
               break;
         }
         this.uiApi.showTooltip(tooltipText,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onObjectSelected(item:Object) : void {
         if(item)
         {
            this._item = item;
            this.modCommon.createItemBox("itemBox",this.ctr_item,item,this._isTheoricalItem);
            if((this._item as ItemWrapper).isEquipment)
            {
               this.btn_reset.visible = true;
            }
            else
            {
               this.btn_reset.visible = false;
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         if(TradeCenter.BID_HOUSE_BUY_MODE)
         {
            switch(s)
            {
               case "validUi":
                  return true;
            }
         }
         return false;
      }
      
      public function onChange(target:Object) : void {
         if((target == this.inp_search) && (this.inp_search.haveFocus))
         {
            if((this.inp_search.text.length > 2) || (this._currentFilter) && (this.inp_search.text.length == 0))
            {
               this._currentFilter = this.inp_search.text.toLowerCase();
               this.refreshBidObjectList(false);
            }
         }
      }
      
      public function unload() : void {
         this.onCancelSearch();
         this.uiApi.unloadUi("itemBox");
      }
      
      private function useDetailView(listObjects:Object) : Boolean {
         var itemSell:Object = null;
         for each(itemSell in listObjects)
         {
            if(itemSell.itemWrapper.name != itemSell.itemWrapper.realName)
            {
               return true;
            }
         }
         return false;
      }
   }
}
