package ui
{
   import d2components.Grid;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import d2components.GraphicContainer;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.SelectMethodEnum;
   
   public class SmithMagicCoop extends SmithMagic
   {
      
      public function SmithMagicCoop() {
         super();
      }
      
      public static const TOOLTIP_SMITH_MAGIC:String = "tooltipSmithMagic";
      
      public static const CRAFT_IMPOSSIBLE:int = 0;
      
      public static const CRAFT_FAILED:int = 1;
      
      public static const CRAFT_SUCCESS:int = 2;
      
      private static const SMITHMAGIC_RUNE_ID:int = 78;
      
      private static const SMITHMAGIC_POTION_ID:int = 26;
      
      private static const SIGNATURE_RUNE_ID:int = 7508;
      
      public static const PAYMENT_TYPE_SUCCESS:int = 0;
      
      public static const PAYMENT_TYPE_ALWAYS:int = 1;
      
      protected var _isCrafter:Boolean;
      
      protected var _isReady:Boolean;
      
      protected var _allowCrafterIngredients:Boolean = false;
      
      protected var _slot_item_owner:Boolean;
      
      protected var _slot_rune_owner:Boolean;
      
      protected var _slot_sign_owner:Boolean;
      
      private var _altClickedItem:Object;
      
      protected var _lastPaymentData:Object;
      
      protected var _waitingGrid:Object;
      
      protected var _crafterInfos:Object;
      
      protected var _customerInfos:Object;
      
      public var gd_bag:Grid;
      
      public var lbl_playedCharacter:Label;
      
      public var lbl_otherCharacter:Label;
      
      public var lbl_otherCharacterJob:Label;
      
      public var lbl_allowCrafterIngredients:Label;
      
      public var chk_allowCrafterIngredients:ButtonContainer;
      
      public var btn_clientStop:ButtonContainer;
      
      public var btn_accept:ButtonContainer;
      
      public var btn_payment:ButtonContainer;
      
      public var ed_otherCharacter:EntityDisplayer;
      
      public var ctn_paymentAlways:Object;
      
      public var ctn_paymentSuccess:Object;
      
      public var ctn_clientButtons:GraphicContainer;
      
      public var ctn_crafterButtons:GraphicContainer;
      
      public var ctr_tutorial:GraphicContainer;
      
      public var tx_bagBorder:Object;
      
      public function get isCrafter() : Boolean {
         return this._isCrafter;
      }
      
      override public function main(args:Object) : void {
         var slot:Object = null;
         var characterInfos:Object = playerApi.getPlayedCharacterInfo();
         super.main(args);
         if(args.crafterInfos.id == characterInfos.id)
         {
            this._isCrafter = true;
         }
         else
         {
            this._isCrafter = false;
         }
         sysApi.addHook(BagListUpdate,this.onBagListUpdate);
         sysApi.addHook(PaymentCraftList,this.onPaymentCraftList);
         sysApi.addHook(ExchangeIsReady,this.onExchangeIsReady);
         sysApi.addHook(ExchangeMultiCraftCrafterCanUseHisRessources,this.onExchangeMultiCraftCrafterCanUseHisRessources);
         uiApi.addComponentHook(this.gd_bag,"onItemRightClick");
         uiApi.addComponentHook(this.gd_bag,"onItemRollOver");
         uiApi.addComponentHook(this.gd_bag,"onItemRollOut");
         uiApi.addComponentHook(this.gd_bag,"onSelectItem");
         uiApi.addComponentHook(this.ed_otherCharacter,"onRelease");
         uiApi.addComponentHook(this.ed_otherCharacter,"onRightClick");
         this.ed_otherCharacter.mouseEnabled = true;
         this.ed_otherCharacter.handCursor = true;
         if(this._isCrafter)
         {
            this.ctn_clientButtons.visible = false;
            this.ctn_crafterButtons.visible = true;
            this.ctr_tutorial.visible = false;
            for each(slot in [slot_item,slot_rune,slot_sign])
            {
               slot.dropValidator = this.dropValidatorFunction as Function;
               slot.processDrop = this.processDropFunction as Function;
            }
         }
         else
         {
            this.ctn_clientButtons.visible = true;
            this.ctn_crafterButtons.visible = false;
            this.ctr_tutorial.visible = true;
            slot_item.allowDrag = false;
            slot_rune.allowDrag = false;
            slot_sign.allowDrag = false;
            slot_item.highlightTexture = slot_rune.highlightTexture = slot_sign.highlightTexture = null;
            slot_item.selectedTexture = slot_rune.selectedTexture = slot_sign.selectedTexture = null;
            slot_item.acceptDragTexture = slot_rune.acceptDragTexture = slot_sign.acceptDragTexture = null;
            slot_item.refuseDragTexture = slot_rune.refuseDragTexture = slot_sign.refuseDragTexture = null;
         }
         this.gd_bag.dataProvider = new Array();
         this.gd_bag.renderer.dropValidatorFunction = this.bagDropValidatorFunction;
         this.gd_bag.renderer.processDropFunction = this.bagProcessDropFunction;
         if(_isRepair)
         {
            if(this._isCrafter)
            {
               this.lbl_allowCrafterIngredients.text = uiApi.getText("ui.craft.crafterPotionsAllowed");
            }
            else
            {
               this.lbl_allowCrafterIngredients.text = uiApi.getText("ui.craft.allowCrafterPotions");
            }
         }
         else if(this._isCrafter)
         {
            this.lbl_allowCrafterIngredients.text = uiApi.getText("ui.craft.crafterRunesAllowed");
         }
         else
         {
            this.lbl_allowCrafterIngredients.text = uiApi.getText("ui.craft.allowCrafterRunes");
         }
         
         this._crafterInfos = args.crafterInfos;
         this._customerInfos = args.customerInfos;
         if(this._isCrafter)
         {
            this._initPlayedCharacter(this._crafterInfos.look,this._crafterInfos.name);
            this._initOtherCharacter(this._customerInfos.look,this._customerInfos.name,this._customerInfos.id);
         }
         else
         {
            this._initPlayedCharacter(this._customerInfos.look,this._customerInfos.name);
            this._initOtherCharacter(this._crafterInfos.look,this._crafterInfos.name,this._crafterInfos.id);
         }
         this._init();
         this._setIsReady(false);
      }
      
      override public function unload() : void {
         super.unload();
         if(uiApi.getUi("payment"))
         {
            uiApi.unloadUi("payment");
         }
         storageApi.removeAllItemMasks("smithMagicBag");
         storageApi.removeAllItemMasks("paymentAlways");
         storageApi.removeAllItemMasks("paymentSuccess");
         storageApi.releaseHooks();
      }
      
      private function _init() : void {
         if(this._isCrafter)
         {
            this.chk_allowCrafterIngredients.disabled = true;
         }
         else
         {
            btn_mergeAll.visible = false;
            btn_mergeOnce.visible = false;
         }
      }
      
      private function _initPlayedCharacter(look:Object, name:String) : void {
         ed_playedCharacter.look = look;
         ed_playedCharacter.yOffset = 30;
         ed_playedCharacter.scale = 1.3;
         ed_playedCharacter.direction = 1;
         this.lbl_playedCharacter.text = "{player," + name + "::" + name + "}";
         if(this._isCrafter)
         {
            this.lbl_playedCharacter.text = this.lbl_playedCharacter.text + (" - " + _job.name + " " + uiApi.getText("ui.common.level") + " " + _skillLevel);
         }
      }
      
      private function _initOtherCharacter(look:Object, name:String, id:int) : void {
         this.ed_otherCharacter.look = look;
         this.ed_otherCharacter.yOffset = 30;
         this.ed_otherCharacter.scale = 1.3;
         this.ed_otherCharacter.direction = 3;
         this.lbl_otherCharacter.text = "{player," + name + "," + id + "::" + name + "}";
         if(this._isCrafter)
         {
            this.lbl_otherCharacterJob.text = uiApi.getText("ui.craft.client");
         }
         else
         {
            this.lbl_otherCharacterJob.text = _job.name + " " + uiApi.getText("ui.common.level") + " " + _skillLevel;
         }
      }
      
      private function _setIsReady(ready:Boolean) : void {
         this._isReady = ready;
         if(this._isReady)
         {
            if(this._isCrafter)
            {
               this._setBagDisabled(false);
               this._setSlotsDisabled(false,false);
            }
            else
            {
               this._setSlotsDisabled(false,true);
               this.btn_accept.disabled = true;
               this.btn_clientStop.disabled = false;
            }
         }
         else if(this._isCrafter)
         {
            this._setBagDisabled(true);
            this._setSlotsDisabled(true,false);
            btn_mergeOnce.disabled = true;
            btn_mergeAll.disabled = true;
         }
         else
         {
            this._setSlotsDisabled(true,false);
            this.btn_accept.disabled = !this._isExchangeValid();
            this.btn_accept.disabled = false;
            this.btn_clientStop.disabled = true;
         }
         
      }
      
      private function _setBagDisabled(disabled:Boolean = true) : void {
         this.gd_bag.softDisabled = disabled;
         if(this._isCrafter)
         {
            this.chk_allowCrafterIngredients.disabled = true;
            this.lbl_allowCrafterIngredients.disabled = true;
         }
         else
         {
            this.lbl_allowCrafterIngredients.disabled = disabled;
            this.chk_allowCrafterIngredients.disabled = disabled;
         }
      }
      
      private function _setSlotsDisabled(hardDisabled:Boolean, softDisabled:Boolean) : void {
         slot_item.softDisabled = softDisabled;
         slot_rune.softDisabled = softDisabled;
         slot_sign.softDisabled = softDisabled;
      }
      
      private function _setItemOwner(item:Object, fromCrafter:Boolean) : void {
         var slot:Object = null;
         for each(slot in [slot_item,slot_rune,slot_sign])
         {
            if(this.dropValidatorFunction(slot,item,null))
            {
               switch(slot)
               {
                  case slot_item:
                     this._slot_item_owner = fromCrafter;
                     continue;
                  case slot_rune:
                     this._slot_rune_owner = fromCrafter;
                     continue;
                  case slot_sign:
                     this._slot_sign_owner = fromCrafter;
                     continue;
                  default:
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      private function _isItemOwner(slot:Object) : Boolean {
         switch(slot)
         {
            case slot_item:
               return this._slot_item_owner;
            case slot_rune:
               return this._slot_rune_owner;
            case slot_sign:
               return this._slot_sign_owner;
            default:
               return false;
         }
      }
      
      private function _isItemFromBag(item:Object) : Boolean {
         var data:Object = null;
         var isItemFromBag:Boolean = false;
         for each(data in this.gd_bag.dataProvider)
         {
            if(data == item)
            {
               isItemFromBag = true;
               break;
            }
         }
         return isItemFromBag;
      }
      
      private function _fillBag(item:Object, qty:int) : void {
         sysApi.sendAction(new ExchangeObjectMove(item.objectUID,qty));
      }
      
      private function _unfillBag(item:Object, qty:int) : void {
         sysApi.sendAction(new ExchangeObjectMove(item.objectUID,-qty));
      }
      
      private function _refreshAcceptButton() : void {
         if((this._isReady) || (this._isExchangeValid()))
         {
            this.btn_accept.disabled = false;
         }
         else
         {
            this.btn_accept.disabled = true;
         }
      }
      
      private function _isExchangeValid() : Boolean {
         var dpi:Object = null;
         var item:Object = null;
         if(this.chk_allowCrafterIngredients.selected)
         {
            return true;
         }
         var hasItem:Boolean = false;
         var hasIngredient:Boolean = false;
         for each(dpi in this.gd_bag.dataProvider)
         {
            item = dataApi.getItem(dpi.objectGID);
            if((item.typeId == SMITHMAGIC_RUNE_ID) || (item.typeId == SMITHMAGIC_POTION_ID))
            {
               hasIngredient = true;
            }
            else if((!(item.id == SIGNATURE_RUNE_ID)) || (!(slot_sign.data == null)))
            {
               hasItem = true;
            }
            
            if((hasIngredient) && (hasItem))
            {
               return true;
            }
         }
         if(slot_item.data != null)
         {
            hasItem = true;
         }
         if(slot_rune.data != null)
         {
            hasIngredient = true;
         }
         return (hasIngredient) && (hasItem);
      }
      
      override protected function fillSlot(slot:Object, item:Object, qty:int) : void {
         if((!(slot.data == null)) && ((slot == slot_item) || (slot == slot_sign) || (!(slot.data.objectGID == item.objectGID))))
         {
            this.unfillSlot(slot,-1);
            _refill_item = item;
            _refill_qty = qty;
         }
         else if(this._isItemFromBag(item))
         {
            sysApi.sendAction(new ExchangeObjectUseInWorkshop(item.objectUID,qty));
         }
         else
         {
            sysApi.sendAction(new ExchangeObjectMove(item.objectUID,qty));
         }
         
      }
      
      override protected function unfillSlot(slot:Object, qty:int = -1) : void {
         if(!slot.data)
         {
            return;
         }
         if(qty == -1)
         {
            qty = slot.data.quantity;
         }
         if(slot == slot_rune)
         {
            _showDamages = true;
         }
         if(this._isItemOwner(slot))
         {
            sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID,-qty));
         }
         else
         {
            sysApi.sendAction(new ExchangeObjectUseInWorkshop(slot.data.objectUID,-qty));
         }
      }
      
      override protected function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean {
         var item:Object = null;
         if(!this._isCrafter)
         {
            return false;
         }
         if(!this._isReady)
         {
            return false;
         }
         if(!this._isItemFromBag(data))
         {
            item = dataApi.getItem(data.objectGID);
            if((!this._allowCrafterIngredients) && (!(item.id == SIGNATURE_RUNE_ID)))
            {
               return false;
            }
         }
         return super.dropValidatorFunction(target,data,source);
      }
      
      override protected function processDropFunction(target:Object, data:Object, source:Object) : void {
         super.processDropFunction(target,data,source);
      }
      
      override public function processDropToInventory(target:Object, data:Object, source:Object) : void {
         if(this._isCrafter)
         {
            super.processDropToInventory(target,data,source);
         }
         else if(source.getUi().name == "payment")
         {
            _waitingSlot = target;
            _waitingObject = data;
            this._waitingGrid = source.getParent();
            if(data.quantity > 1)
            {
               modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQtyDropPayment);
            }
            else
            {
               this.onValidQtyDropPayment(1);
            }
         }
         else if(data.info1 > 1)
         {
            _waitingObject = data;
            modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQtyDropToInventory);
         }
         else
         {
            this._unfillBag(data,1);
         }
         
         
      }
      
      protected function onValidQtyDropPayment(qty:Number) : void {
         switch(this._waitingGrid.name)
         {
            case "gd_items":
               sysApi.sendAction(new ExchangeItemObjectAddAsPayment(false,_waitingObject.objectUID,false,qty));
               break;
            case "gd_itemsBonus":
               sysApi.sendAction(new ExchangeItemObjectAddAsPayment(true,_waitingObject.objectUID,false,qty));
               break;
         }
      }
      
      override protected function onValidQtyDropToInventory(qty:Number) : void {
         if(this._isCrafter)
         {
            unfillSelectedSlot(qty);
         }
         else
         {
            this._unfillBag(_waitingObject,qty);
         }
      }
      
      override public function getMatchingSlot(item:Object) : Object {
         var slot:Object = null;
         for each(slot in [slot_item,slot_rune,slot_sign])
         {
            if(super.isValidSlot(slot,item))
            {
               return slot;
            }
         }
         return null;
      }
      
      public function bagDropValidatorFunction(target:Object, data:Object, source:Object) : Boolean {
         if(this._isCrafter)
         {
            return (!(this.getMatchingSlot(data) == null)) && (!this._isItemOwner(data));
         }
         return (isValidSlot(slot_item,data)) || (isValidSlot(slot_rune,data)) || (isValidSlot(slot_sign,data));
      }
      
      public function bagProcessDropFunction(target:Object, data:Object, source:Object) : void {
         if(!this.bagDropValidatorFunction(target,data,source))
         {
            return;
         }
         if(this._isCrafter)
         {
            if(data.info1 > 1)
            {
               _waitingObject = this.getMatchingSlot(data);
               modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQtySlotToBag);
            }
            else
            {
               this.unfillSlot(this.getMatchingSlot(data),1);
            }
         }
         else if(data.info1 > 1)
         {
            _waitingObject = data;
            modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQtyInventoryToBag);
         }
         else
         {
            this._fillBag(data,1);
         }
         
      }
      
      public function onValidQtyInventoryToBag(qty:int) : void {
         this._fillBag(_waitingObject,qty);
      }
      
      public function onValidQtySlotToBag(qty:int) : void {
         this.unfillSlot(_waitingObject,qty);
      }
      
      public function onSelectItem(target:Object, selectedMethod:uint, isNewSelection:Boolean) : void {
         var numberItem:* = 0;
         switch(target)
         {
            case this.gd_bag:
               numberItem = -1;
               switch(selectedMethod)
               {
                  case SelectMethodEnum.CLICK:
                     if(target.selectedItem)
                     {
                        onObjectSelected({"data":target.selectedItem});
                     }
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     numberItem = target.selectedItem.quantity;
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     numberItem = 1;
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     this._altClickedItem = target.selectedItem;
                     modCommon.openQuantityPopup(1,target.selectedItem.quantity,target.selectedItem.quantity,this.onValidQtyBag);
                     break;
               }
               if(numberItem != -1)
               {
                  if(this._isCrafter)
                  {
                     fillDefaultSlot(target.selectedItem,numberItem);
                     this._setItemOwner(target.selectedItem,false);
                     break;
                  }
                  this._unfillBag(target.selectedItem,numberItem);
                  this._setItemOwner(target.selectedItem,false);
                  break;
               }
               break;
         }
      }
      
      private function onValidQtyBag(qty:Number) : void {
         fillDefaultSlot(this._altClickedItem,qty);
      }
      
      override public function onDoubleClickItemInventory(pItem:Object, qty:int = 1) : void {
         if(this._isCrafter)
         {
            if((pItem.id == SIGNATURE_RUNE_ID) || (pItem.id == SMITHMAGIC_RUNE_ID))
            {
               qty = 1;
            }
            fillDefaultSlot(pItem,qty);
            this._setItemOwner(pItem,true);
         }
         else
         {
            this._setItemOwner(pItem,false);
            this._fillBag(pItem,qty);
         }
      }
      
      override public function onRelease(target:Object) : void {
         super.onRelease(target);
         switch(target)
         {
            case btn_close:
               sysApi.sendAction(new LeaveDialogRequest());
               break;
            case this.btn_accept:
               sysApi.sendAction(new ExchangeReady(true));
               break;
            case this.btn_clientStop:
               sysApi.sendAction(new ExchangeReady(false));
               break;
            case this.chk_allowCrafterIngredients:
               sysApi.sendAction(new ExchangeMultiCraftSetCrafterCanUseHisRessources(this.chk_allowCrafterIngredients.selected));
               break;
            case this.lbl_allowCrafterIngredients:
               sysApi.sendAction(new ExchangeMultiCraftSetCrafterCanUseHisRessources(!this.chk_allowCrafterIngredients.selected));
               break;
            case this.btn_payment:
               modCommon.createPaymentObject(this._lastPaymentData,this._isCrafter,true);
               break;
            case this.ed_otherCharacter:
               if(this._isCrafter)
               {
                  sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
               }
               else
               {
                  sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
               }
               break;
         }
      }
      
      override public function onRightClick(target:Object) : void {
         if(target == this.ed_otherCharacter)
         {
            if(this._isCrafter)
            {
               sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
            }
            else
            {
               sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
            }
         }
         else
         {
            super.onRightClick(target);
         }
      }
      
      override protected function onExchangeObjectRemoved(itemUID:int) : void {
         super.onExchangeObjectRemoved(itemUID);
      }
      
      public function onBagListUpdate(bagList:Object, remote:Boolean) : void {
         var item:Object = null;
         if((!this._isCrafter) && (!remote))
         {
            storageApi.removeAllItemMasks("smithMagicBag");
            for each(item in bagList)
            {
               storageApi.addItemMask(item.objectUID,"smithMagicBag",item.quantity);
            }
            storageApi.releaseHooks();
         }
         this.gd_bag.dataProvider = bagList;
         this._refreshAcceptButton();
      }
      
      private function onPaymentCraftList(paymentData:Object, highlight:Boolean) : void {
         this._lastPaymentData = paymentData;
         if((highlight) && (!uiApi.getUi("payment")))
         {
            modCommon.createPaymentObject(paymentData,this._isCrafter,true);
         }
      }
      
      public function onExchangeIsReady(playerName:String, ready:Boolean) : void {
         if(ready != this._isReady)
         {
            if((!ready) && (this._isCrafter))
            {
               modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.craft.setNotReadyByClient"),[uiApi.getText("ui.common.ok")]);
            }
            this._setIsReady(ready);
         }
      }
      
      public function onExchangeMultiCraftCrafterCanUseHisRessources(canUse:Boolean) : void {
         this.chk_allowCrafterIngredients.selected = canUse;
         this._allowCrafterIngredients = canUse;
         if(!this._isCrafter)
         {
            this._refreshAcceptButton();
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         if(item.data)
         {
            uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,
               {
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:Object, item:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(item.data)
         {
            data = item.data;
            contextMenu = menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
