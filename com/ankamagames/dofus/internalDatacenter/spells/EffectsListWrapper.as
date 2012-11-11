package com.ankamagames.dofus.internalDatacenter.spells
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectsListWrapper extends Object implements IDataCenter
    {
        private var _categories:Array;
        public var effects:Vector.<EffectInstance>;
        public static const CATEGORY_ACTIVE_BONUS:int = 0;
        public static const CATEGORY_ACTIVE_MALUS:int = 1;
        public static const CATEGORY_PASSIVE_BONUS:int = 2;
        public static const CATEGORY_PASSIVE_MALUS:int = 3;
        public static const CATEGORY_TRIGGERED:int = 4;
        public static const CATEGORY_STATE:int = 5;
        public static const CATEGORY_OTHER:int = 6;

        public function EffectsListWrapper(param1:Array)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this._categories = new Array();
            for each (_loc_2 in param1)
            {
                
                _loc_3 = _loc_2.effects;
                _loc_4 = Effect.getEffectById(_loc_3.effectId);
                _loc_5 = this.getCategory(_loc_4);
                this.addBuff(_loc_5, _loc_2);
            }
            return;
        }// end function

        public function get categories() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = new Array();
            for (_loc_2 in this._categories)
            {
                
                if (this._categories[_loc_2].length > 0 && _loc_1[_loc_2] == null)
                {
                    _loc_1.push(_loc_2);
                }
            }
            _loc_1.sort();
            return _loc_1;
        }// end function

        public function getBuffs(param1:int) : Array
        {
            return this._categories[param1];
        }// end function

        public function get buffArray() : Array
        {
            return this._categories;
        }// end function

        private function addBuff(param1:int, param2:BasicBuff) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._categories[param1])
            {
                this._categories[param1] = new Array();
            }
            for each (_loc_3 in this._categories[param1])
            {
                
                _loc_4 = Effect.getEffectById(param2.actionId);
                if (_loc_4.useDice && _loc_3.actionId == param2.actionId && param2.trigger == false && !(param2 is StateBuff))
                {
                    if (!(param2.effects is EffectInstanceInteger))
                    {
                        throw new Error("Tentative de cumulation d\'effets ambigue");
                    }
                    _loc_3.param1 = _loc_3.param1 + param2.param1;
                    _loc_3.param2 = _loc_3.param2 + param2.param2;
                    _loc_3.param3 = _loc_3.param3 + param2.param3;
                    return;
                }
            }
            _loc_3 = param2.clone();
            this._categories[param1].push(_loc_3);
            return;
        }// end function

        private function getCategory(param1:Effect) : int
        {
            if (param1.characteristic == 71)
            {
                return CATEGORY_STATE;
            }
            if (param1.operator == "-")
            {
                if (param1.active)
                {
                    return CATEGORY_ACTIVE_MALUS;
                }
                return CATEGORY_PASSIVE_MALUS;
            }
            else if (param1.operator == "+")
            {
                if (param1.active)
                {
                    return CATEGORY_ACTIVE_BONUS;
                }
                return CATEGORY_PASSIVE_BONUS;
            }
            return CATEGORY_OTHER;
        }// end function

    }
}
