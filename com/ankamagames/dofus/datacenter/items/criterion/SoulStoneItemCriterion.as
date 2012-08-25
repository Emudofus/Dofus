package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SoulStoneItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _quantityMonster:uint = 1;
        private var _monsterId:uint;
        private var _monsterName:String;
        private static const ID_SOUL_STONE:Array = [7010, 10417, 10418];

        public function SoulStoneItemCriterion(param1:String)
        {
            super(param1);
            var _loc_2:* = String(_criterionValueText).split(",");
            if (_loc_2 && _loc_2.length > 0)
            {
                if (_loc_2.length > 2)
                {
                }
                else
                {
                    this._monsterId = uint(_loc_2[0]);
                    this._quantityMonster = int(_loc_2[1]);
                }
            }
            else
            {
                this._monsterId = uint(_criterionValue);
            }
            this._monsterName = Monster.getMonsterById(this._monsterId).name;
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:ItemWrapper = null;
            var _loc_2:uint = 0;
            for each (_loc_1 in InventoryManager.getInstance().realInventory)
            {
                
                for each (_loc_2 in ID_SOUL_STONE)
                {
                    
                    if (_loc_1.objectGID == _loc_2)
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.tooltip.possessSoulStone", [this._quantityMonster, this._monsterName]);
            return _loc_1;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new SoulStoneItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
