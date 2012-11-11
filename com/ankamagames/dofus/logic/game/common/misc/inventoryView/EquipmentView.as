package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class EquipmentView extends Object implements IInventoryView
    {
        private var _content:Vector.<ItemWrapper>;
        private var _hookLock:HookLock;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EquipmentView));

        public function EquipmentView(param1:HookLock)
        {
            this._content = new Vector.<ItemWrapper>(16);
            this._hookLock = param1;
            return;
        }// end function

        public function initialize(param1:Vector.<ItemWrapper>) : void
        {
            var _loc_2:* = null;
            this._content = new Vector.<ItemWrapper>(16);
            for each (_loc_2 in param1)
            {
                
                if (this.isListening(_loc_2))
                {
                    this.addItem(_loc_2, 0);
                }
            }
            this._hookLock.addHook(InventoryHookList.EquipmentViewContent, [this.content]);
            return;
        }// end function

        public function get name() : String
        {
            return "equipment";
        }// end function

        public function get content() : Vector.<ItemWrapper>
        {
            return this._content;
        }// end function

        public function addItem(param1:ItemWrapper, param2:int) : void
        {
            this.content[param1.position] = param1;
            if (param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
            {
                PlayedCharacterManager.getInstance().currentWeapon = param1 as WeaponWrapper;
                this._hookLock.addHook(InventoryHookList.WeaponUpdate, []);
            }
            this._hookLock.addHook(InventoryHookList.EquipmentObjectMove, [param1, -1]);
            return;
        }// end function

        public function removeItem(param1:ItemWrapper, param2:int) : void
        {
            this.content[param1.position] = null;
            if (param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
            {
                PlayedCharacterManager.getInstance().currentWeapon = null;
                this._hookLock.addHook(InventoryHookList.WeaponUpdate, []);
            }
            this._hookLock.addHook(InventoryHookList.EquipmentObjectMove, [null, param1.position]);
            return;
        }// end function

        public function modifyItem(param1:ItemWrapper, param2:ItemWrapper, param3:int) : void
        {
            if (param1.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
            {
                this._hookLock.addHook(InventoryHookList.WeaponUpdate, []);
            }
            this._hookLock.addHook(InventoryHookList.EquipmentObjectMove, [param1, param2.position]);
            return;
        }// end function

        public function isListening(param1:ItemWrapper) : Boolean
        {
            return param1.position <= 15;
        }// end function

        public function updateView() : void
        {
            return;
        }// end function

        public function empty() : void
        {
            return;
        }// end function

    }
}
