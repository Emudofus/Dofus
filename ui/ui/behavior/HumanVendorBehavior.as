package ui.behavior
{
    import ui.StorageUi;
    import ui.AbstractStorageUi;
    import d2data.ItemWrapper;
    import d2hooks.ClickItemInventory;
    import d2hooks.AskExchangeMoveObject;
    import d2actions.ExchangeObjectMove;
    import d2enums.SelectMethodEnum;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import ui.enum.StorageState;
    import d2actions.*;
    import d2hooks.*;

    public class HumanVendorBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _objectToExchange:Object;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            if ((((data is ItemWrapper)) && (!((this._storage.categoryFilter == AbstractStorageUi.QUEST_CATEGORY)))))
            {
                if (data.position != 63)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            Api.system.dispatchHook(ClickItemInventory, data);
        }

        public function onValidQtyDrop(qty:Number):void
        {
        }

        private function onValidQty(qty:Number):void
        {
            Api.system.dispatchHook(AskExchangeMoveObject, this._objectToExchange.objectUID, qty);
            Api.system.sendAction(new ExchangeObjectMove(this._objectToExchange.objectUID, qty));
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            var _local_5:Boolean;
            var effect:*;
            switch (target)
            {
                case this._storage.grid:
                    _local_4 = this._storage.grid.selectedItem;
                    _local_5 = true;
                    if ((_local_4 is ItemWrapper))
                    {
                        for each (effect in _local_4.effects)
                        {
                            if ((((effect.effectId == 982)) || ((effect.effectId == 983))))
                            {
                                _local_5 = false;
                            };
                        };
                    }
                    else
                    {
                        _local_5 = false;
                    };
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (_local_5)
                            {
                                Api.system.dispatchHook(ClickItemInventory, _local_4);
                            }
                            else
                            {
                                Api.system.dispatchHook(ClickItemInventory, null);
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            if (_local_5)
                            {
                                Api.ui.hideTooltip();
                            };
                            break;
                    };
                    break;
            };
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!((storageUi is StorageUi)))
            {
                throw (new Error("Can't attach a BidHouseBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            if (this._storage.playerLook)
            {
                this._storage.playerLook.look = null;
            };
            this._storage.setDropAllowed(false, "behavior");
            this._storage.questVisible = false;
            this._storage.btnMoveAll.visible = false;
        }

        public function detach():void
        {
            this._storage.setDropAllowed(true, "behavior");
            this._storage.questVisible = true;
            this._storage.btnMoveAll.visible = true;
            Api.ui.unloadUi(UIEnum.HUMAN_VENDOR_STOCK);
        }

        public function onUnload():void
        {
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.HUMAN_VENDOR_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        public function transfertAll():void
        {
        }

        public function transfertList():void
        {
        }

        public function transfertExisting():void
        {
        }


    }
}//package ui.behavior

