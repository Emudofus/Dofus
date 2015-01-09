package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
    import com.ankamagames.dofus.datacenter.livingObjects.Pet;
    import com.ankamagames.dofus.datacenter.mounts.RideFood;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
    import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.MountFrame;
    import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.datacenter.jobs.Skill;
    import __AS3__.vec.*;

    public class StorageApi implements IApi 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageApi));
        private static var _lastItemPosition:Array = new Array();
        public static const ITEM_TYPE_TO_SERVER_POSITION:Array = [[], [0], [1], [2, 4], [3], [5], [], [15], [1], [], [6], [7], [8], [9, 10, 11, 12, 13, 14], [], [20], [21], [22, 23], [24, 25], [26], [27], [16], [], [28]];


        [Untrusted]
        public static function itemSuperTypeToServerPosition(superTypeId:uint):Array
        {
            return (ITEM_TYPE_TO_SERVER_POSITION[superTypeId]);
        }

        [Untrusted]
        public static function getLivingObjectFood(itemType:int):Vector.<ItemWrapper>
        {
            var item:ItemWrapper;
            var itemList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("storage").content;
            var nb:int = inventory.length;
            var i:int;
            while (i < nb)
            {
                item = inventory[i];
                if (((!(item.isLivingObject)) && ((item.type.id == itemType))))
                {
                    itemList.push(item);
                };
                i++;
            };
            return (itemList);
        }

        [Untrusted]
        public static function getPetFood(id:int):Vector.<ItemWrapper>
        {
            var inventory:Vector.<ItemWrapper>;
            var foodItems:Vector.<int>;
            var foodTypeItems:Vector.<int>;
            var nb:int;
            var i:int;
            var item:ItemWrapper;
            var itemList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
            var pet:Pet = Pet.getPetById(id);
            if (pet)
            {
                inventory = InventoryManager.getInstance().inventory.getView("storage").content;
                foodItems = Pet.getPetById(id).foodItems;
                foodTypeItems = Pet.getPetById(id).foodTypes;
                nb = inventory.length;
                i = 0;
                while (i < nb)
                {
                    item = inventory[i];
                    if ((((foodItems.indexOf(item.objectGID) > -1)) || ((foodTypeItems.indexOf(item.typeId) > -1))))
                    {
                        itemList.push(item);
                    };
                    i++;
                };
            };
            return (itemList);
        }

        [Untrusted]
        public static function getRideFoods():Array
        {
            var rideFood:RideFood;
            var item:ItemWrapper;
            var it:Item;
            var itemList:Array = new Array();
            var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("storage").content;
            var rideFoods:Array = RideFood.getRideFoods();
            var gids:Array = new Array();
            var typeIds:Array = new Array();
            for each (rideFood in rideFoods)
            {
                if (rideFood.gid != 0)
                {
                    gids.push(rideFood.gid);
                };
                if (rideFood.typeId != 0)
                {
                    typeIds.push(rideFood.typeId);
                };
            };
            for each (item in inventory)
            {
                it = Item.getItemById(item.objectGID);
                if (((!((gids.indexOf(item.objectGID) == -1))) || (!((typeIds.indexOf(it.typeId) == -1)))))
                {
                    itemList.push(item);
                };
            };
            return (itemList);
        }

        [Untrusted]
        public static function getViewContent(name:String):Vector.<ItemWrapper>
        {
            var view:IInventoryView = InventoryManager.getInstance().inventory.getView(name);
            if (view)
            {
                return (view.content);
            };
            return (null);
        }

        [Untrusted]
        public static function getShortcutBarContent(barType:uint):Array
        {
            if (barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
            {
                return (InventoryManager.getInstance().shortcutBarItems);
            };
            if (barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
            {
                return (InventoryManager.getInstance().shortcutBarSpells);
            };
            return (new Array());
        }

        [Untrusted]
        public static function getFakeItemMount():MountWrapper
        {
            if (PlayedCharacterManager.getInstance().mount)
            {
                return (MountWrapper.create());
            };
            return (null);
        }

        [Untrusted]
        public static function getBestEquipablePosition(item:Object):int
        {
            var equipement:Object;
            var freeSlot:int;
            var pos:int;
            var typeId:int;
            var lastIndex:int;
            var possiblePosition:Object = itemSuperTypeToServerPosition(item.type.superTypeId);
            if (((possiblePosition) && (possiblePosition.length)))
            {
                equipement = getViewContent("equipment");
                freeSlot = -1;
                for each (pos in possiblePosition)
                {
                    typeId = item.typeId;
                    if (((((equipement[pos]) && ((equipement[pos].objectGID == item.objectGID)))) && (((!((item.typeId == 9))) || (item.belongsToSet)))))
                    {
                        freeSlot = pos;
                        break;
                    };
                };
                if (freeSlot == -1)
                {
                    for each (pos in possiblePosition)
                    {
                        if (!(equipement[pos]))
                        {
                            freeSlot = pos;
                            break;
                        };
                    };
                };
                if (freeSlot == -1)
                {
                    if (!(_lastItemPosition[item.type.superTypeId]))
                    {
                        _lastItemPosition[item.type.superTypeId] = 0;
                    };
                    var _local_8 = _lastItemPosition;
                    var _local_9 = item.type.superTypeId;
                    var _local_10 = (_local_8[_local_9] + 1);
                    _local_8[_local_9] = _local_10;
                    lastIndex = _local_10;
                    if (lastIndex >= possiblePosition.length)
                    {
                        lastIndex = 0;
                    };
                    _lastItemPosition[item.type.superTypeId] = lastIndex;
                    freeSlot = possiblePosition[lastIndex];
                };
            };
            return (freeSlot);
        }

        [Untrusted]
        public static function addItemMask(itemUID:int, name:String, quantity:int):void
        {
            InventoryManager.getInstance().inventory.addItemMask(itemUID, name, quantity);
        }

        [Untrusted]
        public static function removeItemMask(itemUID:int, name:String):void
        {
            InventoryManager.getInstance().inventory.removeItemMask(itemUID, name);
        }

        [Untrusted]
        public static function removeAllItemMasks(name:String):void
        {
            InventoryManager.getInstance().inventory.removeAllItemMasks(name);
        }

        [Untrusted]
        public static function releaseHooks():void
        {
            InventoryManager.getInstance().inventory.releaseHooks();
        }

        [Untrusted]
        public static function releaseBankHooks():void
        {
            InventoryManager.getInstance().bankInventory.releaseHooks();
        }

        [Untrusted]
        public static function dracoTurkyInventoryWeight():uint
        {
            var mf:MountFrame = (Kernel.getWorker().getFrame(MountFrame) as MountFrame);
            return (mf.inventoryWeight);
        }

        [Untrusted]
        public static function dracoTurkyMaxInventoryWeight():uint
        {
            var mf:MountFrame = (Kernel.getWorker().getFrame(MountFrame) as MountFrame);
            return (mf.inventoryMaxWeight);
        }

        [Untrusted]
        public static function getStorageTypes(category:int):Array
        {
            var entry:Object;
            var array:Array = new Array();
            var dict:Dictionary = StorageOptionManager.getInstance().getCategoryTypes(category);
            if (!(dict))
            {
                return (null);
            };
            for each (entry in dict)
            {
                array.push(entry);
            };
            array.sort(sortStorageTypes);
            return (array);
        }

        private static function sortStorageTypes(a:Object, b:Object):int
        {
            return (-(StringUtils.noAccent(b.name).localeCompare(StringUtils.noAccent(a.name))));
        }

        [Untrusted]
        public static function getBankStorageTypes(category:int):Array
        {
            var entry:Object;
            var array:Array = new Array();
            var dict:Dictionary = StorageOptionManager.getInstance().getBankCategoryTypes(category);
            if (!(dict))
            {
                return (null);
            };
            for each (entry in dict)
            {
                array.push(entry);
            };
            array.sortOn("name");
            return (array);
        }

        [Untrusted]
        public static function setDisplayedCategory(category:int):void
        {
            StorageOptionManager.getInstance().category = category;
        }

        [Untrusted]
        public static function setDisplayedBankCategory(category:int):void
        {
            StorageOptionManager.getInstance().bankCategory = category;
        }

        [Untrusted]
        public static function getDisplayedCategory():int
        {
            return (StorageOptionManager.getInstance().category);
        }

        [Untrusted]
        public static function getDisplayedBankCategory():int
        {
            return (StorageOptionManager.getInstance().bankCategory);
        }

        [Untrusted]
        public static function setStorageFilter(typeId:int):void
        {
            StorageOptionManager.getInstance().filter = typeId;
        }

        [Untrusted]
        public static function setBankStorageFilter(typeId:int):void
        {
            StorageOptionManager.getInstance().bankFilter = typeId;
        }

        [Untrusted]
        public static function getStorageFilter():int
        {
            return (StorageOptionManager.getInstance().filter);
        }

        [Untrusted]
        public static function getBankStorageFilter():int
        {
            return (StorageOptionManager.getInstance().bankFilter);
        }

        [Untrusted]
        public static function updateStorageView():void
        {
            StorageOptionManager.getInstance().updateStorageView();
        }

        [Untrusted]
        public static function updateBankStorageView():void
        {
            StorageOptionManager.getInstance().updateBankStorageView();
        }

        [Untrusted]
        public static function sort(sortField:int, revert:Boolean):void
        {
            StorageOptionManager.getInstance().sortRevert = revert;
            StorageOptionManager.getInstance().sortField = sortField;
        }

        [Untrusted]
        public static function resetSort():void
        {
            StorageOptionManager.getInstance().resetSort();
        }

        [Untrusted]
        public static function sortBank(sortField:int, revert:Boolean):void
        {
            StorageOptionManager.getInstance().sortBankRevert = revert;
            StorageOptionManager.getInstance().sortBankField = sortField;
        }

        [Untrusted]
        public static function resetBankSort():void
        {
            StorageOptionManager.getInstance().resetBankSort();
        }

        [Untrusted]
        public static function getSortFields():Array
        {
            return (StorageOptionManager.getInstance().sortFields);
        }

        [Untrusted]
        public static function getSortBankFields():Array
        {
            return (StorageOptionManager.getInstance().sortBankFields);
        }

        [Untrusted]
        public static function unsort():void
        {
            StorageOptionManager.getInstance().sortField = StorageOptionManager.SORT_FIELD_NONE;
        }

        [Untrusted]
        public static function unsortBank():void
        {
            StorageOptionManager.getInstance().sortBankField = StorageOptionManager.SORT_FIELD_NONE;
        }

        [Untrusted]
        public static function enableBidHouseFilter(allowedTypes:Object, maxItemLevel:uint):void
        {
            var entry:uint;
            var vtypes:Vector.<uint> = new Vector.<uint>();
            for each (entry in allowedTypes)
            {
                vtypes.push(entry);
            };
            StorageOptionManager.getInstance().enableBidHouseFilter(vtypes, maxItemLevel);
        }

        [Untrusted]
        public static function disableBidHouseFilter():void
        {
            StorageOptionManager.getInstance().disableBidHouseFilter();
        }

        [Untrusted]
        public static function getIsBidHouseFilterEnabled():Boolean
        {
            return (StorageOptionManager.getInstance().getIsBidHouseFilterEnabled());
        }

        [Untrusted]
        public static function enableSmithMagicFilter(skill:Object):void
        {
            StorageOptionManager.getInstance().enableSmithMagicFilter((skill as Skill));
        }

        [Untrusted]
        public static function disableSmithMagicFilter():void
        {
            StorageOptionManager.getInstance().disableSmithMagicFilter();
        }

        [Untrusted]
        public static function enableCraftFilter(skill:Object, slotCount:int):void
        {
            StorageOptionManager.getInstance().enableCraftFilter((skill as Skill), slotCount);
        }

        [Untrusted]
        public static function disableCraftFilter():void
        {
            StorageOptionManager.getInstance().disableCraftFilter();
        }

        [Untrusted]
        public static function getIsSmithMagicFilterEnabled():Boolean
        {
            return (StorageOptionManager.getInstance().getIsSmithMagicFilterEnabled());
        }

        [Untrusted]
        public static function getItemMaskCount(objectUID:int, mask:String):int
        {
            return (InventoryManager.getInstance().inventory.getItemMaskCount(objectUID, mask));
        }


    }
}//package com.ankamagames.dofus.uiApi

