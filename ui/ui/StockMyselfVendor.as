package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.ContextMenuApi;
   import d2api.SoundApi;
   import d2api.TooltipApi;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.Input;
   import flash.utils.Dictionary;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.ExchangeShopStockUpdate;
   import d2hooks.ExchangeShopStockMovementRemoved;
   import d2hooks.ClickItemInventory;
   import d2hooks.ClickItemShopHV;
   import d2hooks.ExchangeShopStockAddQuantity;
   import d2hooks.ExchangeShopStockRemoveQuantity;
   import d2hooks.KeyUp;
   import d2hooks.ExchangeLeave;
   import d2enums.ComponentHookList;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2actions.ExchangeObjectModifyPriced;
   import d2enums.SelectMethodEnum;
   import flash.ui.Keyboard;
   import d2actions.ExchangeShopStockMouvmentRemove;
   import d2actions.ExchangeShowVendorTax;
   import d2utils.ItemTooltipSettings;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2actions.LeaveDialogRequest;
   import d2actions.CloseInventory;
   
   public class StockMyselfVendor extends Object
   {
      
      public function StockMyselfVendor() {
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
      
      public static var MODE:String;
      
      public static const STOCK:String = "stock";
      
      public static const HUMAN_VENDOR:String = "human_vendor";
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var menuApi:ContextMenuApi;
      
      public var soundApi:SoundApi;
      
      public var tooltipApi:TooltipApi;
      
      public var modContextMenu:Object;
      
      public var modCommon:Object;
      
      public var btn_center:ButtonContainer;
      
      public var centerCtr:GraphicContainer;
      
      public var btn_lbl_btn_center:Label;
      
      public var gd_shop:Grid;
      
      public var lbl_title:Label;
      
      public var cbFilter:ComboBox;
      
      public var btnEquipable:ButtonContainer;
      
      public var btnConsumables:ButtonContainer;
      
      public var btnRessources:ButtonContainer;
      
      public var btnAll:ButtonContainer;
      
      public var btnSearch:ButtonContainer;
      
      public var btnClose:ButtonContainer;
      
      public var ctr_bottomInfos:GraphicContainer;
      
      public var searchCtr:GraphicContainer;
      
      public var catCtr:GraphicContainer;
      
      public var searchInput:Input;
      
      protected var _searchCriteria:String;
      
      protected var _filterAssoc:Object;
      
      protected var _subFilterIndex:Object;
      
      protected var _shopStock:Object;
      
      protected var _category:Object;
      
      protected var _currentFilterBtn:Object;
      
      private var _item:Object;
      
      private var _objectToRemove:Object;
      
      private var _slotList:Dictionary;
      
      public function main(pItems:Object = null) : void {
         MODE = STOCK;
         this.btnSearch.soundId = SoundEnum.CHECKBOX_CHECKED;
         this.btnEquipable.soundId = SoundEnum.TAB;
         this.btnConsumables.soundId = SoundEnum.TAB;
         this.btnRessources.soundId = SoundEnum.TAB;
         this.btnAll.soundId = SoundEnum.TAB;
         this.sysApi.addHook(ExchangeShopStockUpdate,this.onExchangeShopStockUpdate);
         this.sysApi.addHook(ExchangeShopStockMovementRemoved,this.onExchangeShopStockMovementRemoved);
         this.sysApi.addHook(ClickItemInventory,this.onClickItemInventory);
         this.sysApi.addHook(ClickItemShopHV,this.onClickItemShopHV);
         this.sysApi.addHook(ExchangeShopStockAddQuantity,this.onExchangeShopStockAddQuantity);
         this.sysApi.addHook(ExchangeShopStockRemoveQuantity,this.onExchangeShopStockRemoveQuantity);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.uiApi.addComponentHook(this.searchInput,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.searchInput,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btnAll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btnAll,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btnEquipable,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btnEquipable,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btnConsumables,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btnConsumables,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btnRessources,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btnRessources,ComponentHookList.ON_ROLL_OUT);
         this._currentFilterBtn = this.btnAll;
         this.btnAll.selected = true;
         this.ctr_bottomInfos.visible = false;
         this._filterAssoc[this.btnEquipable.name] = EQUIPEMENT_CATEGORY;
         this._filterAssoc[this.btnConsumables.name] = CONSUMABLES_CATEGORY;
         this._filterAssoc[this.btnRessources.name] = RESSOURCES_CATEGORY;
         this._filterAssoc[this.btnAll.name] = ALL_CATEGORY;
         this.gd_shop.autoSelectMode = 0;
         this.gd_shop.dropValidator = this.dropValidatorFunction as Function;
         this.gd_shop.processDrop = this.processDropFunction as Function;
         this.gd_shop.removeDropSource = this.removeDropSourceFunction as Function;
         this.lbl_title.text = this.uiApi.getText("ui.common.shop");
         this.btn_lbl_btn_center.text = this.uiApi.getText("ui.humanVendor.switchToMerchantMode");
         this._shopStock = pItems;
         this._category = new Array();
         this.updateStockInventory();
         this.btnAll.selected = true;
         this.sysApi.disableWorldInteraction();
      }
      
      public function updateItemLine(data:*, components:*, selected:Boolean) : void {
         var itemWrapper:Object = null;
         var itemObject:Object = null;
         var newWidthName:uint = 0;
         components.slot_item.allowDrag = false;
         components.btn_item.removeDropSource = this.removeDropSourceFunction;
         components.btn_item.processDrop = this.processDropFunction;
         components.btn_item.dropValidator = this.dropValidatorFunction;
         if(!this._slotList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,"onRightClick");
            this.uiApi.addComponentHook(components.slot_item,"onRollOut");
            this.uiApi.addComponentHook(components.slot_item,"onRollOver");
         }
         this._slotList[components.slot_item.name] = data;
         if(data)
         {
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
            components.lbl_ItemPrice.text = this.utilApi.kamasToString(data.price);
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
      
      public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object) : Boolean {
         return true;
      }
      
      public function removeDropSourceFunction(target:Object) : void {
      }
      
      public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object) : void {
      }
      
      private function selectItem(pItem:Object) : void {
         var itemDP:Object = null;
         var compt:uint = 0;
         for each(itemDP in this.gd_shop.dataProvider)
         {
            if(pItem.objectUID == itemDP.itemWrapper.objectUID)
            {
               this.gd_shop.selectedIndex = compt;
               this.sysApi.dispatchHook(ClickItemShopHV,pItem.itemWrapper,pItem.price);
               this.gd_shop.dataProvider[compt].select();
               return;
            }
            compt++;
         }
      }
      
      protected function updateCombobox() : void {
         var it:Object = null;
         var cbProvider:Object = null;
         var selectedItem:Object = null;
         var tmp:Object = null;
         var type:Object = null;
         var item:Object = null;
         var types:Object = new Array();
         var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
         for each(it in this._shopStock)
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
         this.updateStockInventory();
      }
      
      protected function updateStockInventory() : void {
         var it:Object = null;
         var item:Object = null;
         var filter:uint = this._filterAssoc[this._currentFilterBtn.name];
         this.updateCombobox();
         var result:Object = new Array();
         var types:Object = new Array();
         for each(it in this._shopStock)
         {
            item = this.dataApi.getItem(it.itemWrapper.objectGID);
            if(((item.category == filter) || (filter == ALL_CATEGORY)) && ((!this.cbFilter.value) || (this.cbFilter.value.filterType == -1) || (this.cbFilter.value.filterType == item.typeId)) && ((!this._searchCriteria) || (!(it.itemWrapper.name.toLowerCase().indexOf(this._searchCriteria.toLowerCase()) == -1))))
            {
               types[item.typeId] = item.type;
               result.push(it);
            }
         }
         this.gd_shop.dataProvider = result;
      }
      
      protected function onExchangeShopStockUpdate(itemList:Object, newItem:Object = null) : void {
         this._shopStock = itemList;
         if(newItem != null)
         {
            this.selectTab(newItem);
            this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         }
         else
         {
            this.showTransfertUI(false);
            this.updateStockInventory();
         }
      }
      
      public function onClickItemShopHV(pItem:Object, pPrice:uint = 0) : void {
         this._item = pItem;
      }
      
      public function onClickItemInventory(pItemWrapper:Object) : void {
         this._item = pItemWrapper;
      }
      
      public function onExchangeShopStockMovementRemoved(pObjectId:uint) : void {
         if(this._item.objectUID == pObjectId)
         {
            this._item = null;
            if(this.gd_shop.dataProvider.length > 0)
            {
               this.showTransfertUI(true);
               this.gd_shop.selectedIndex = 0;
               this.sysApi.dispatchHook(ClickItemShopHV,this.gd_shop.selectedItem.itemWrapper,this.gd_shop.selectedItem.price);
            }
            else
            {
               this.showTransfertUI(false);
            }
         }
      }
      
      public function onExchangeShopStockAddQuantity() : void {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
      }
      
      public function onExchangeShopStockRemoveQuantity() : void {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
      }
      
      private function showTransfertUI(pShow:Boolean = true) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         var e:* = undefined;
         switch(target)
         {
            case this.gd_shop:
               item = this.gd_shop.selectedItem;
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     this.sysApi.dispatchHook(ClickItemShopHV,item.itemWrapper,item.price);
                     this.showTransfertUI(true);
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     this.sysApi.sendAction(new ExchangeObjectModifyPriced(item.itemWrapper.objectUID,-1,item.price));
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     this.sysApi.sendAction(new ExchangeObjectModifyPriced(item.itemWrapper.objectUID,-item.itemWrapper.quantity,item.price));
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     this._objectToRemove = item;
                     this.modCommon.openQuantityPopup(1,item.itemWrapper.quantity,item.itemWrapper.quantity,this.onValidQty);
                     break;
               }
               break;
            case this.cbFilter:
               if((isNewSelection) && (!(selectMethod == 2)))
               {
                  e = target.value;
                  this._subFilterIndex[this._currentFilterBtn.name] = target.value.filterType;
                  this.updateStockInventory();
               }
               break;
         }
      }
      
      private function onValidQty(qty:Number) : void {
         this.sysApi.sendAction(new ExchangeObjectModifyPriced(this._objectToRemove.itemWrapper.objectUID,-qty,this._objectToRemove.price));
      }
      
      public function onRelease(target:Object) : void {
         var item:Object = null;
         var ctrlDown:* = false;
         var shiftDown:* = false;
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
               if(this.searchCtr.visible)
               {
                  this._searchCriteria = this.searchInput.text;
                  this.searchInput.focus();
               }
               else
               {
                  this._searchCriteria = null;
               }
               this.updateStockInventory();
               break;
            case this.gd_shop:
               item = this.gd_shop.selectedItem;
               ctrlDown = this.uiApi.keyIsDown(Keyboard.CONTROL);
               shiftDown = this.uiApi.keyIsDown(Keyboard.SHIFT);
               if((ctrlDown) && (shiftDown))
               {
                  this.sysApi.sendAction(new ExchangeShopStockMouvmentRemove(item.objectUID,item.quantity));
               }
               break;
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_center:
               this.sysApi.sendAction(new ExchangeShowVendorTax());
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var info:String = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         this.sysApi.log(2,"onRollOver " + target.name);
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
               info = this.uiApi.getText("ui.common.all");
               break;
            case this.searchInput:
               pos = 
                  {
                     "point":LocationEnum.POINT_LEFT,
                     "relativePoint":LocationEnum.POINT_RIGHT
                  };
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
                     if(this._slotList[target.name])
                     {
                        this.uiApi.showTooltip(this._slotList[target.name].itemWrapper,target,false,"standard",3,3,0,null,null,itemTooltipSettings);
                     }
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
      
      public function onDoubleClick(target:Object) : void {
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.name.indexOf("slot_item") != -1)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function unload() : void {
         this.uiApi.unloadUi(UIEnum.MYSELF_VENDOR);
         this.sysApi.enableWorldInteraction();
         this.sysApi.sendAction(new LeaveDialogRequest());
         this.sysApi.sendAction(new CloseInventory());
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.searchCtr.visible)
         {
            this._searchCriteria = this.searchInput.text;
            this.updateStockInventory();
         }
      }
      
      public function onExchangeLeave(success:Boolean) : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
