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
            var mountData:Object;
            var ability:uint;
            var nEffect:int;
            var i:int;
            var o:* = param1;
            var cache:* = param2;
            var xpRatio:* = param3;
            if (_dictionary_cache[o.id] && cache)
            {
                mountData = getMountFromCache(o.id);
            }
            else
            {
                mountData = CopyObject.copyObject(o, ["behaviors", "ancestor"]);
                _dictionary_cache[mountData.id] = mountData;
            }
            var mount:* = Mount.getMountById(o.model);
            if (!o.name)
            {
                mountData.name = I18n.getUiText("ui.common.noName");
            }
            mountData.id = o.id;
            mountData.model = o.model;
            mountData.description = mount.name;
            mountData.level = o.level;
            mountData.experience = o.experience;
            mountData.experienceForLevel = o.experienceForLevel;
            mountData.experienceForNextLevel = o.experienceForNextLevel;
            mountData.xpRatio = xpRatio;
            try
            {
                mountData.entityLook = TiphonEntityLook.fromString(mount.look);
                mountData.colors = mountData.entityLook.getColors();
            }
            catch (e:Error)
            {
            }
            var a:* = o.ancestor.concat();
            a.unshift(o.model);
            mountData.ancestor = makeParent(a, 0, -1, 0);
            mountData.ability = new Array();
            var _loc_5:* = 0;
            var _loc_6:* = o.behaviors;
            while (_loc_6 in _loc_5)
            {
                
                ability = _loc_6[_loc_5];
                mountData.ability.push(MountBehavior.getMountBehaviorById(ability));
            }
            mountData.effectList = new Array();
            nEffect = o.effectList.length;
            i;
            while (i < nEffect)
            {
                
                mountData.effectList.push(ObjectEffectAdapter.fromNetwork(o.effectList[i]));
                i = (i + 1);
            }
            mountData.isRideable = o.isRideable;
            mountData.stamina = o.stamina;
            mountData.energy = o.energy;
            mountData.maturity = o.maturity;
            mountData.serenity = o.serenity;
            mountData.love = o.love;
            mountData.fecondationTime = o.fecondationTime;
            mountData.isFecondationReady = o.isFecondationReady;
            mountData.reproductionCount = o.reproductionCount;
            mountData.boostLimiter = o.boostLimiter;
            return mountData;
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
