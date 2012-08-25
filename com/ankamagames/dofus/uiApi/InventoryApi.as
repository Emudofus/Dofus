package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofusModuleLibrary.enum.inventory.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class InventoryApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function InventoryApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(InventoryApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getStorageObjectGID(param1:uint, param2:uint = 1) : Object
        {
            var _loc_6:ItemWrapper = null;
            var _loc_3:* = new Array();
            var _loc_4:uint = 0;
            var _loc_5:* = InventoryManager.getInstance().realInventory;
            for each (_loc_6 in _loc_5)
            {
                
                if (_loc_6.objectGID != param1 || _loc_6.position < 63 || _loc_6.linked)
                {
                    continue;
                }
                if (_loc_6.quantity >= param2 - _loc_4)
                {
                    _loc_3.push({objectUID:_loc_6.objectUID, quantity:param2 - _loc_4});
                    _loc_4 = param2;
                    return _loc_3;
                }
                _loc_3.push({objectUID:_loc_6.objectUID, quantity:_loc_6.quantity});
                _loc_4 = _loc_4 + _loc_6.quantity;
            }
            return null;
        }// end function

        public function getItemQty(param1:uint) : uint
        {
            var _loc_4:ItemWrapper = null;
            var _loc_2:uint = 0;
            var _loc_3:* = InventoryManager.getInstance().realInventory;
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.objectGID != param1 || _loc_4.position < 63)
                {
                    continue;
                }
                _loc_2 = _loc_2 + _loc_4.quantity;
            }
            return _loc_2;
        }// end function

        public function getItem(param1:uint) : ItemWrapper
        {
            return InventoryManager.getInstance().inventory.getItem(param1);
        }// end function

        public function getEquipementItemByPosition(param1:uint) : Object
        {
            if (param1 > 15)
            {
                return null;
            }
            var _loc_2:* = InventoryManager.getInstance().inventory.getView("equipment").content;
            return _loc_2[param1];
        }// end function

        public function getEquipement() : Vector.<ItemWrapper>
        {
            var _loc_1:* = InventoryManager.getInstance().inventory.getView("equipment").content;
            return _loc_1;
        }// end function

        public function getEquipementForPreset() : Array
        {
            var _loc_3:Uri = null;
            var _loc_5:Boolean = false;
            var _loc_6:ItemWrapper = null;
            var _loc_7:MountWrapper = null;
            var _loc_1:* = InventoryManager.getInstance().inventory.getView("equipment").content;
            var _loc_2:* = new Array(16);
            var _loc_4:int = 0;
            while (_loc_4 < 16)
            {
                
                _loc_5 = false;
                for each (_loc_6 in _loc_1)
                {
                    
                    if (_loc_6)
                    {
                        if (_loc_6.position == _loc_4)
                        {
                            _loc_2[_loc_4] = _loc_6;
                            _loc_5 = true;
                        }
                        continue;
                    }
                    if (_loc_4 == 8 && PlayedCharacterManager.getInstance().isRidding)
                    {
                        _loc_7 = MountWrapper.create();
                        _loc_2[_loc_4] = _loc_7;
                        _loc_5 = true;
                    }
                }
                if (!_loc_5)
                {
                    switch(_loc_4)
                    {
                        case 9:
                        case 10:
                        case 11:
                        case 12:
                        case 13:
                        case 14:
                        {
                            _loc_3 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                            break;
                        }
                        default:
                        {
                            _loc_3 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc_4);
                            break;
                            break;
                        }
                    }
                    _loc_2[_loc_4] = SimpleTextureWrapper.create(_loc_3);
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getVoidItemForPreset(param1:int) : SimpleTextureWrapper
        {
            var _loc_2:Uri = null;
            switch(param1)
            {
                case 9:
                case 10:
                case 11:
                case 12:
                case 13:
                case 14:
                {
                    _loc_2 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                    break;
                }
                default:
                {
                    _loc_2 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + param1);
                    break;
                    break;
                }
            }
            return SimpleTextureWrapper.create(_loc_2);
        }// end function

        public function getCurrentWeapon() : ItemWrapper
        {
            return this.getEquipementItemByPosition(EquipementItemPosition.WEAPON_POSITION) as ItemWrapper;
        }// end function

        public function getPresets() : Array
        {
            var _loc_4:PresetWrapper = null;
            var _loc_1:* = new Array();
            var _loc_2:* = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
            var _loc_3:int = 0;
            while (_loc_3 < 8)
            {
                
                _loc_4 = InventoryManager.getInstance().presets[_loc_3];
                if (_loc_4)
                {
                    _loc_1.push(_loc_4);
                }
                else
                {
                    _loc_1.push(SimpleTextureWrapper.create(_loc_2));
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function removeSelectedItem() : Boolean
        {
            var _loc_2:RoleplayPointCellFrame = null;
            var _loc_1:* = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
            if (_loc_1 && _loc_1.roleplayPointCellFrame != null && _loc_1.roleplayPointCellFrame.object != null)
            {
                _loc_2 = Kernel.getWorker().getFrame(RoleplayPointCellFrame) as RoleplayPointCellFrame;
                if (_loc_2)
                {
                    _loc_2.cancelShow();
                }
                Kernel.getWorker().removeFrame(_loc_1.roleplayPointCellFrame.object as RoleplayPointCellFrame);
                _loc_1.roleplayPointCellFrame = null;
                return true;
            }
            return false;
        }// end function

    }
}
