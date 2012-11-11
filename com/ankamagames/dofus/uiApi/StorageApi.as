package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.dofus.datacenter.mounts.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class StorageApi extends Object implements IApi
    {
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageApi));
        private static var _lastItemPosition:Array = new Array();
        public static const ITEM_TYPE_TO_SERVER_POSITION:Array = [[], [0], [1], [2, 4], [3], [5], [], [15], [1], [], [6], [7], [8], [9, 10, 11, 12, 13, 14]];

        public function StorageApi()
        {
            return;
        }// end function

        public static function itemSuperTypeToServerPosition(param1:uint) : Array
        {
            return ITEM_TYPE_TO_SERVER_POSITION[param1];
        }// end function

        public static function getLivingObjectFood(param1:int) : Vector.<ItemWrapper>
        {
            var _loc_6:* = null;
            var _loc_2:* = new Vector.<ItemWrapper>;
            var _loc_3:* = InventoryManager.getInstance().inventory.getView("storage").content;
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_5];
                if (!_loc_6.isLivingObject && _loc_6.type.id == param1)
                {
                    _loc_2.push(_loc_6);
                }
                _loc_5++;
            }
            return _loc_2;
        }// end function

        public static function getPetFood(param1:int) : Vector.<ItemWrapper>
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_2:* = new Vector.<ItemWrapper>;
            var _loc_3:* = Pet.getPetById(param1);
            if (_loc_3)
            {
                _loc_4 = InventoryManager.getInstance().inventory.getView("storage").content;
                _loc_5 = Pet.getPetById(param1).foodItems;
                _loc_6 = Pet.getPetById(param1).foodTypes;
                _loc_7 = _loc_4.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = _loc_4[_loc_8];
                    if (_loc_5.indexOf(_loc_9.objectGID) > -1 || _loc_6.indexOf(_loc_9.typeId) > -1)
                    {
                        _loc_2.push(_loc_9);
                    }
                    _loc_8++;
                }
            }
            return _loc_2;
        }// end function

        public static function getRideFoods() : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = new Array();
            var _loc_2:* = InventoryManager.getInstance().inventory.getView("storage").content;
            var _loc_3:* = RideFood.getRideFoods();
            var _loc_4:* = new Array();
            var _loc_5:* = new Array();
            for each (_loc_6 in _loc_3)
            {
                
                if (_loc_6.gid != 0)
                {
                    _loc_4.push(_loc_6.gid);
                }
                if (_loc_6.typeId != 0)
                {
                    _loc_5.push(_loc_6.typeId);
                }
            }
            for each (_loc_7 in _loc_2)
            {
                
                _loc_8 = Item.getItemById(_loc_7.objectGID);
                if (_loc_4.indexOf(_loc_7.objectGID) != -1 || _loc_5.indexOf(_loc_8.typeId) != -1)
                {
                    _loc_1.push(_loc_7);
                }
            }
            return _loc_1;
        }// end function

        public static function getViewContent(param1:String) : Vector.<ItemWrapper>
        {
            var _loc_2:* = InventoryManager.getInstance().inventory.getView(param1);
            if (_loc_2)
            {
                return _loc_2.content;
            }
            return null;
        }// end function

        public static function getShortcutBarContent(param1:uint) : Array
        {
            if (param1 == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
            {
                return InventoryManager.getInstance().shortcutBarItems;
            }
            if (param1 == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
            {
                return InventoryManager.getInstance().shortcutBarSpells;
            }
            return new Array();
        }// end function

        public static function getFakeItemMount() : MountWrapper
        {
            if (PlayedCharacterManager.getInstance().mount)
            {
                return MountWrapper.create();
            }
            return null;
        }// end function

        public static function getBestEquipablePosition(param1:Object) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = itemSuperTypeToServerPosition(param1.type.superTypeId);
            if (_loc_2 && _loc_2.length)
            {
                _loc_3 = getViewContent("equipment");
                _loc_4 = -1;
                for each (_loc_5 in _loc_2)
                {
                    
                    _loc_6 = param1.typeId;
                    if (_loc_3[_loc_5] && _loc_3[_loc_5].objectGID == param1.objectGID && (param1.typeId != 9 || param1.belongsToSet))
                    {
                        _loc_4 = _loc_5;
                        break;
                    }
                }
                if (_loc_4 == -1)
                {
                    for each (_loc_5 in _loc_2)
                    {
                        
                        if (!_loc_3[_loc_5])
                        {
                            _loc_4 = _loc_5;
                            break;
                        }
                    }
                }
                if (_loc_4 == -1)
                {
                    if (!_lastItemPosition[param1.type.superTypeId])
                    {
                        _lastItemPosition[param1.type.superTypeId] = 0;
                    }
                    var _loc_8:* = _lastItemPosition;
                    var _loc_9:* = param1.type.superTypeId;
                    _loc_8[_loc_9] = _lastItemPosition[param1.type.superTypeId] + 1;
                    if (++_lastItemPosition[param1.type.superTypeId] >= _loc_2.length)
                    {
                        ++_lastItemPosition[param1.type.superTypeId] = 0;
                    }
                    ++_lastItemPosition[param1.type.superTypeId];
                    _loc_4 = _loc_2[_loc_7];
                }
            }
            return _loc_4;
        }// end function

        public static function addItemMask(param1:int, param2:String, param3:int) : void
        {
            InventoryManager.getInstance().inventory.addItemMask(param1, param2, param3);
            return;
        }// end function

        public static function removeItemMask(param1:int, param2:String) : void
        {
            InventoryManager.getInstance().inventory.removeItemMask(param1, param2);
            return;
        }// end function

        public static function removeAllItemMasks(param1:String) : void
        {
            InventoryManager.getInstance().inventory.removeAllItemMasks(param1);
            return;
        }// end function

        public static function releaseHooks() : void
        {
            InventoryManager.getInstance().inventory.releaseHooks();
            return;
        }// end function

        public static function releaseBankHooks() : void
        {
            InventoryManager.getInstance().bankInventory.releaseHooks();
            return;
        }// end function

        public static function getStorageTypes(param1:int) : Array
        {
            var _loc_4:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = StorageOptionManager.getInstance().getCategoryTypes(param1);
            if (!_loc_3)
            {
                return null;
            }
            for each (_loc_4 in _loc_3)
            {
                
                _loc_2.push(_loc_4);
            }
            _loc_2.sort(sortStorageTypes);
            return _loc_2;
        }// end function

        private static function sortStorageTypes(param1:Object, param2:Object) : int
        {
            return -StringUtils.noAccent(param2.name).localeCompare(StringUtils.noAccent(param1.name));
        }// end function

        public static function getBankStorageTypes(param1:int) : Array
        {
            var _loc_4:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = StorageOptionManager.getInstance().getBankCategoryTypes(param1);
            if (!_loc_3)
            {
                return null;
            }
            for each (_loc_4 in _loc_3)
            {
                
                _loc_2.push(_loc_4);
            }
            _loc_2.sortOn("name");
            return _loc_2;
        }// end function

        public static function setDisplayedCategory(param1:int) : void
        {
            StorageOptionManager.getInstance().category = param1;
            return;
        }// end function

        public static function setDisplayedBankCategory(param1:int) : void
        {
            StorageOptionManager.getInstance().bankCategory = param1;
            return;
        }// end function

        public static function getDisplayedCategory() : int
        {
            return StorageOptionManager.getInstance().category;
        }// end function

        public static function getDisplayedBankCategory() : int
        {
            return StorageOptionManager.getInstance().bankCategory;
        }// end function

        public static function setStorageFilter(param1:int) : void
        {
            StorageOptionManager.getInstance().filter = param1;
            return;
        }// end function

        public static function setBankStorageFilter(param1:int) : void
        {
            StorageOptionManager.getInstance().bankFilter = param1;
            return;
        }// end function

        public static function getStorageFilter() : int
        {
            return StorageOptionManager.getInstance().filter;
        }// end function

        public static function getBankStorageFilter() : int
        {
            return StorageOptionManager.getInstance().bankFilter;
        }// end function

        public static function updateStorageView() : void
        {
            StorageOptionManager.getInstance().updateStorageView();
            return;
        }// end function

        public static function updateBankStorageView() : void
        {
            StorageOptionManager.getInstance().updateBankStorageView();
            return;
        }// end function

        public static function sort(param1:int, param2:Boolean) : void
        {
            StorageOptionManager.getInstance().sortRevert = param2;
            StorageOptionManager.getInstance().sortField = param1;
            return;
        }// end function

        public static function sortBank(param1:int, param2:Boolean) : void
        {
            StorageOptionManager.getInstance().sortBankRevert = param2;
            StorageOptionManager.getInstance().sortBankField = param1;
            return;
        }// end function

        public static function getSortField() : int
        {
            return StorageOptionManager.getInstance().sortField;
        }// end function

        public static function getSortBankField() : int
        {
            return StorageOptionManager.getInstance().sortBankField;
        }// end function

        public static function unsort() : void
        {
            StorageOptionManager.getInstance().sortField = StorageOptionManager.SORT_FIELD_NONE;
            return;
        }// end function

        public static function unsortBank() : void
        {
            StorageOptionManager.getInstance().sortBankField = StorageOptionManager.SORT_FIELD_NONE;
            return;
        }// end function

        public static function enableBidHouseFilter(param1:Object, param2:uint) : void
        {
            var _loc_4:* = 0;
            var _loc_3:* = new Vector.<uint>;
            for each (_loc_4 in param1)
            {
                
                _loc_3.push(_loc_4);
            }
            StorageOptionManager.getInstance().enableBidHouseFilter(_loc_3, param2);
            return;
        }// end function

        public static function disableBidHouseFilter() : void
        {
            StorageOptionManager.getInstance().disableBidHouseFilter();
            return;
        }// end function

        public static function getIsBidHouseFilterEnabled() : Boolean
        {
            return StorageOptionManager.getInstance().getIsBidHouseFilterEnabled();
        }// end function

        public static function enableSmithMagicFilter(param1:Object) : void
        {
            StorageOptionManager.getInstance().enableSmithMagicFilter(param1 as Skill);
            return;
        }// end function

        public static function disableSmithMagicFilter() : void
        {
            StorageOptionManager.getInstance().disableSmithMagicFilter();
            return;
        }// end function

        public static function enableCraftFilter(param1:Object, param2:int) : void
        {
            StorageOptionManager.getInstance().enableCraftFilter(param1 as Skill, param2);
            return;
        }// end function

        public static function disableCraftFilter() : void
        {
            StorageOptionManager.getInstance().disableCraftFilter();
            return;
        }// end function

        public static function getIsSmithMagicFilterEnabled() : Boolean
        {
            return StorageOptionManager.getInstance().getIsSmithMagicFilterEnabled();
        }// end function

        public static function getItemMaskCount(param1:int, param2:String) : int
        {
            return InventoryManager.getInstance().inventory.getItemMaskCount(param1, param2);
        }// end function

    }
}
