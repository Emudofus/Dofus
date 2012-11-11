package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class StorageGenericView extends Object implements IStorageView
    {
        protected var _content:Vector.<ItemWrapper>;
        protected var _sortedContent:Vector.<ItemWrapper>;
        protected var _hookLock:HookLock;
        protected var _sorted:Boolean = false;
        private var _sortFieldCache:int;
        private var _sortRevertCache:Boolean;
        protected var _typesQty:Dictionary;
        protected var _types:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageView));

        public function StorageGenericView(param1:HookLock)
        {
            this._typesQty = new Dictionary();
            this._types = new Dictionary();
            this._hookLock = param1;
            return;
        }// end function

        public function initialize(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:* = null;
            if (!this._content)
            {
                this._content = new Vector.<ItemWrapper>;
            }
            else
            {
                this._content.length = 0;
            }
            this._typesQty = new Dictionary();
            this._types = new Dictionary();
            this._sortedContent = null;
            for each (_loc_2 in param1)
            {
                
                if (this.isListening(_loc_2))
                {
                    this.addItem(_loc_2, 0);
                }
            }
            this.updateView();
            return;
        }// end function

        public function get name() : String
        {
            throw new Error("StorageGenericView class must be extended");
        }// end function

        public function get content() : Vector.<ItemWrapper>
        {
            if (this._sorted)
            {
                return this._sortedContent;
            }
            return this._content;
        }// end function

        public function get types() : Dictionary
        {
            return this._types;
        }// end function

        public function addItem(param1:ItemWrapper, param2:int) : void
        {
            var _loc_3:* = param1.clone();
            _loc_3.quantity = _loc_3.quantity - param2;
            this._content.unshift(_loc_3);
            if (this._sortedContent)
            {
                this._sortedContent.unshift(_loc_3);
            }
            if (this._typesQty[param1.typeId] && this._typesQty[param1.typeId] > 0)
            {
                var _loc_4:* = this._typesQty;
                var _loc_5:* = param1.typeId;
                var _loc_6:* = this._typesQty[param1.typeId] + 1;
                _loc_4[_loc_5] = _loc_6;
            }
            else
            {
                this._typesQty[param1.typeId] = 1;
                this._types[param1.typeId] = param1.type;
            }
            this.updateView();
            return;
        }// end function

        public function removeItem(param1:ItemWrapper, param2:int) : void
        {
            var _loc_3:* = this.getItemIndex(param1);
            if (_loc_3 == -1)
            {
                return;
            }
            if (this._typesQty[param1.typeId] && this._typesQty[param1.typeId] > 0)
            {
                var _loc_4:* = this._typesQty;
                var _loc_5:* = param1.typeId;
                var _loc_6:* = this._typesQty[param1.typeId] - 1;
                _loc_4[_loc_5] = _loc_6;
                if (this._typesQty[param1.typeId] == 0)
                {
                    delete this._types[param1.typeId];
                }
            }
            this._content.splice(_loc_3, 1);
            if (this._sortedContent)
            {
                _loc_3 = this.getItemIndex(param1, this._sortedContent);
                if (_loc_3 != -1)
                {
                    this._sortedContent.splice(_loc_3, 1);
                }
            }
            this.updateView();
            return;
        }// end function

        public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = this.getItemIndex(param1);
            if (this.getItemIndex(param1) != -1)
            {
                _loc_5 = this._content[_loc_4];
                if (_loc_5.quantity == param1.quantity - param3)
                {
                    _loc_5.update(param1.position, param1.objectUID, param1.objectGID, _loc_5.quantity, param1.effectsList);
                    this.updateView();
                }
                else if (param1.quantity <= param3)
                {
                    this.removeItem(_loc_5, param3);
                }
                else
                {
                    _loc_5.update(param1.position, param1.objectUID, param1.objectGID, param1.quantity - param3, param1.effectsList);
                    this.updateView();
                }
            }
            else if (param3 < param1.quantity)
            {
                this.addItem(param1, param3);
            }
            return;
        }// end function

        public function isListening(param1:ItemWrapper) : Boolean
        {
            return param1.position == 63 && Item.getItemById(param1.objectGID).typeId != Inventory.HIDDEN_TYPE_ID;
        }// end function

        public function getItemTypes() : Dictionary
        {
            return this._types;
        }// end function

        protected function getItemIndex(param1:ItemWrapper, param2:Vector.<ItemWrapper> = null) : int
        {
            var _loc_4:* = null;
            if (param2 == null)
            {
                param2 = this._content;
            }
            var _loc_3:* = 0;
            while (_loc_3 < param2.length)
            {
                
                _loc_4 = param2[_loc_3];
                if (_loc_4.objectUID == param1.objectUID)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        private function compareFunction(param1:ItemWrapper, param2:ItemWrapper) : int
        {
            switch(this._sortFieldCache)
            {
                case StorageOptionManager.SORT_FIELD_NAME:
                {
                    if (!this._sortRevertCache)
                    {
                        return param1.name > param2.name ? (1) : (param1.name < param2.name ? (-1) : (0));
                    }
                    else
                    {
                        return param1.name < param2.name ? (1) : (param1.name > param2.name ? (-1) : (0));
                    }
                }
                case StorageOptionManager.SORT_FIELD_WEIGHT:
                {
                    if (!this._sortRevertCache)
                    {
                        return param1.weight > param2.weight ? (1) : (param1.weight < param2.weight ? (-1) : (0));
                    }
                    else
                    {
                        return param1.weight < param2.weight ? (1) : (param1.weight > param2.weight ? (-1) : (0));
                    }
                }
                case StorageOptionManager.SORT_FIELD_QUANTITY:
                {
                    if (!this._sortRevertCache)
                    {
                        return param1.quantity > param2.quantity ? (1) : (param1.quantity < param2.quantity ? (-1) : (0));
                    }
                    else
                    {
                        return param1.quantity < param2.quantity ? (1) : (param1.quantity > param2.quantity ? (-1) : (0));
                    }
                }
                case StorageOptionManager.SORT_FIELD_DEFAULT:
                {
                    if (!this._sortRevertCache)
                    {
                        return param1.objectUID < param2.objectUID ? (1) : (param1.objectUID > param2.objectUID ? (-1) : (0));
                    }
                    else
                    {
                        return param1.objectUID > param2.objectUID ? (1) : (param1.objectUID < param2.objectUID ? (-1) : (0));
                    }
                }
                default:
                {
                    return 0;
                    break;
                }
            }
        }// end function

        public function updateView() : void
        {
            var _loc_1:* = null;
            this._sortFieldCache = this.sortField();
            if (this._sortFieldCache != StorageOptionManager.SORT_FIELD_NONE)
            {
                this._sortRevertCache = this.sortRevert();
                if (!this._sortedContent)
                {
                    this._sortedContent = new Vector.<ItemWrapper>;
                    for each (_loc_1 in this._content)
                    {
                        
                        this._sortedContent.push(_loc_1);
                    }
                }
                this._sortedContent.sort(this.compareFunction);
                this._sorted = true;
            }
            else
            {
                this._sorted = false;
            }
            return;
        }// end function

        public function sortField() : int
        {
            return StorageOptionManager.getInstance().sortField;
        }// end function

        public function sortRevert() : Boolean
        {
            return StorageOptionManager.getInstance().sortRevert;
        }// end function

        public function empty() : void
        {
            this._content = new Vector.<ItemWrapper>;
            this._sortedContent = null;
            this.updateView();
            return;
        }// end function

    }
}
