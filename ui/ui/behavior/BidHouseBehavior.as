package ui.behavior
{
    import ui.StorageUi;
    import d2enums.SelectMethodEnum;
    import ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.LeaveShopStock;
    import ui.enum.StorageState;
    import d2actions.*;
    import d2hooks.*;

    public class BidHouseBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _bidHouseFilter:Boolean = false;


        public function filterStatus(enabled:Boolean):void
        {
            Api.system.setData("filterBidHouseStorage", enabled);
            this.refreshFilter();
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (false);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
        }

        public function onValidQtyDrop(qty:Number):void
        {
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:Object;
            switch (target)
            {
                case this._storage.grid:
                    _local_4 = this._storage.grid.selectedItem;
                    if (selectMethod == SelectMethodEnum.CLICK)
                    {
                        Api.ui.getUi("itemBidHouseSell").uiClass.onSelectItemFromInventory(_local_4);
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
            Api.system.disableWorldInteraction();
            this._storage.questVisible = false;
            this._storage.setDropAllowed(false, "behavior");
            this._storage.btnMoveAll.visible = false;
            this._storage.showFilter(Api.ui.getText("ui.bidhouse.bigStoreFilter"), Api.system.getData("filterBidHouseStorage"));
            this.refreshFilter();
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            Api.storage.disableBidHouseFilter();
            this._storage.questVisible = true;
            this._storage.setDropAllowed(true, "behavior");
            this._storage.hideFilter();
            this._storage.btnMoveAll.visible = true;
        }

        public function onUnload():void
        {
            if (((Api.ui.getUi(UIEnum.BIDHOUSE_STOCK)) && (!(Api.ui.getUi(UIEnum.BIDHOUSE_STOCK).uiClass.isSwitching()))))
            {
                Api.system.sendAction(new LeaveShopStock());
                Api.ui.unloadUi(UIEnum.BIDHOUSE_STOCK);
            };
        }

        private function refreshFilter():void
        {
            var info:Object;
            if (this._storage.btn_filter.selected)
            {
                info = Api.ui.getUi("itemBidHouseSell").uiClass._sellerDescriptor;
                Api.storage.enableBidHouseFilter(info.types, info.maxItemLevel);
            }
            else
            {
                Api.storage.disableBidHouseFilter();
            };
            Api.storage.updateStorageView();
            Api.storage.releaseHooks();
        }

        public function getStorageUiName():String
        {
            return (UIEnum.STORAGE_UI);
        }

        public function getName():String
        {
            return (StorageState.BID_HOUSE_MOD);
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

