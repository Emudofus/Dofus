package ui
{
   import d2api.ContextMenuApi;
   import d2components.Label;
   import d2components.ComboBox;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2hooks.ExchangeBidPriceForSeller;
   import d2hooks.SellerObjectListUpdate;
   import d2actions.ExchangeBidHousePrice;
   import d2actions.ExchangeShopStockMouvmentAdd;
   import d2actions.ExchangeObjectModifyPriced;
   import d2actions.ExchangeShopStockMouvmentRemove;
   
   public class ItemBidHouseSell extends BasicItemCard
   {
      
      public function ItemBidHouseSell() {
         super();
      }
      
      private static var _lastSell:Object;
      
      public var menuApi:ContextMenuApi;
      
      public var modContextMenu:Object;
      
      public var _sellerDescriptor:Object;
      
      private var _exchangeQuantity:uint;
      
      private var _itemName:String;
      
      private var _mode:Boolean;
      
      private var _price:uint;
      
      private var _oldPrice:uint;
      
      private var _tax:uint;
      
      private var _maxQuantityReached:Boolean = false;
      
      private var _currentObjectToRemove:Object;
      
      public var lbl_error:Label;
      
      public var lbl_quantity:Label;
      
      public var lbl_taxTimeTitle:Label;
      
      public var lbl_taxTime:Label;
      
      public var lbl_averagePrice:Label;
      
      public var lbl_averagePriceTitle:Label;
      
      public var lbl_currentPriceQty0:Label;
      
      public var lbl_currentPriceQty1:Label;
      
      public var lbl_currentPriceQty2:Label;
      
      public var lbl_currentPrice0:Label;
      
      public var lbl_currentPrice1:Label;
      
      public var lbl_currentPrice2:Label;
      
      public var lbl_noCurrentPrice:Label;
      
      public var cb_quantity:ComboBox;
      
      public var ctr_sellingGroup:Object;
      
      public var tx_miniPricesWarning:Texture;
      
      public var ctr_minimumPrices:GraphicContainer;
      
      override public function main(params:Object = null) : void {
         super.main(params);
         sysApi.addHook(ExchangeBidPriceForSeller,this.onExchangeBidPriceForSeller);
         sysApi.addHook(SellerObjectListUpdate,this.onSellerObjectListUpdate);
         uiApi.addShortcutHook("validUi",this.onShortcut);
         uiApi.addComponentHook(this.tx_miniPricesWarning,"onRollOver");
         uiApi.addComponentHook(this.tx_miniPricesWarning,"onRollOut");
         uiApi.addComponentHook(this.lbl_averagePriceTitle,"onRollOver");
         uiApi.addComponentHook(this.lbl_averagePriceTitle,"onRollOut");
         uiApi.addComponentHook(this.lbl_averagePrice,"onRollOver");
         uiApi.addComponentHook(this.lbl_averagePrice,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPriceQty0,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPriceQty0,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPriceQty1,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPriceQty1,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPriceQty2,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPriceQty2,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPrice0,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPrice0,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPrice1,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPrice1,"onRollOut");
         uiApi.addComponentHook(this.lbl_currentPrice2,"onRollOver");
         uiApi.addComponentHook(this.lbl_currentPrice2,"onRollOut");
         ctr_inputQty.visible = false;
         this._sellerDescriptor = params.sellerBuyerDescriptor;
         this.lbl_currentPriceQty0.text = "x " + this._sellerDescriptor.quantities[0];
         this.lbl_currentPriceQty1.text = "x " + this._sellerDescriptor.quantities[1];
         this.lbl_currentPriceQty2.text = "x " + this._sellerDescriptor.quantities[2];
      }
      
      public function onSelectItemFromInventory(selectedItem:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function onSelectItemFromStockBidHouse(selectedItem:Object) : void {
         if(selectedItem == null)
         {
            return;
         }
         this._mode = false;
         onObjectSelected(selectedItem.itemWrapper);
         this.cb_quantity.visible = false;
         this.lbl_quantity.visible = true;
         this.ctr_sellingGroup.visible = true;
         this.lbl_error.visible = false;
         this._exchangeQuantity = TradeCenter.QUANTITIES.indexOf(_currentObject.quantity);
         var item:Object = dataApi.getItem(_currentObject.objectGID);
         this._itemName = item.name;
         input_price.text = selectedItem.price;
         this._oldPrice = selectedItem.price;
         input_price.focus();
         input_price.setSelection(0,8388607);
         this.lbl_quantity.text = _currentObject.quantity.toString();
         sysApi.sendAction(new ExchangeBidHousePrice(_currentObject.objectGID));
         this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreTime") + uiApi.getText("ui.common.colon");
         this.lbl_taxTime.text = Math.round(selectedItem.unsoldDelay / 3600) + " " + uiApi.getText("ui.common.hourShort");
         btn_valid.visible = false;
         btn_remove.visible = true;
         btn_modify.visible = true;
      }
      
      public function displayUi(value:Boolean) : void {
         if(!value)
         {
            hideCard();
         }
      }
      
      private function updateTax() : void {
         var currentPrice:int = utilApi.stringToKamas(input_price.text,"");
         if((this._mode) || (!(currentPrice == this._oldPrice)))
         {
            if(this._sellerDescriptor.taxPercentage == 0)
            {
               this._tax = 0;
            }
            else if(this._mode)
            {
               this._tax = Math.max(1,int(currentPrice * this._sellerDescriptor.taxPercentage / 100 + 0.5));
            }
            else if(this._oldPrice < currentPrice)
            {
               this._tax = Math.max(1,int((currentPrice - this._oldPrice) * this._sellerDescriptor.taxPercentage / 100 + 0.5));
            }
            else
            {
               this._tax = Math.max(1,int(currentPrice * this._sellerDescriptor.taxModificationPercentage / 100 + 0.5));
            }
            
            
            this.lbl_taxTime.text = utilApi.kamasToString(this._tax);
            if(this._mode)
            {
               this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreTax") + uiApi.getText("ui.common.colon");
            }
            else
            {
               this.lbl_taxTimeTitle.text = uiApi.getText("ui.bidhouse.bigStoreModificationTax") + uiApi.getText("ui.common.colon");
            }
         }
      }
      
      private function onConfirmSellObject() : void {
         sysApi.sendAction(new ExchangeShopStockMouvmentAdd(_currentObject.objectUID,TradeCenter.QUANTITIES[this._exchangeQuantity],this._price));
         if(!TradeCenter.SALES_PRICES[_currentObject.objectGID])
         {
            TradeCenter.SALES_PRICES[_currentObject.objectGID] = new Array();
         }
         TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity] = this._price;
         if(this._exchangeQuantity < this.cb_quantity.dataProvider.length)
         {
            TradeCenter.SALES_QUANTITIES[_currentObject.objectGID] = this._exchangeQuantity + 1;
         }
         hideCard();
      }
      
      private function onConfirmModifyObject() : void {
         sysApi.log(2,"onConfirmModifyObject -> qty " + this._exchangeQuantity);
         sysApi.sendAction(new ExchangeObjectModifyPriced(_currentObject.objectUID,TradeCenter.QUANTITIES[this._exchangeQuantity],this._price));
         if(!TradeCenter.SALES_PRICES[_currentObject.objectGID])
         {
            TradeCenter.SALES_PRICES[_currentObject.objectGID] = new Array();
         }
         TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity] = this._price;
         if(this._exchangeQuantity < this.cb_quantity.dataProvider.length)
         {
            TradeCenter.SALES_QUANTITIES[_currentObject.objectGID] = this._exchangeQuantity + 1;
         }
         hideCard();
      }
      
      private function onConfirmWithdrawObject() : void {
         sysApi.sendAction(new ExchangeShopStockMouvmentRemove(this._currentObjectToRemove.objectUID,-TradeCenter.QUANTITIES[this._exchangeQuantity]));
         hideCard();
      }
      
      private function onCancelSellObject() : void {
      }
      
      private function putOnSell() : void {
         modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUSellItemBigStore",TradeCenter.QUANTITIES[this._exchangeQuantity] + " x " + _currentObject.name,utilApi.kamasToString(this._price / int(TradeCenter.QUANTITIES[this._exchangeQuantity])),utilApi.kamasToString(this._price),utilApi.kamasToString(this._tax)),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmSellObject,this.onCancelSellObject],this.onConfirmSellObject,this.onCancelSellObject);
      }
      
      private function putOnSellAgain() : void {
         modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUModifyPriceInMarket",TradeCenter.QUANTITIES[this._exchangeQuantity] + " x " + _currentObject.name,utilApi.kamasToString(this._oldPrice),utilApi.kamasToString(this._price),utilApi.kamasToString(this._tax)),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmModifyObject,this.onCancelSellObject],this.onConfirmModifyObject,this.onCancelSellObject);
      }
      
      private function withdrawFromSell() : void {
         modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUWithdrawItemBigStore",TradeCenter.QUANTITIES[this._exchangeQuantity] + " x " + this._currentObjectToRemove.name,utilApi.kamasToString(this._price / int(TradeCenter.QUANTITIES[this._exchangeQuantity]))),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmWithdrawObject,this.onCancelSellObject],this.onConfirmWithdrawObject,this.onCancelSellObject);
      }
      
      private function onExchangeBidPriceForSeller(genericId:uint, averagePrice:int, minimalPrices:Object, allIdentical:Boolean) : void {
         var o:Object = null;
         var price:* = 0;
         if(averagePrice != -1)
         {
            this.lbl_averagePrice.text = utilApi.kamasToString(averagePrice);
         }
         else
         {
            this.lbl_averagePrice.text = uiApi.getText("ui.item.averageprice.unavailable");
         }
         this.tx_miniPricesWarning.visible = !allIdentical;
         var minimalPricesExist:Boolean = false;
         var tmpPrices:Vector.<uint> = new Vector.<uint>();
         for each(o in minimalPrices)
         {
            tmpPrices.push(o);
         }
         if((minimalPrices) && (tmpPrices.length == this._sellerDescriptor.quantities.length))
         {
            for each(price in tmpPrices)
            {
               if(price > 0)
               {
                  minimalPricesExist = true;
                  break;
               }
            }
         }
         if(!minimalPricesExist)
         {
            this.ctr_minimumPrices.visible = false;
            this.lbl_noCurrentPrice.visible = true;
         }
         else
         {
            if(tmpPrices[0] == 0)
            {
               this.lbl_currentPrice0.text = "-";
            }
            else
            {
               this.lbl_currentPrice0.text = utilApi.kamasToString(tmpPrices[0]);
            }
            if(tmpPrices[1] == 0)
            {
               this.lbl_currentPrice1.text = "-";
            }
            else
            {
               this.lbl_currentPrice1.text = utilApi.kamasToString(tmpPrices[1]);
            }
            if(tmpPrices[2] == 0)
            {
               this.lbl_currentPrice2.text = "-";
            }
            else
            {
               this.lbl_currentPrice2.text = utilApi.kamasToString(tmpPrices[2]);
            }
            this.ctr_minimumPrices.visible = true;
            this.lbl_noCurrentPrice.visible = false;
         }
      }
      
      public function onSellerObjectListUpdate(vendorObjects:Object) : void {
         var nbObjectForSale:* = 0;
         var o:Object = null;
         for each(o in vendorObjects)
         {
            nbObjectForSale++;
         }
         if(nbObjectForSale >= this._sellerDescriptor.maxItemPerAccount)
         {
            this._maxQuantityReached = true;
         }
         else
         {
            this._maxQuantityReached = false;
         }
         if((this._maxQuantityReached) && (this._mode))
         {
            btn_valid.disabled = true;
         }
         else
         {
            btn_valid.disabled = false;
         }
      }
      
      override public function onRelease(target:Object) : void {
         var priceChanged:* = false;
         if((target == btn_valid) && (this._mode))
         {
            this._price = utilApi.stringToKamas(input_price.text,"");
            if(this._price > 0)
            {
               this.putOnSell();
            }
         }
         else if((target == btn_remove) && (!this._mode))
         {
            this._currentObjectToRemove = _currentObject;
            this.withdrawFromSell();
         }
         else if((target == btn_modify) && (!this._mode))
         {
            this._price = utilApi.stringToKamas(input_price.text,"");
            priceChanged = !(this._price == this._oldPrice);
            if((priceChanged) && (this._price > 0))
            {
               this.putOnSellAgain();
            }
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
               tooltipText = uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.bigStoreMiddlePrice"));
               break;
            case this.tx_miniPricesWarning:
               tooltipText = uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.warningMinimumPrice"));
               break;
            case this.lbl_currentPrice0:
            case this.lbl_currentPrice1:
            case this.lbl_currentPrice2:
            case this.lbl_currentPriceQty0:
            case this.lbl_currentPriceQty1:
            case this.lbl_currentPriceQty2:
               tooltipText = uiApi.textTooltipInfo(uiApi.getText("ui.bidhouse.minimumPrice"));
               break;
         }
         uiApi.showTooltip(tooltipText,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.cb_quantity)
         {
            this._exchangeQuantity = target.value.quantity - 1;
            if((TradeCenter.SALES_PRICES[_currentObject.objectGID]) && (TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity]))
            {
               input_price.text = utilApi.kamasToString(TradeCenter.SALES_PRICES[_currentObject.objectGID][this._exchangeQuantity],"");
               input_price.focus();
               input_price.setSelection(0,8388607);
               this.updateTax();
            }
            else
            {
               input_price.text = "0";
               this.updateTax();
            }
         }
      }
      
      override public function onChange(target:GraphicContainer) : void {
         if((target == input_price) && (input_price.haveFocus))
         {
            this.updateTax();
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         var priceChanged:* = false;
         if(!TradeCenter.BID_HOUSE_BUY_MODE)
         {
            switch(s)
            {
               case "validUi":
                  if(!uiVisible)
                  {
                     return false;
                  }
                  if((this.ctr_sellingGroup.visible) && (this._mode))
                  {
                     this._price = utilApi.stringToKamas(input_price.text,"");
                     if(this._price > 0)
                     {
                        this.putOnSell();
                        btn_valid.focus();
                     }
                  }
                  else if(_currentObject)
                  {
                     this._price = utilApi.stringToKamas(input_price.text,"");
                     priceChanged = !(this._price == this._oldPrice);
                     if((priceChanged) && (this._price > 0))
                     {
                        this.putOnSellAgain();
                     }
                  }
                  
                  return true;
            }
         }
         return false;
      }
   }
}
