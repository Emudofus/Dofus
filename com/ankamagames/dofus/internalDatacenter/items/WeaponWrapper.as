package com.ankamagames.dofus.internalDatacenter.items
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class WeaponWrapper extends ItemWrapper implements IDataCenter
    {
        public var apCost:int;
        public var minRange:int;
        public var range:int;
        public var castInLine:Boolean;
        public var castInDiagonal:Boolean;
        public var castTestLos:Boolean;
        public var criticalHitProbability:int;
        public var criticalHitBonus:int;
        public var criticalFailureProbability:int;
        private static var _weaponUtil:Weapon = new Weapon();

        public function WeaponWrapper()
        {
            return;
        }// end function

        override public function get isWeapon() : Boolean
        {
            return true;
        }// end function

        override public function clone(param1:Class = null) : ItemWrapper
        {
            var _loc_2:* = super.clone(WeaponWrapper);
            _weaponUtil.copy(this, _loc_2);
            return _loc_2;
        }// end function

    }
}
