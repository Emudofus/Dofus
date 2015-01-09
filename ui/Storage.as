package 
{
    import flash.display.Sprite;
    import ui.StorageUi;
    import ui.BankUi;
    import ui.EquipmentUi;
    import ui.PresetUi;
    import ui.LivingObject;
    import ui.Mimicry;
    import d2api.ContextMenuApi;
    import d2api.StorageApi;
    import d2api.InventoryApi;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.PlayedCharacterApi;
    import d2api.DataApi;
    import d2api.SoundApi;
    import d2hooks.OpenInventory;
    import d2hooks.CloseInventory;
    import d2hooks.ExchangeStartedType;
    import d2hooks.ExchangeBankStarted;
    import d2hooks.ObjectAdded;
    import d2hooks.ObjectDeleted;
    import d2hooks.ObjectModified;
    import d2hooks.OpenLivingObject;
    import d2hooks.ExchangeBankStartedWithStorage;
    import d2hooks.EquipmentObjectMove;
    import d2hooks.MountRiding;
    import d2hooks.ClientUIOpened;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2enums.ExchangeTypeEnum;
    import ui.enum.StorageState;
    import util.StorageBehaviorManager;
    import d2enums.ClientUITypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2enums.CharacterInventoryPositionEnum;
    import d2hooks.*;

    public class Storage extends Sprite 
    {

        public static var bidIsSwitching:Boolean = false;

        private var include_StorageUi:StorageUi = null;
        private var include_BankUi:BankUi = null;
        private var include_EquipmentUi:EquipmentUi = null;
        private var include_PresetUi:PresetUi = null;
        private var include_livingObject:LivingObject = null;
        private var include_mimicry:Mimicry = null;
        public var menuApi:ContextMenuApi;
        public var storageApi:StorageApi;
        public var inventoryApi:InventoryApi;
        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var dataApi:DataApi;
        public var soundApi:SoundApi;
        private var _inventory:Object;
        private var _kamas:uint;
        private var _weight:uint;
        private var _weightMax:uint;
        private var _waitingObject:Object;
        private var _waitingObjectName:String;
        private var _waitingObjectQuantity:int;
        private var _currentStorageMod:uint = 0;


        public function main():void
        {
            Api.common = this.modCommon;
            Api.menu = this.menuApi;
            Api.sound = this.soundApi;
            Api.storage = this.storageApi;
            Api.system = this.sysApi;
            Api.ui = this.uiApi;
            Api.data = this.dataApi;
            Api.player = this.playerApi;
            Api.inventory = this.inventoryApi;
            this.sysApi.addHook(OpenInventory, this.onOpenInventory);
            this.sysApi.addHook(CloseInventory, this.onCloseInventory);
            this.sysApi.addHook(ExchangeStartedType, this.onExchangeStartedType);
            this.sysApi.addHook(ExchangeBankStarted, this.onExchangeBankStarted);
            this.sysApi.addHook(ObjectAdded, this.onObjectAdded);
            this.sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            this.sysApi.addHook(ObjectModified, this.onObjectModified);
            this.sysApi.addHook(OpenLivingObject, this.onOpenLivingObject);
            this.sysApi.addHook(ExchangeBankStartedWithStorage, this.onExchangeStartedWithStorage);
            this.sysApi.addHook(EquipmentObjectMove, this.onEquipmentObjectMove);
            this.sysApi.addHook(MountRiding, this.onMountRiding);
            this.sysApi.addHook(ClientUIOpened, this.onClientUIOpened);
        }

        private function onExchangeStartedType(exchangeType:int):void
        {
            var _local_2:Object;
            switch (exchangeType)
            {
                case ExchangeTypeEnum.STORAGE:
                    if (!(this.uiApi.getUi(UIEnum.BANK_UI)))
                    {
                        this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {"exchangeType":exchangeType});
                    };
                    break;
                case ExchangeTypeEnum.TAXCOLLECTOR:
                    if (!(this.uiApi.getUi(UIEnum.BANK_UI)))
                    {
                        this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {"exchangeType":exchangeType});
                    };
                    break;
                case ExchangeTypeEnum.MOUNT:
                    _local_2 = this.uiApi.getUi(UIEnum.MOUNT_INFO);
                    if (_local_2)
                    {
                        _local_2.visible = false;
                    };
                    break;
            };
        }

        private function onExchangeStartedWithStorage(exchangeType:int, maxSlots:uint):void
        {
            switch (exchangeType)
            {
                case ExchangeTypeEnum.STORAGE:
                    if (!(this.uiApi.getUi(UIEnum.BANK_UI)))
                    {
                        this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {
                            "exchangeType":exchangeType,
                            "maxSlots":maxSlots
                        });
                    };
                    break;
            };
        }

        private function onExchangeBankStarted(exchangeType:int, objects:Object, kamas:uint):void
        {
            var _local_5:Object;
            var behavior:String = StorageState.BANK_MOD;
            switch (exchangeType)
            {
                case ExchangeTypeEnum.MOUNT:
                    _local_5 = this.uiApi.getUi(UIEnum.MOUNT_INFO);
                    if (_local_5)
                    {
                        _local_5.visible = false;
                    };
                    behavior = StorageState.MOUNT_MOD;
                    break;
            };
            if (!(this.uiApi.getUi(UIEnum.BANK_UI)))
            {
                this.uiApi.loadUi(UIEnum.BANK_UI, UIEnum.BANK_UI, {
                    "inventory":objects,
                    "kamas":kamas,
                    "exchangeType":exchangeType
                });
            };
        }

        private function onOpenInventory(behaviorName:String):void
        {
            if (!(this.playerApi.characteristics()))
            {
                return;
            };
            this._inventory = this.storageApi.getViewContent("storage");
            this._kamas = this.playerApi.characteristics().kamas;
            this._weight = this.playerApi.inventoryWeight();
            this._weightMax = this.playerApi.inventoryWeightMax();
            var load:Boolean;
            var unload:Boolean;
            var uiName:String = StorageBehaviorManager.makeBehavior(behaviorName).getStorageUiName();
            var storageUi:Object = this.uiApi.getUi(UIEnum.STORAGE_UI);
            if (storageUi)
            {
                if ((((((storageUi.uiClass is EquipmentUi)) && ((uiName == UIEnum.EQUIPMENT_UI)))) || (((!((storageUi.uiClass is EquipmentUi))) && ((uiName == UIEnum.STORAGE_UI))))))
                {
                    load = false;
                }
                else
                {
                    unload = true;
                    load = true;
                };
            }
            else
            {
                load = true;
            };
            if (unload)
            {
                this.uiApi.unloadUi(UIEnum.STORAGE_UI);
            };
            if (load)
            {
                this.uiApi.loadUi(uiName, UIEnum.STORAGE_UI, {"storageMod":behaviorName}, 1);
            }
            else
            {
                if (storageUi.uiClass.currentStorageBehavior.replacable)
                {
                    storageUi.uiClass.switchBehavior(behaviorName);
                };
            };
        }

        private function onCloseInventory():void
        {
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                this.uiApi.unloadUi(UIEnum.STORAGE_UI);
            };
        }

        private function onOpenLivingObject(item:Object):void
        {
            this.uiApi.unloadUi("livingObject");
            if (item)
            {
                this.uiApi.loadUi("livingObject", "livingObject", {"item":item});
            };
        }

        private function onClientUIOpened(type:uint, uid:uint):void
        {
            if (type == ClientUITypeEnum.CLIENT_UI_OBJECT_MIMICRY)
            {
                if (!(this.uiApi.getUi("mimicry")))
                {
                    this.uiApi.loadUi("mimicry", "mimicry", uid);
                };
                this.sysApi.dispatchHook(OpenInventory, "mimicry");
            };
        }

        private function playItemMovedSound():void
        {
            if (this.uiApi.getUi(UIEnum.STORAGE_UI))
            {
                this.soundApi.playSound(SoundTypeEnum.MOVE_ITEM_TO_BAG);
            };
        }

        private function onObjectAdded(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        private function onObjectDeleted(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        private function onObjectModified(pItem:Object):void
        {
            this.playItemMovedSound();
        }

        public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int):void
        {
            if (((!(pItemWrapper)) || ((pItemWrapper.position > CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD))))
            {
                return;
            };
            switch (pItemWrapper.position)
            {
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_NECKLACE);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BUCKLER);
                    break;
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CIRCLE);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CLOTHES);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BOOT);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_WEAPON);
                    break;
                case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
                    break;
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
                case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
                    this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_DOFUS);
                    break;
            };
        }

        public function onMountRiding(isRidding:Boolean):void
        {
            this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
        }


    }
}//package 

