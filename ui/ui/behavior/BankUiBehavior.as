package ui.behavior
{
    import ui.BankUi;
    import d2actions.ExchangeObjectMove;
    import d2hooks.ClickItemInventory;
    import d2hooks.ShowObjectLinked;
    import ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import ui.enum.StorageState;
    import d2actions.ExchangeObjectMoveKama;
    import d2actions.ExchangeObjectTransfertAllToInv;
    import d2actions.ExchangeObjectTransfertListToInv;
    import d2actions.ExchangeObjectTransfertExistingToInv;
    import d2actions.*;
    import d2hooks.*;

    public class BankUiBehavior implements IStorageBehavior 
    {

        protected var _bank:BankUi;
        private var _objectToExchange:Object;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if (data.position != 63)
            {
                return (false);
            };
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            var quantityMax:uint;
            var weightLeft:uint;
            if (this.dropValidator(target, data, source))
            {
                if (data.quantity > 1)
                {
                    this._objectToExchange = data;
                    quantityMax = data.quantity;
                    if (this._bank.getWeightMax() > 0)
                    {
                        weightLeft = (this._bank.getWeightMax() - this._bank.getWeight());
                        if ((data.realWeight * data.quantity) > weightLeft)
                        {
                            quantityMax = Math.floor((weightLeft / data.realWeight));
                        };
                    };
                    Api.common.openQuantityPopup(1, quantityMax, quantityMax, this.onValidQty);
                }
                else
                {
                    Api.system.sendAction(new ExchangeObjectMove(data.objectUID, 1));
                };
            };
        }

        private function onValidNegativeQty(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, -(qty)));
        }

        public function onValidQtyDrop(qty:Number):void
        {
        }

        private function onValidQty(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, qty));
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this._bank.kamaCtr:
                    if (this._bank.kamas > 0)
                    {
                        Api.common.openQuantityPopup(1, this._bank.kamas, this._bank.kamas, this.onValidQtyKama);
                    };
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            var weight:uint;
            var maxWeight:uint;
            var quantityMax:uint;
            var weightLeft:uint;
            switch (target)
            {
                case this._bank.grid:
                    _local_4 = this._bank.grid.selectedItem;
                    if (selectMethod == 0)
                    {
                        Api.system.dispatchHook(ClickItemInventory, _local_4);
                        if (!(Api.system.getOption("displayTooltips", "dofus")))
                        {
                            Api.system.dispatchHook(ShowObjectLinked, _local_4);
                        };
                    }
                    else
                    {
                        if (selectMethod == 1)
                        {
                            if (this.bankContainItem(_local_4.objectUID))
                            {
                                Api.system.sendAction(new ExchangeObjectMove(_local_4.objectUID, -1));
                            };
                        }
                        else
                        {
                            if (selectMethod == 9)
                            {
                                if (this.bankContainItem(_local_4.objectUID))
                                {
                                    weight = Api.player.inventoryWeight();
                                    maxWeight = Api.player.inventoryWeightMax();
                                    quantityMax = _local_4.quantity;
                                    weightLeft = (maxWeight - weight);
                                    if ((_local_4.realWeight * _local_4.quantity) > weightLeft)
                                    {
                                        quantityMax = Math.floor((weightLeft / _local_4.realWeight));
                                    };
                                    Api.system.sendAction(new ExchangeObjectMove(_local_4.objectUID, -(quantityMax)));
                                };
                            }
                            else
                            {
                                if (selectMethod == 10)
                                {
                                    this._objectToExchange = target.selectedItem;
                                    Api.common.openQuantityPopup(1, target.selectedItem.quantity, target.selectedItem.quantity, this.onValidNegativeQty);
                                };
                            };
                        };
                    };
                    break;
            };
        }

        public function attach(bankUi:AbstractStorageUi):void
        {
            if (!((bankUi is BankUi)))
            {
                throw (new Error("Can't attach a BankUiBehavior to a non BankUi storage"));
            };
            this._bank = (bankUi as BankUi);
            this._bank.questVisible = false;
            this._bank.btnMoveAll.visible = true;
            this._bank.kamaCtr.mouseEnabled = true;
            this._bank.kamaCtr.handCursor = true;
        }

        public function detach():void
        {
            this._bank.questVisible = true;
            this._bank.btnMoveAll.visible = false;
        }

        public function onUnload():void
        {
        }

        public function getStorageUiName():String
        {
            return (UIEnum.BANK_UI);
        }

        public function getName():String
        {
            return (StorageState.BANK_UI_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        private function onValidQtyKama(qty:Number):void
        {
            Api.system.sendAction(new ExchangeObjectMoveKama(-(qty)));
        }

        private function bankContainItem(uid:uint):Boolean
        {
            var i:int;
            var dataProvider:* = this._bank.grid.dataProvider;
            var len:int = dataProvider.length;
            i = 0;
            while (i < len)
            {
                if (dataProvider[i].objectUID == uid)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function transfertAll():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertAllToInv());
        }

        public function transfertList():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertListToInv(this._bank.itemsDisplayed));
        }

        public function transfertExisting():void
        {
            Api.system.sendAction(new ExchangeObjectTransfertExistingToInv());
        }


    }
}//package ui.behavior

