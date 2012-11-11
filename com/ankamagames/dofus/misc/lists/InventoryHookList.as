package com.ankamagames.dofus.misc.lists
{
    import com.ankamagames.berilia.types.data.*;

    public class InventoryHookList extends Object
    {
        public static const StorageInventoryContent:Hook = new Hook("StorageInventoryContent", false);
        public static const StorageObjectUpdate:Hook = new Hook("StorageObjectUpdate", false);
        public static const StorageKamasUpdate:Hook = new Hook("StorageKamasUpdate", false);
        public static const StorageObjectRemove:Hook = new Hook("StorageObjectRemove", false);
        public static const EquipmentObjectMove:Hook = new Hook("EquipmentObjectMove", false);
        public static const SetUpdate:Hook = new Hook("SetUpdate", false);
        public static const InventoryWeight:Hook = new Hook("InventoryWeight", false);
        public static const ObjectAdded:Hook = new Hook("ObjectAdded", false);
        public static const ObjectDeleted:Hook = new Hook("ObjectDeleted", false);
        public static const ObjectQuantity:Hook = new Hook("ObjectQuantity", false);
        public static const ObjectModified:Hook = new Hook("ObjectModified", false);
        public static const ObjectSelected:Hook = new Hook("ObjectSelected", false);
        public static const StorageViewContent:Hook = new Hook("StorageViewContent", false);
        public static const BankViewContent:Hook = new Hook("BankViewContent", false);
        public static const EquipmentViewContent:Hook = new Hook("EquipmentViewContent", false);
        public static const RoleplayBuffViewContent:Hook = new Hook("RoleplayBuffViewContent", false);
        public static const ShortcutBarViewContent:Hook = new Hook("ShortcutBarViewContent", false);
        public static const InventoryContent:Hook = new Hook("InventoryContent", false);
        public static const KamasUpdate:Hook = new Hook("KamasUpdate", false);
        public static const OpenLivingObject:Hook = new Hook("OpenLivingObject", false);
        public static const WeaponUpdate:Hook = new Hook("WeaponUpdate", false);
        public static const PresetsUpdate:Hook = new Hook("PresetsUpdate", false);
        public static const PresetSelected:Hook = new Hook("PresetSelected", false);
        public static const PresetError:Hook = new Hook("PresetError", false);

        public function InventoryHookList()
        {
            return;
        }// end function

    }
}
