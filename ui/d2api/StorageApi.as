package d2api
{
    import d2data.MountWrapper;

    public class StorageApi 
    {


        [Untrusted]
        public function itemSuperTypeToServerPosition(superTypeId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getLivingObjectFood(itemType:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getPetFood(id:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getRideFoods():Object
        {
            return (null);
        }

        [Untrusted]
        public function getViewContent(name:String):Object
        {
            return (null);
        }

        [Untrusted]
        public function getShortcutBarContent(barType:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getFakeItemMount():MountWrapper
        {
            return (null);
        }

        [Untrusted]
        public function getBestEquipablePosition(item:Object):int
        {
            return (0);
        }

        [Untrusted]
        public function addItemMask(itemUID:int, name:String, quantity:int):void
        {
        }

        [Untrusted]
        public function removeItemMask(itemUID:int, name:String):void
        {
        }

        [Untrusted]
        public function removeAllItemMasks(name:String):void
        {
        }

        [Untrusted]
        public function releaseHooks():void
        {
        }

        [Untrusted]
        public function releaseBankHooks():void
        {
        }

        [Untrusted]
        public function dracoTurkyInventoryWeight():uint
        {
            return (0);
        }

        [Untrusted]
        public function dracoTurkyMaxInventoryWeight():uint
        {
            return (0);
        }

        [Untrusted]
        public function getStorageTypes(category:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getBankStorageTypes(category:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function setDisplayedCategory(category:int):void
        {
        }

        [Untrusted]
        public function setDisplayedBankCategory(category:int):void
        {
        }

        [Untrusted]
        public function getDisplayedCategory():int
        {
            return (0);
        }

        [Untrusted]
        public function getDisplayedBankCategory():int
        {
            return (0);
        }

        [Untrusted]
        public function setStorageFilter(typeId:int):void
        {
        }

        [Untrusted]
        public function setBankStorageFilter(typeId:int):void
        {
        }

        [Untrusted]
        public function getStorageFilter():int
        {
            return (0);
        }

        [Untrusted]
        public function getBankStorageFilter():int
        {
            return (0);
        }

        [Untrusted]
        public function updateStorageView():void
        {
        }

        [Untrusted]
        public function updateBankStorageView():void
        {
        }

        [Untrusted]
        public function sort(sortField:int, revert:Boolean):void
        {
        }

        [Untrusted]
        public function resetSort():void
        {
        }

        [Untrusted]
        public function sortBank(sortField:int, revert:Boolean):void
        {
        }

        [Untrusted]
        public function resetBankSort():void
        {
        }

        [Untrusted]
        public function getSortFields():Object
        {
            return (null);
        }

        [Untrusted]
        public function getSortBankFields():Object
        {
            return (null);
        }

        [Untrusted]
        public function unsort():void
        {
        }

        [Untrusted]
        public function unsortBank():void
        {
        }

        [Untrusted]
        public function enableBidHouseFilter(allowedTypes:Object, maxItemLevel:uint):void
        {
        }

        [Untrusted]
        public function disableBidHouseFilter():void
        {
        }

        [Untrusted]
        public function getIsBidHouseFilterEnabled():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function enableSmithMagicFilter(skill:Object):void
        {
        }

        [Untrusted]
        public function disableSmithMagicFilter():void
        {
        }

        [Untrusted]
        public function enableCraftFilter(skill:Object, slotCount:int):void
        {
        }

        [Untrusted]
        public function disableCraftFilter():void
        {
        }

        [Untrusted]
        public function getIsSmithMagicFilterEnabled():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getItemMaskCount(objectUID:int, mask:String):int
        {
            return (0);
        }


    }
}//package d2api

