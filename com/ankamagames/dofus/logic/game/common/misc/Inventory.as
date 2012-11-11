package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Inventory extends Object
    {
        private var _itemsDict:Dictionary;
        private var _views:Dictionary;
        private var _hookLock:HookLock;
        private var _kamas:int;
        private var _hiddedKamas:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Inventory));
        public static const HIDDEN_TYPE_ID:uint = 118;
        public static const PETSMOUNT_TYPE_ID:uint = 121;

        public function Inventory()
        {
            this._itemsDict = new Dictionary();
            this._hookLock = new HookLock();
            this._views = new Dictionary();
            return;
        }// end function

        public function get hookLock() : HookLock
        {
            return this._hookLock;
        }// end function

        public function get localKamas() : int
        {
            return this._kamas;
        }// end function

        public function get kamas() : int
        {
            return this._kamas;
        }// end function

        public function set kamas(param1:int) : void
        {
            this._kamas = param1;
            StorageOptionManager.getInstance().updateStorageView();
            return;
        }// end function

        public function set hiddedKamas(param1:int) : void
        {
            StorageOptionManager.getInstance().updateStorageView();
            return;
        }// end function

        public function addView(param1:IInventoryView) : void
        {
            this._views[param1.name] = param1;
            return;
        }// end function

        public function getView(param1:String) : IInventoryView
        {
            return this._views[param1];
        }// end function

        public function removeView(param1:String) : void
        {
            var _loc_2:* = this.getView(param1);
            if (_loc_2)
            {
                delete this._views[param1];
            }
            return;
        }// end function

        public function getItem(param1:int) : ItemWrapper
        {
            if (this._itemsDict[param1])
            {
                return (this._itemsDict[param1] as ItemSet).item;
            }
            return null;
        }// end function

        public function getItemMaskCount(param1:int, param2:String) : int
        {
            var _loc_3:* = this._itemsDict[param1];
            if (!_loc_3)
            {
                _log.error("Suppression d\'un item qui n\'existe pas");
                return 0;
            }
            if (_loc_3.masks.hasOwnProperty(param2))
            {
                return _loc_3.masks[param2];
            }
            return 0;
        }// end function

        public function initialize(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._itemsDict = new Dictionary();
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new ItemSet();
                _loc_3.item = _loc_2;
                _loc_3.masks = new Dictionary();
                this._itemsDict[_loc_2.objectUID] = _loc_3;
            }
            this.initializeViews(param1);
            return;
        }// end function

        public function initializeFromObjectItems(param1:Vector.<ObjectItem>) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Vector.<ItemWrapper>;
            this._itemsDict = new Dictionary();
            for each (_loc_3 in param1)
            {
                
                _loc_4 = ItemWrapper.create(_loc_3.position, _loc_3.objectUID, _loc_3.objectGID, _loc_3.quantity, _loc_3.effects);
                _loc_5 = new ItemSet();
                _loc_5.item = _loc_4;
                _loc_5.masks = new Dictionary();
                this._itemsDict[_loc_3.objectUID] = _loc_5;
                _loc_2.push(_loc_4);
            }
            this.initializeViews(_loc_2);
            return;
        }// end function

        public function addObjectItem(param1:ObjectItem) : void
        {
            var _loc_2:* = ItemWrapper.create(param1.position, param1.objectUID, param1.objectGID, param1.quantity, param1.effects, false);
            this.addItem(_loc_2);
            return;
        }// end function

        public function addItem(param1:ItemWrapper) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._itemsDict[param1.objectUID];
            if (_loc_2)
            {
                _loc_3 = param1.clone();
                _loc_2.item.quantity = _loc_2.item.quantity + param1.quantity;
                _loc_2.masks = new Dictionary();
                this.modifyItemFromViews(_loc_2, _loc_3);
            }
            else
            {
                _loc_2 = new ItemSet();
                _loc_2.item = param1;
                _loc_2.masks = new Dictionary();
                this._itemsDict[param1.objectUID] = _loc_2;
                this.addItemToViews(_loc_2);
            }
            return;
        }// end function

        public function removeItem(param1:int, param2:int = -1) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = this._itemsDict[param1];
            if (!_loc_3)
            {
                _log.error("Suppression d\'un item qui n\'existe pas");
                return;
            }
            if (param2 == -1 || param2 == _loc_3.item.quantity)
            {
                delete this._itemsDict[param1];
                this.removeItemFromViews(_loc_3);
            }
            else
            {
                if (_loc_3.item.quantity < param2)
                {
                    _log.error("On essaye de supprimer de l\'inventaire plus d\'objet qu\'il n\'en existe");
                    return;
                }
                _loc_4 = _loc_3.item.clone();
                _loc_3.item.quantity = _loc_3.item.quantity - param2;
                this.modifyItemFromViews(_loc_3, _loc_4);
            }
            return;
        }// end function

        public function modifyItemQuantity(param1:int, param2:int) : void
        {
            var _loc_3:* = this._itemsDict[param1];
            if (!_loc_3)
            {
                _log.error("On essaye de modifier la quantité d\'un objet qui n\'existe pas");
                return;
            }
            var _loc_4:* = _loc_3.item.clone();
            _loc_3.item.clone().quantity = param2;
            this.modifyItem(_loc_4);
            return;
        }// end function

        public function modifyItemPosition(param1:int, param2:int) : void
        {
            var _loc_3:* = this._itemsDict[param1];
            if (!_loc_3)
            {
                _log.error("On essaye de modifier la position d\'un objet qui n\'existe pas");
                return;
            }
            var _loc_4:* = _loc_3.item.clone();
            _loc_3.item.clone().position = param2;
            if (_loc_4.typeId == PETSMOUNT_TYPE_ID)
            {
                if (param2 == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS)
                {
                    PlayedCharacterManager.getInstance().isPetsMounting = true;
                }
                else
                {
                    PlayedCharacterManager.getInstance().isPetsMounting = false;
                }
            }
            this.modifyItem(_loc_4);
            return;
        }// end function

        public function modifyObjectItem(param1:ObjectItem) : void
        {
            var _loc_2:* = ItemWrapper.create(param1.position, param1.objectUID, param1.objectGID, param1.quantity, param1.effects, false);
            this.modifyItem(_loc_2);
            return;
        }// end function

        public function modifyItem(param1:ItemWrapper) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._itemsDict[param1.objectUID];
            if (_loc_2)
            {
                _loc_3 = _loc_2.item.clone();
                this.copyItem(_loc_2.item, param1);
                this.modifyItemFromViews(_loc_2, _loc_3);
            }
            else
            {
                this.addItem(param1);
            }
            return;
        }// end function

        public function addItemMask(param1:int, param2:String, param3:int) : void
        {
            var _loc_4:* = this._itemsDict[param1];
            if (!this._itemsDict[param1])
            {
                _log.error("On essaye de masquer un item qui n\'existe pas dans l\'inventaire");
                return;
            }
            _loc_4.masks[param2] = param3;
            this.modifyItemFromViews(_loc_4, _loc_4.item);
            return;
        }// end function

        public function removeItemMask(param1:int, param2:String) : void
        {
            var _loc_3:* = this._itemsDict[param1];
            if (!_loc_3)
            {
                _log.error("On essaye de retirer le masque d\'un item qui n\'existe pas dans l\'inventaire");
                return;
            }
            delete _loc_3.masks[param2];
            this.modifyItemFromViews(_loc_3, _loc_3.item);
            return;
        }// end function

        public function removeAllItemMasks(param1:String) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._itemsDict)
            {
                
                if (_loc_2.masks[param1])
                {
                    delete _loc_2.masks[param1];
                    this.modifyItemFromViews(_loc_2, _loc_2.item);
                }
            }
            return;
        }// end function

        public function removeAllItemsMasks() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._itemsDict)
            {
                
                if (_loc_1.masks.length > 0)
                {
                    _loc_1.masks = new Dictionary();
                    this.modifyItemFromViews(_loc_1, _loc_1.item);
                }
            }
            return;
        }// end function

        public function releaseHooks() : void
        {
            this._hookLock.release();
            return;
        }// end function

        public function refillView(param1:String, param2:String) : void
        {
            var _loc_3:* = this.getView(param1);
            var _loc_4:* = this.getView(param2);
            if (!_loc_3 || !_loc_4)
            {
                return;
            }
            _loc_4.initialize(_loc_3.content);
            _loc_4.updateView();
            return;
        }// end function

        protected function addItemToViews(param1:ItemSet) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._views)
            {
                
                if (_loc_2.isListening(param1.item))
                {
                    _loc_2.addItem(param1.item, 0);
                }
            }
            return;
        }// end function

        protected function modifyItemFromViews(param1:ItemSet, param2:ItemWrapper) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            for each (_loc_4 in param1.masks)
            {
                
                _loc_3 = _loc_3 + _loc_4;
            }
            for each (_loc_5 in this._views)
            {
                
                if (_loc_5.isListening(param1.item))
                {
                    if (_loc_5.isListening(param2))
                    {
                        _loc_5.modifyItem(param1.item, param2, _loc_3);
                    }
                    else
                    {
                        _loc_5.addItem(param1.item, _loc_3);
                    }
                    continue;
                }
                if (_loc_5.isListening(param2))
                {
                    _loc_5.removeItem(param2, _loc_3);
                }
            }
            return;
        }// end function

        protected function removeItemFromViews(param1:ItemSet) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._views)
            {
                
                if (_loc_2.isListening(param1.item))
                {
                    _loc_2.removeItem(param1.item, 0);
                }
            }
            return;
        }// end function

        protected function initializeViews(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._views)
            {
                
                _loc_2.initialize(param1);
            }
            return;
        }// end function

        protected function copyItem(param1:ItemWrapper, param2:ItemWrapper) : void
        {
            param1.update(param2.position, param2.objectUID, param2.objectGID, param2.quantity, param2.effectsList);
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.dofus.internalDatacenter.items.*;

import com.ankamagames.dofus.logic.game.common.managers.*;

import com.ankamagames.dofus.network.enums.*;

import com.ankamagames.dofus.network.types.game.data.items.*;

import com.ankamagames.jerakine.logger.*;

import flash.utils.*;

class ItemSet extends Object
{
    public var item:ItemWrapper;
    public var masks:Dictionary;

    function ItemSet()
    {
        return;
    }// end function

}

