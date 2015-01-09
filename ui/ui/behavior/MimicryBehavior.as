package ui.behavior
{
    import ui.StorageUi;
    import d2data.ItemWrapper;
    import d2hooks.ObjectSelected;
    import d2enums.SelectMethodEnum;
    import ui.AbstractStorageUi;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import ui.enum.StorageState;
    import d2actions.*;
    import d2hooks.*;

    public class MimicryBehavior implements IStorageBehavior 
    {

        private var _storage:StorageUi;
        private var _waitingObject:Object;
        private var _mimicryUi:Object;
        protected var _showFilter:Boolean = true;


        public function filterStatus(enabled:Boolean):void
        {
        }

        public function get mimicryUi():Object
        {
            if (!(this._mimicryUi))
            {
                this._mimicryUi = Api.ui.getUi("mimicry").uiClass;
            };
            return (this._mimicryUi);
        }

        public function dropValidator(target:Object, data:Object, source:Object):Boolean
        {
            return (true);
        }

        public function processDrop(target:Object, data:Object, source:Object):void
        {
            this.mimicryUi.processDropToInventory(target, data, source);
        }

        public function onRelease(target:Object):void
        {
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:ItemWrapper;
            var _local_5:ItemWrapper;
            switch (target)
            {
                case this._storage.grid:
                    _local_4 = this._storage.grid.selectedItem;
                    if (!(_local_4))
                    {
                        return;
                    };
                    _local_5 = Api.data.getItemWrapper(_local_4.objectGID, _local_4.position, _local_4.objectUID, 1, _local_4.effectsList);
                    switch (selectMethod)
                    {
                        case SelectMethodEnum.CLICK:
                            if (!(Api.system.getOption("displayTooltips", "dofus")))
                            {
                                Api.system.dispatchHook(ObjectSelected, {"data":_local_5});
                            };
                            break;
                        case SelectMethodEnum.DOUBLE_CLICK:
                        case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                        case SelectMethodEnum.ALT_DOUBLE_CLICK:
                            if (((Api.inventory.getItem(_local_5.objectUID)) && ((_local_5.category == 0))))
                            {
                                Api.ui.hideTooltip();
                                this.mimicryUi.fillAutoSlot(_local_5);
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
                throw (new Error("Can't attach a MimicryBehavior to a non StorageUi storage"));
            };
            this._storage = (storageUi as StorageUi);
            Api.system.disableWorldInteraction();
            this._storage.categoryFilter = 0;
            this._storage.btnMoveAll.visible = false;
            this._storage.questVisible = false;
        }

        public function detach():void
        {
            Api.system.enableWorldInteraction();
            this._storage.btnMoveAll.visible = true;
            this._storage.questVisible = true;
        }

        public function onUnload():void
        {
            if (Api.ui.getUi("mimicry"))
            {
                Api.ui.unloadUi("mimicry");
            };
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
            return (StorageState.MIMICRY_MOD);
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

