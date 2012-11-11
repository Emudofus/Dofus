package com.ankamagames.dofus.datacenter.items
{
    import com.ankamagames.jerakine.interfaces.*;

    public class Weapon extends Item implements IDataCenter
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

        public function Weapon()
        {
            return;
        }// end function

        override public function get isWeapon() : Boolean
        {
            return true;
        }// end function

        override public function copy(param1:Item, param2:Item) : void
        {
            super.copy(param1, param2);
            Object(param2).apCost = Object(param1).apCost;
            Object(param2).minRange = Object(param1).minRange;
            Object(param2).range = Object(param1).range;
            Object(param2).castInLine = Object(param1).castInLine;
            Object(param2).castInDiagonal = Object(param1).castInDiagonal;
            Object(param2).castTestLos = Object(param1).castTestLos;
            Object(param2).criticalHitProbability = Object(param1).criticalHitProbability;
            Object(param2).criticalHitBonus = Object(param1).criticalHitBonus;
            Object(param2).criticalFailureProbability = Object(param1).criticalFailureProbability;
            return;
        }// end function

        public static function getWeaponById(param1:int) : Weapon
        {
            var _loc_2:* = Item.getItemById(param1);
            if (_loc_2 && _loc_2.isWeapon)
            {
                return Weapon.Weapon(_loc_2);
            }
            return null;
        }// end function

        public static function getWeapons() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = Item.getItems();
            var _loc_2:* = new Array();
            for each (_loc_3 in _loc_1)
            {
                
                if (_loc_3.isWeapon)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

    }
}
