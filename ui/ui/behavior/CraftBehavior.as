package ui.behavior
{
    import ui.StorageUi;
    import d2hooks.ObjectSelected;
    import d2enums.SelectMethodEnum;
    import ui.AbstractStorageUi;
    import d2hooks.ExchangeLeave;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.LeaveDialogRequest;
    import ui.enum.StorageState;
    import d2actions.*;
    import d2hooks.*;

    public class CraftBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _waitingObject:Object;
        private var _craftUi:Object;
        protected var _showFilter:Boolean = true;


        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData("filterCraftStorage", this._storage.btn_filter.selected);
            this.refreshFilter();
        }

        public function get craftUi():Object
        {
            if (!(this._craftUi))
            {
                this._craftUi = Api.ui.getUi("craft").uiClass;
            };
            return (this._craftUi);
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            this.craftUi.processDropToInventory(target, data, source);
        }

        public function onValidQty(qty:Number):void
        {
            var craftUi2:Object = Api.ui.getUi("craft").uiClass;
            craftUi2.fillAutoSlot(this._waitingObject, qty);
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            var craftUi:Object;
            var craftUi2:Object;
            switch (target)
            {
                case this._storage.grid:
                    _local_4 = this._storage.grid.selectedItem;
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (!(Api.system.getOption("displayTooltips", "dofus")))
                            {
                                Api.system.dispatchHook(ObjectSelected, {"data":_local_4});
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                            if (Api.inventory.getItem(_local_4.objectUID))
                            {
                                Api.ui.hideTooltip();
                                craftUi = Api.ui.getUi("craft").uiClass;
                                craftUi.fillAutoSlot(_local_4, 1);
                            };
                            break;
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                            if (Api.inventory.getItem(_local_4.objectUID))
                            {
                                craftUi2 = Api.ui.getUi("craft").uiClass;
                                craftUi2.fillAutoSlot(_local_4, _local_4.quantity);
                            };
                            break;
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            this._waitingObject = _local_4;
                            Api.common.openQuantityPopup(1, _local_4.quantity, _local_4.quantity, this.onValidQty);
                            break;
                    };
                    break;
            };
        }

        public function attach(storageUi:AbstractStorageUi):void
        {
            if (!((storageUi is StorageUi)))
            {
                throw (new Error("Can't attach a CraftBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            Api.system.disableWorldInteraction();
            this._storage.btnMoveAll.visible = false;
            this._storage.questVisible = false;
            if (this._showFilter)
            {
                this._storage.showFilter(Api.ui.getText("ui.craft.craftFilter"), Api.system.getData("filterCraftStorage"));
            };
            this.refreshFilter();
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            this._storage.btnMoveAll.visible = true;
            this._storage.questVisible = true;
        }

        public function onUnload():void
        {
            Api.storage.disableCraftFilter();
            Api.system.removeHook(ExchangeLeave);
            if (Api.ui.getUi(UIEnum.CRAFT))
            {
                Api.ui.unloadUi(UIEnum.CRAFT);
            }
            else
            {
                if (Api.ui.getUi(UIEnum.CRAFT_COOP))
                {
                    Api.ui.unloadUi(UIEnum.CRAFT_COOP);
                };
            };
            Api.system.sendAction(new LeaveDialogRequest());
        }

        public function isDefaultBehavior():Boolean
        {
            return (false);
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.CRAFT_MOD);
        }

        public function get replacable():Boolean
        {
            return (false);
        }

        private function refreshFilter():void
        {
            if (this.craftUi.skill.id == 209)
            {
                return;
            };
            if (this._showFilter)
            {
                if (this._storage.btn_filter.selected)
                {
                    Api.storage.enableCraftFilter(this.craftUi.skill, this.craftUi.slotMax);
                }
                else
                {
                    Api.storage.disableCraftFilter();
                };
                Api.storage.updateStorageView();
                Api.storage.releaseHooks();
            }
            else
            {
                Api.storage.disableCraftFilter();
            };
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

