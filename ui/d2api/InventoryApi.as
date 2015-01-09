package d2api
{
    import d2data.ItemWrapper;
    import d2data.QuantifiedItemWrapper;
    import d2data.SimpleTextureWrapper;

    public class InventoryApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getStorageObjectGID(pObjectGID:uint, quantity:uint=1):Object
        {
            return (null);
        }

        [Untrusted]
        public function getStorageObjectsByType(objectType:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getItemQty(pObjectGID:uint, pObjectUID:uint=0):uint
        {
            return (0);
        }

        [Untrusted]
        public function getItemByGID(objectGID:uint):ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getQuantifiedItemByGIDInInventoryOrMakeUpOne(objectGID:uint):QuantifiedItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getItem(objectUID:uint):ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getEquipementItemByPosition(pPosition:uint):ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getEquipement():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEquipementForPreset():Object
        {
            return (null);
        }

        [Untrusted]
        public function getVoidItemForPreset(index:int):SimpleTextureWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentWeapon():ItemWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getPresets():Object
        {
            return (null);
        }

        [Trusted]
        public function removeSelectedItem():Boolean
        {
            return (false);
        }


    }
}//package d2api

