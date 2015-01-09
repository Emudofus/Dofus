package ui
{
    import d2components.Slot;
    import d2components.EntityDisplayer;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2hooks.PlayerListUpdate;
    import d2hooks.ExchangeIsReady;
    import d2hooks.OtherPlayerListUpdate;
    import d2hooks.PaymentCraftList;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import __AS3__.vec.Vector;
    import d2data.ItemWrapper;
    import d2actions.ExchangeReady;
    import d2actions.DisplayContextualMenu;
    import d2actions.ExchangeItemObjectAddAsPayment;
    import d2actions.*;
    import d2hooks.*;
    import __AS3__.vec.*;

    public class CraftCoop extends Craft 
    {

        public static const EXCHANGE_COLOR_NORMAL:int = 0;
        public static const EXCHANGE_COLOR_GREEN:int = 1;
        public static const BUTTON_STATE_CANCEL:int = 3;
        public static const READY_STEP_NOT_READY:int = 0;
        public static const READY_STEP_I_AM_READY:int = 1;
        public static const READY_STEP_HE_IS_READY:int = 2;
        private static const MAX_SLOT_NUMBER:int = 8;

        public var slot_ingredient_1_other:Slot;
        public var slot_ingredient_2_other:Slot;
        public var slot_ingredient_3_other:Slot;
        public var slot_ingredient_4_other:Slot;
        public var slot_ingredient_5_other:Slot;
        public var slot_ingredient_6_other:Slot;
        public var slot_ingredient_7_other:Slot;
        public var slot_ingredient_8_other:Slot;
        public var slot_signature_other:Slot;
        public var ed_otherPlayer:EntityDisplayer;
        public var lbl_otherPlayerJob:Label;
        public var lbl_otherPlayerInfos:Label;
        public var btn_payment:ButtonContainer;
        protected var _isPlayerCrafter:Boolean;
        protected var _playerInfos:Object;
        protected var _crafterInfos:Object;
        protected var _customerInfos:Object;
        protected var _lastPaymentData:Object;
        protected var _cancelText:String;
        private var _slotsIngredients_other:Array;
        protected var _timerDelay:Object;
        protected var _waitingGrid:Object;
        private var _nbSlotsOtherOccupied:int = 0;
        private var _nbSlotsOccupied:int = 0;
        private var _nbItemOther:int = 0;
        private var _nbItem:int = 0;
        private var _prevItems:Array;
        private var _prevItemsOther:Array;

        public function CraftCoop()
        {
            this._prevItems = new Array();
            this._prevItemsOther = new Array();
            super();
        }

        override public function main(args:Object):void
        {
            var slot:Slot;
            var job:Object;
            this._slotsIngredients_other = new Array(this.slot_ingredient_1_other, this.slot_ingredient_2_other, this.slot_ingredient_3_other, this.slot_ingredient_4_other, this.slot_ingredient_5_other, this.slot_ingredient_6_other, this.slot_ingredient_7_other, this.slot_ingredient_8_other);
            this._playerInfos = playerApi.getPlayedCharacterInfo();
            this._crafterInfos = args.crafterInfos;
            this._customerInfos = args.customerInfos;
            this._isPlayerCrafter = (this._playerInfos.id == this._crafterInfos.id);
            this._cancelText = uiApi.getText("ui.common.cancel");
            this._nbSlotsOtherOccupied = 0;
            this._nbSlotsOccupied = 0;
            this._nbItem = 0;
            this._nbItemOther = 0;
            this._prevItems = new Array();
            this._prevItemsOther = new Array();
            sysApi.addHook(PlayerListUpdate, this.onPlayerListUpdate);
            super.main(args);
            sysApi.addHook(ExchangeIsReady, this.onExchangeIsReady);
            sysApi.addHook(OtherPlayerListUpdate, this.onOtherPlayerListUpdate);
            sysApi.addHook(PaymentCraftList, this.onPaymentCraftList);
            uiApi.addComponentHook(this.ed_otherPlayer, "onRelease");
            uiApi.addComponentHook(this.ed_otherPlayer, "onRightClick");
            for each (slot in this._slotsIngredients_other)
            {
                registerSlot(slot);
            };
            registerSlot(this.slot_signature_other);
            this.setMaxSlotAvailableOther();
            if (this._isPlayerCrafter)
            {
                this.slot_signature_other.visible = false;
                this.displayPlayerEntityWithLabel(this._crafterInfos, ed_player, lbl_playerInfos, 1);
                displayPlayerEntity(this._crafterInfos.look, ed_player, 1);
                this.displayPlayerEntityWithLabel(this._customerInfos, this.ed_otherPlayer, this.lbl_otherPlayerInfos, 3);
                displayPlayerEntity(this._customerInfos.look, this.ed_otherPlayer, 3);
                lbl_playerInfos.text = (((("{player," + this._crafterInfos.name) + "::") + this._crafterInfos.name) + "}");
                this.lbl_otherPlayerInfos.text = (((((("{player," + this._customerInfos.name) + ",") + this._customerInfos.id) + "::") + this._customerInfos.name) + "}");
                this.lbl_otherPlayerJob.text = uiApi.getText("ui.craft.client");
            }
            else
            {
                slot_signature.visible = false;
                this.displayPlayerEntityWithLabel(this._customerInfos, ed_player, lbl_playerInfos, 1);
                displayPlayerEntity(this._customerInfos.look, ed_player, 1);
                this.displayPlayerEntityWithLabel(this._crafterInfos, this.ed_otherPlayer, this.lbl_otherPlayerInfos, 3);
                displayPlayerEntity(this._crafterInfos.look, this.ed_otherPlayer, 3);
                this.lbl_otherPlayerInfos.text = (((((("{player," + this._crafterInfos.name) + ",") + this._crafterInfos.id) + "::") + this._crafterInfos.name) + "}");
                lbl_playerInfos.text = (((("{player," + this._customerInfos.name) + "::") + this._customerInfos.name) + "}");
                job = jobsApi.getJob(_jobId);
                this.lbl_otherPlayerJob.text = ((((job.name + " ") + uiApi.getText("ui.common.short.level")) + " ") + this._crafterInfos.skillLevel);
            };
            this._timerDelay = new Timer(2000, 1);
            this._timerDelay.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerDelayValidateButton);
            this.switchReadyStep(READY_STEP_NOT_READY);
        }

        override public function fillAutoSlot(item:Object, quantity:int, force:Boolean=false):void
        {
            var nb:int = this.getRealNumberItem();
            if ((((((item.id == SIGNATURE_RUNE_ID)) || ((nb < _slotMax)))) || ((((nb == _slotMax)) && (this.isInOneOfTheGrid(item.objectGID))))))
            {
                super.fillAutoSlot(item, quantity, true);
            };
        }

        public function getRealNumberItem():int
        {
            return (this.getRealNumberItemForPlayer(this._prevItems.concat(this._prevItemsOther)));
        }

        private function getRealNumberItemForPlayer(data:Array):int
        {
            var item:int;
            var tmpTab:Vector.<uint> = new Vector.<uint>();
            for each (item in data)
            {
                if (((!((item == SIGNATURE_RUNE_ID))) && ((tmpTab.indexOf(item) == -1))))
                {
                    tmpTab.push(item);
                };
            };
            return (tmpTab.length);
        }

        private function setMaxSlotAvailableOther():void
        {
            var i:int;
            while (i < MAX_SLOT_NUMBER)
            {
                if (i < _slotMax)
                {
                    this._slotsIngredients_other[i].emptyTexture = uiApi.createUri((uiApi.me().getConstant("assets") + "tx_slot"));
                }
                else
                {
                    this._slotsIngredients_other[i].emptyTexture = uiApi.createUri((uiApi.me().getConstant("assets") + "tx_SlotVerrouille"));
                };
                this._slotsIngredients_other[i].refresh();
                i++;
            };
        }

        override public function unload():void
        {
            super.unload();
            _slotsIngredients = new Array();
            this._slotsIngredients_other = new Array();
            this._timerDelay.stop();
            this._timerDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerDelayValidateButton);
            if (uiApi.getUi("payment"))
            {
                uiApi.unloadUi("payment");
            };
            storageApi.removeAllItemMasks("smithMagicBag");
            storageApi.removeAllItemMasks("paymentAlways");
            storageApi.removeAllItemMasks("paymentSuccess");
            storageApi.releaseHooks();
        }

        override protected function onRecipeSelected(pRecipe:Object):void
        {
            fillRecipeIngredients(pRecipe);
        }

        public function formateIngredientsForTheRecipe(pRecipe:Object):Array
        {
            var component:Object;
            var newComponent:Object;
            var found:Boolean;
            var slot:Object;
            var ingredients:Array = new Array();
            var nb:int = this.getRealNumberItemForPlayer(this._prevItemsOther);
            for each (component in pRecipe.ingredients)
            {
                newComponent = new Object();
                newComponent.objectGID = component.objectGID;
                if (nb >= _slotMax)
                {
                    return (null);
                };
                if (!(this.hasItemInGrid(newComponent.objectGID, this._slotsIngredients_other)))
                {
                    nb++;
                };
                found = false;
                for each (slot in this._slotsIngredients_other)
                {
                    if (((slot.data) && ((slot.data.objectGID == component.objectGID))))
                    {
                        found = true;
                        if (slot.data.quantity <= component.quantity)
                        {
                            newComponent.quantity = (component.quantity - slot.data.quantity);
                            ingredients.push(newComponent);
                        };
                        break;
                    };
                };
                if (!(found))
                {
                    newComponent.quantity = component.quantity;
                    ingredients.push(newComponent);
                };
            };
            return (ingredients);
        }

        private function onExchangeIsReady(playerName:String, isReady:Boolean):void
        {
            if (isReady)
            {
                if (this._playerInfos.name == playerName)
                {
                    this.switchReadyStep(READY_STEP_I_AM_READY);
                }
                else
                {
                    this.switchReadyStep(READY_STEP_HE_IS_READY);
                };
            }
            else
            {
                this.switchReadyStep(READY_STEP_NOT_READY);
            };
        }

        private function onPlayerListUpdate(playerList:Object):void
        {
            var slots:Array;
            var datas:Object = this.updatePlayer(playerList.componentList, 1);
            if (((!((datas.index == null))) && ((datas.index >= 0))))
            {
                slots = (((datas.player == 1)) ? _slotsIngredients : this._slotsIngredients_other);
                if (datas.type)
                {
                    if ((((datas.type == "block")) && ((datas.player == 2))))
                    {
                        this._nbSlotsOtherOccupied++;
                    }
                    else
                    {
                        if ((((datas.type == "normal")) && ((datas.player == 1))))
                        {
                            this._nbSlotsOccupied--;
                        }
                        else
                        {
                            if ((((datas.type == "block")) && ((datas.player == 1))))
                            {
                                this._nbSlotsOccupied++;
                            }
                            else
                            {
                                if ((((datas.type == "normal")) && ((datas.player == 2))))
                                {
                                    this._nbSlotsOtherOccupied--;
                                };
                            };
                        };
                    };
                    slots[datas.index].emptyTexture = uiApi.createUri((uiApi.me().getConstant("assets") + (((datas.type == "block")) ? "tx_SlotVerrouille" : "tx_slot")));
                };
                if (datas.updateItemsNumber)
                {
                    this._nbItem = (this._nbItem + datas.updateItemsNumber);
                };
                if (datas.index < slots.length)
                {
                    slots[datas.index].refresh();
                };
            };
            this._prevItems = this.updateTabWithGid(playerList.componentList);
        }

        public function updatePlayer(componentList:Object, player:uint):Object
        {
            var val:ItemWrapper;
            var ingredients:Array = new Array();
            for each (val in componentList)
            {
                ingredients.push(val);
            };
            if (player == 1)
            {
                return (this.updateLogic(ingredients, this._nbItem, this._nbSlotsOccupied, this._nbSlotsOtherOccupied, _slotsIngredients, this._slotsIngredients_other, this._prevItems));
            };
            if (player == 2)
            {
                return (this.updateLogic(ingredients, this._nbItemOther, this._nbSlotsOtherOccupied, this._nbSlotsOccupied, this._slotsIngredients_other, _slotsIngredients, this._prevItemsOther));
            };
            throw ("You have to specify a player !!");
        }

        private function updateLogic(componentList:Array, nbItem:int, nbOccupied1:int, nbOccupied2:int, slots1:Array, slots2:Array, previousItems:Array):Object
        {
            var itemgid:int;
            var missingItemGid:int;
            var datas:Object = new Object();
            if (((((componentList[(componentList.length - 1)]) && (!((componentList[(componentList.length - 1)].objectGID == SIGNATURE_RUNE_ID))))) || ((componentList.length == 0))))
            {
                if (componentList.length > nbItem)
                {
                    itemgid = componentList[(componentList.length - 1)].objectGID;
                    if (!(this.hasItemInGrid(itemgid, slots1)))
                    {
                        datas.updateItemsNumber = 1;
                        if (!(this.hasItemInGrid(itemgid, slots2)))
                        {
                            datas.index = (_slotMax - (nbOccupied2 + 1));
                            datas.player = 2;
                            datas.type = "block";
                        }
                        else
                        {
                            if (nbOccupied1 > 0)
                            {
                                datas.index = (_slotMax - nbOccupied1);
                                datas.player = 1;
                                datas.type = "normal";
                            };
                        };
                    };
                }
                else
                {
                    if (componentList.length < nbItem)
                    {
                        missingItemGid = this.getMissingItemGid(componentList, previousItems);
                        if (missingItemGid == SIGNATURE_RUNE_ID)
                        {
                            return (datas);
                        };
                        datas.updateItemsNumber = -1;
                        if (this.hasItemInGrid(missingItemGid, slots2))
                        {
                            datas.index = (_slotMax - (nbOccupied1 + 1));
                            datas.type = "block";
                            datas.player = 1;
                        }
                        else
                        {
                            if (nbOccupied2 > 0)
                            {
                                datas.index = (_slotMax - nbOccupied2);
                                datas.type = "normal";
                                datas.player = 2;
                            };
                        };
                    }
                    else
                    {
                        datas.index = (nbItem - 1);
                        datas.player = 1;
                    };
                };
            };
            return (datas);
        }

        private function onOtherPlayerListUpdate(playerList:Object):void
        {
            var slots:Array;
            var datas:Object = this.updatePlayer(playerList.componentList, 2);
            if (((!((datas.index == null))) && ((datas.index >= 0))))
            {
                slots = (((datas.player == 2)) ? _slotsIngredients : this._slotsIngredients_other);
                if (datas.type)
                {
                    if ((((datas.type == "block")) && ((datas.player == 2))))
                    {
                        this._nbSlotsOccupied++;
                    }
                    else
                    {
                        if ((((datas.type == "normal")) && ((datas.player == 1))))
                        {
                            this._nbSlotsOtherOccupied--;
                        }
                        else
                        {
                            if ((((datas.type == "block")) && ((datas.player == 1))))
                            {
                                this._nbSlotsOtherOccupied++;
                            }
                            else
                            {
                                if ((((datas.type == "normal")) && ((datas.player == 2))))
                                {
                                    this._nbSlotsOccupied--;
                                };
                            };
                        };
                    };
                    slots[datas.index].emptyTexture = uiApi.createUri((uiApi.me().getConstant("assets") + (((datas.type == "block")) ? "tx_SlotVerrouille" : "tx_slot")));
                };
                if (datas.updateItemsNumber)
                {
                    this._nbItemOther = (this._nbItemOther + datas.updateItemsNumber);
                };
                if (datas.index < slots.length)
                {
                    slots[datas.index].refresh();
                };
            };
            this._prevItemsOther = this.updateTabWithGid(playerList.componentList);
            fillComponents(playerList.componentList, this._slotsIngredients_other, this.slot_signature_other);
            this.setOkButtonTemporaryDisabled();
        }

        public function hasItemInGrid(gid:int, data:Array):Boolean
        {
            var slot:Object;
            for each (slot in data)
            {
                if (((slot.data) && ((slot.data.objectGID == gid))))
                {
                    return (true);
                };
            };
            return (false);
        }

        private function updateTabWithGid(datas:Object):Array
        {
            var data:Object;
            var tab:Array = new Array();
            for each (data in datas)
            {
                if (tab.indexOf(data.objectGID) == -1)
                {
                    tab.push(data.objectGID);
                };
            };
            return (tab);
        }

        public function getMissingItemGid(list:Object, previousData:Array):int
        {
            var found:Boolean;
            var item:ItemWrapper;
            var id:int;
            for each (id in previousData)
            {
                found = false;
                for each (item in list)
                {
                    if (id == item.objectGID)
                    {
                        found = true;
                    };
                };
                if (!(found))
                {
                    return (id);
                };
            };
            return (-1);
        }

        private function isInOneOfTheGrid(gid:int):Boolean
        {
            return (this.hasItemInGrid(gid, _slotsIngredients.concat(this._slotsIngredients_other)));
        }

        private function onPaymentCraftList(paymentData:Object, highlight:Boolean):void
        {
            this._lastPaymentData = paymentData;
            if (((highlight) && (!(uiApi.getUi("payment")))))
            {
                modCommon.createPaymentObject(paymentData, this._isPlayerCrafter, false);
            };
        }

        private function onTimerDelayValidateButton(e:TimerEvent):void
        {
            btn_ok.disabled = false;
        }

        override protected function setQuantityDisabled(disabled:Boolean):void
        {
            if ((((this._nbSlotsOtherOccupied > 0)) && ((this._nbSlotsOccupied == 0))))
            {
                super.setQuantityDisabled(disabled);
            }
            else
            {
                super.setQuantityDisabled(true);
            };
        }

        override protected function isValidContent(slot:Object, item:Object):Boolean
        {
            switch (slot)
            {
                case this.slot_signature_other:
                    if (item.id == SIGNATURE_RUNE_ID)
                    {
                        return (true);
                    };
                    return (false);
                case this.slot_ingredient_1_other:
                case this.slot_ingredient_2_other:
                case this.slot_ingredient_3_other:
                case this.slot_ingredient_4_other:
                case this.slot_ingredient_5_other:
                case this.slot_ingredient_6_other:
                case this.slot_ingredient_7_other:
                case this.slot_ingredient_8_other:
                    if (item.id == SIGNATURE_RUNE_ID)
                    {
                        return (false);
                    };
                    return (true);
                default:
                    return (super.isValidContent(slot, item));
            };
        }

        override protected function setMaxSlotAvailable(quantity:int):void
        {
            super.setMaxSlotAvailable(quantity);
            quantity = _slotMax;
            var i:int = quantity;
            while (i < MAX_SLOT_NUMBER)
            {
                if (this._slotsIngredients_other[i])
                {
                    this._slotsIngredients_other[i].emptyTexture = uiApi.createUri((uiApi.me().getConstant("assets") + "tx_SlotVerrouille"));
                };
                i++;
            };
            if (_slotMax >= MAX_SLOT_NUMBER)
            {
                if (this._isPlayerCrafter)
                {
                    slot_signature.visible = true;
                    this.slot_signature_other.visible = false;
                }
                else
                {
                    slot_signature.visible = false;
                    this.slot_signature_other.visible = true;
                };
            }
            else
            {
                this.slot_signature_other.visible = false;
            };
        }

        override protected function getFilledSlots():Array
        {
            var slot1:Object;
            var exist:Boolean;
            var i:int;
            var item:Object;
            var filledSlots:Array = super.getFilledSlots();
            var length:int = filledSlots.length;
            for each (slot1 in this._slotsIngredients_other)
            {
                if (slot1.data)
                {
                    exist = false;
                    i = 0;
                    while (i < length)
                    {
                        item = filledSlots[i];
                        if (item.objectGID == slot1.data.objectGID)
                        {
                            item.quantity = (item.quantity + slot1.data.quantity);
                            exist = true;
                        };
                        i++;
                    };
                    if (!(exist))
                    {
                        filledSlots.push({
                            "objectUID":slot1.data.objectUID,
                            "objectGID":slot1.data.objectGID,
                            "quantity":slot1.data.quantity
                        });
                    };
                };
            };
            return (filledSlots);
        }

        override protected function onConfirmCraftRecipe():void
        {
            _nbItemCrafted = 0;
            _nbItemToCraft = itemQuantity;
            if (itemQuantity > 1)
            {
                _isInAutoCraft = true;
            }
            else
            {
                _isInAutoCraft = false;
            };
            sysApi.sendAction(new ExchangeReady(true));
        }

        protected function switchReadyStep(step:uint):void
        {
            switch (step)
            {
                case READY_STEP_I_AM_READY:
                    this.switchUIColor(EXCHANGE_COLOR_GREEN);
                    this.switchOkButtonState(BUTTON_STATE_CANCEL);
                    break;
                case READY_STEP_HE_IS_READY:
                    this.switchUIColor(EXCHANGE_COLOR_GREEN);
                    this.switchOkButtonState(BUTTON_STATE_MERGE);
                    break;
                case READY_STEP_NOT_READY:
                default:
                    this.switchUIColor(EXCHANGE_COLOR_NORMAL);
                    this.switchOkButtonState(BUTTON_STATE_MERGE);
            };
        }

        override protected function switchOkButtonState(buttonState:int, disabled:Boolean=false):void
        {
            super.switchOkButtonState(buttonState, disabled);
            switch (buttonState)
            {
                case BUTTON_STATE_CANCEL:
                    btn_lbl_btn_ok.text = uiApi.getText("ui.common.cancel");
                    btn_ok.disabled = false;
                    btn_stop.disabled = true;
                    break;
                default:
                    btn_lbl_btn_ok.text = uiApi.getText("ui.common.merge");
            };
        }

        override protected function cleanAllItems():void
        {
            var slot:Object;
            super.cleanAllItems();
            for each (slot in this._slotsIngredients_other)
            {
                slot.data = null;
            };
            slot_signature.data = null;
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_ok:
                    if (okButtonState == BUTTON_STATE_CANCEL)
                    {
                        sysApi.sendAction(new ExchangeReady(false));
                    }
                    else
                    {
                        super.onRelease(target);
                    };
                    break;
                case this.btn_payment:
                    modCommon.createPaymentObject(this._lastPaymentData, this._isPlayerCrafter, false);
                    break;
                case this.ed_otherPlayer:
                    if (this._isPlayerCrafter)
                    {
                        sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
                    }
                    else
                    {
                        sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
                    };
                    break;
                default:
                    super.onRelease(target);
            };
        }

        override public function onRightClick(target:Object):void
        {
            if (target == this.ed_otherPlayer)
            {
                if (this._isPlayerCrafter)
                {
                    sysApi.sendAction(new DisplayContextualMenu(this._customerInfos.id));
                }
                else
                {
                    sysApi.sendAction(new DisplayContextualMenu(this._crafterInfos.id));
                };
            }
            else
            {
                super.onRightClick(target);
            };
        }

        override public function processDropToInventory(target:Object, data:Object, source:Object):void
        {
            if (source.getUi().name == "payment")
            {
                _waitingSlot = target;
                _waitingData = data;
                this._waitingGrid = source.getParent();
                if (data.quantity > 1)
                {
                    modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQtyDropPayment);
                }
                else
                {
                    this.onValidQtyDropPayment(1);
                };
            }
            else
            {
                super.processDropToInventory(target, data, source);
            };
        }

        override protected function isRecipeFull(recipe:Object, recipesComponents:Array):Boolean
        {
            var component:Object;
            var storageItems:Object;
            var recipeFull:Boolean = true;
            var missingIngrediend:Boolean;
            for each (component in recipe.ingredients)
            {
                storageItems = inventoryApi.getStorageObjectGID(component.objectGID, component.quantity);
                if (storageItems == null)
                {
                    if (!(this.isInOneOfTheGrid(component.objectGID)))
                    {
                        missingIngrediend = true;
                    };
                    recipeFull = false;
                }
                else
                {
                    recipesComponents.push(storageItems);
                };
            };
            if (missingIngrediend)
            {
                modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.craft.dontHaveAllIngredient"), [uiApi.getText("ui.common.ok")]);
            };
            return (recipeFull);
        }

        public function onValidQtyDropPayment(qty:Number):void
        {
            switch (this._waitingGrid.name)
            {
                case "gd_items":
                    sysApi.sendAction(new ExchangeItemObjectAddAsPayment(false, _waitingData.objectUID, false, qty));
                    break;
                case "gd_itemsBonus":
                    sysApi.sendAction(new ExchangeItemObjectAddAsPayment(true, _waitingData.objectUID, false, qty));
                    break;
            };
        }

        private function switchUIColor(value:int):void
        {
            switch (value)
            {
                case EXCHANGE_COLOR_GREEN:
                    tx_quantity_selected.gotoAndStop = "green";
                    tx_ingredients_selected.gotoAndStop = "green";
                    break;
                case EXCHANGE_COLOR_NORMAL:
                    tx_quantity_selected.visible = true;
                    tx_quantity_selected.gotoAndStop = "orange";
                    tx_ingredients_selected.visible = true;
                    tx_ingredients_selected.gotoAndStop = "orange";
                    break;
            };
        }

        protected function displayPlayerEntityWithLabel(playerInfos:Object, entityDisplayer:Object, labelInfos:Object, direction:int):void
        {
            displayPlayerEntity(playerInfos.look, entityDisplayer, direction);
            labelInfos.text = playerInfos.name;
        }

        private function setOkButtonTemporaryDisabled():void
        {
            btn_ok.disabled = true;
            this._timerDelay.reset();
            this._timerDelay.start();
        }

        public function set nbItem(value:int):void
        {
            this._nbItem = value;
        }

        public function set nbItemOther(value:int):void
        {
            this._nbItemOther = value;
        }

        public function set nbSlotsOtherOccupied(value:int):void
        {
            this._nbSlotsOtherOccupied = value;
        }

        public function set nbSlotsOccupied(value:int):void
        {
            this._nbSlotsOccupied = value;
        }

        public function set slotsIngredientsOther(value:Array):void
        {
            this._slotsIngredients_other = value;
        }

        public function set prevItems(val:Array):void
        {
            this._prevItems = val;
        }

        public function set prevItemsOther(val:Array):void
        {
            this._prevItemsOther = val;
        }


    }
}//package ui

