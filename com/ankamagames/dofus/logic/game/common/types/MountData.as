package com.ankamagames.dofus.logic.game.common.types
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.mounts.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class MountData extends Object
    {
        private static var _dictionary_cache:Dictionary = new Dictionary();

        public function MountData()
        {
            return;
        }// end function

        public static function makeMountData(param1:MountClientData, param2:Boolean = true, param3:uint = 0) : Object
        {
            var _loc_4:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (_dictionary_cache[param1.id] && param2)
            {
                _loc_4 = getMountFromCache(param1.id);
            }
            else
            {
                _loc_4 = CopyObject.copyObject(param1, ["behaviors", "ancestor"]);
                _dictionary_cache[_loc_4.id] = _loc_4;
            }
            var _loc_5:* = Mount.getMountById(param1.model);
            if (!param1.name)
            {
                _loc_4.name = I18n.getUiText("ui.common.noName");
            }
            _loc_4.id = param1.id;
            _loc_4.model = param1.model;
            _loc_4.description = _loc_5.name;
            _loc_4.level = param1.level;
            _loc_4.experience = param1.experience;
            _loc_4.experienceForLevel = param1.experienceForLevel;
            _loc_4.experienceForNextLevel = param1.experienceForNextLevel;
            _loc_4.xpRatio = param3;
            try
            {
                _loc_4.entityLook = TiphonEntityLook.fromString(_loc_5.look);
                _loc_4.colors = _loc_4.entityLook.getColors();
            }
            catch (e:Error)
            {
            }
            var _loc_6:* = param1.ancestor.concat();
            param1.ancestor.concat().unshift(param1.model);
            _loc_4.ancestor = makeParent(_loc_6, 0, -1, 0);
            _loc_4.ability = new Array();
            for each (_loc_7 in param1.behaviors)
            {
                
                _loc_4.ability.push(MountBehavior.getMountBehaviorById(_loc_7));
            }
            _loc_4.effectList = new Array();
            _loc_8 = param1.effectList.length;
            _loc_9 = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_4.effectList.push(ObjectEffectAdapter.fromNetwork(param1.effectList[_loc_9]));
                _loc_9++;
            }
            _loc_4.isRideable = param1.isRideable;
            _loc_4.stamina = param1.stamina;
            _loc_4.energy = param1.energy;
            _loc_4.maturity = param1.maturity;
            _loc_4.serenity = param1.serenity;
            _loc_4.love = param1.love;
            _loc_4.fecondationTime = param1.fecondationTime;
            _loc_4.isFecondationReady = param1.isFecondationReady;
            _loc_4.reproductionCount = param1.reproductionCount;
            _loc_4.boostLimiter = param1.boostLimiter;
            return _loc_4;
        }// end function

        public static function getMountFromCache(param1:uint) : Object
        {
            return _dictionary_cache[param1];
        }// end function

        private static function makeParent(param1:Vector.<uint>, param2:uint, param3:int, param4:uint) : Object
        {
            var _loc_5:* = param3 + Math.pow(2, (param2 - 1));
            var _loc_6:* = param3 + Math.pow(2, (param2 - 1)) + param4;
            if (param1.length <= _loc_6)
            {
                return null;
            }
            var _loc_7:* = Mount.getMountById(param1[_loc_6]);
            if (!Mount.getMountById(param1[_loc_6]))
            {
                return null;
            }
            return {mount:_loc_7, mother:makeParent(param1, (param2 + 1), _loc_5, 0 + 2 * (_loc_6 - _loc_5)), father:makeParent(param1, (param2 + 1), _loc_5, 1 + 2 * (_loc_6 - _loc_5)), entityLook:TiphonEntityLook.fromString(_loc_7.look)};
        }// end function

    }
}
