package com.ankamagames.dofus.scripts.api
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.scripts.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.*;

    public class SpellFxApi extends FxApi
    {

        public function SpellFxApi()
        {
            return;
        }// end function

        public static function GetCastingSpell(param1:SpellFxRunner) : CastingSpell
        {
            return param1.castingSpell;
        }// end function

        public static function GetUsedWeaponType(param1:CastingSpell) : uint
        {
            if (param1.weaponId > 0)
            {
                return Item.getItemById(param1.weaponId).typeId;
            }
            return 0;
        }// end function

        public static function IsCriticalHit(param1:CastingSpell) : Boolean
        {
            return param1.isCriticalHit;
        }// end function

        public static function IsCriticalFail(param1:CastingSpell) : Boolean
        {
            return param1.isCriticalFail;
        }// end function

        public static function GetSpellParam(param1:CastingSpell, param2:String)
        {
            var _loc_3:* = param1.spell.getParamByName(param2, IsCriticalHit(param1));
            if (_loc_3 is String)
            {
                return _loc_3;
            }
            return isNaN(_loc_3) ? (0) : (_loc_3);
        }// end function

        public static function HasSpellParam(param1:CastingSpell, param2:String) : Boolean
        {
            return !isNaN(param1.spell.getParamByName(param2, IsCriticalHit(param1)));
        }// end function

        public static function GetStepType(param1:ISequencable) : String
        {
            if (param1 is IFightStep)
            {
                return (param1 as IFightStep).stepType;
            }
            return "other";
        }// end function

        public static function GetStepsFromType(param1:SpellFxRunner, param2:String) : Vector.<IFightStep>
        {
            var _loc_4:ISequencable = null;
            var _loc_5:IFightStep = null;
            var _loc_3:* = new Vector.<IFightStep>(0, false);
            for each (_loc_4 in param1.stepsBuffer)
            {
                
                if (!(_loc_4 is IFightStep))
                {
                    continue;
                }
                _loc_5 = _loc_4 as IFightStep;
                if (_loc_5.stepType == param2)
                {
                    _loc_3.push(_loc_5);
                }
            }
            return _loc_3;
        }// end function

        public static function AddFrontStep(param1:SpellFxRunner, param2:ISequencable) : void
        {
            param1.stepsBuffer.splice(0, 0, param2);
            return;
        }// end function

        public static function AddBackStep(param1:SpellFxRunner, param2:ISequencable) : void
        {
            param1.stepsBuffer.push(param2);
            return;
        }// end function

        public static function AddStepBefore(param1:SpellFxRunner, param2:ISequencable, param3:ISequencable) : void
        {
            var _loc_6:ISequencable = null;
            var _loc_4:int = -1;
            var _loc_5:uint = 0;
            for each (_loc_6 in param1.stepsBuffer)
            {
                
                if (_loc_6 == param2)
                {
                    _loc_4 = _loc_5;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_4 < 0)
            {
                _log.warn("Cannot add a step before " + param2 + "; step not found.");
                return;
            }
            param1.stepsBuffer.splice(_loc_4, 0, param3);
            return;
        }// end function

        public static function AddStepAfter(param1:SpellFxRunner, param2:ISequencable, param3:ISequencable) : void
        {
            var _loc_6:ISequencable = null;
            var _loc_4:int = -1;
            var _loc_5:uint = 0;
            for each (_loc_6 in param1.stepsBuffer)
            {
                
                if (_loc_6 == param2)
                {
                    _loc_4 = _loc_5;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_4 < 0)
            {
                _log.warn("Cannot add a step after " + param2 + "; step not found.");
                return;
            }
            param1.stepsBuffer.splice((_loc_4 + 1), 0, param3);
            return;
        }// end function

        public static function CreateExplosionEntity(param1:SpellFxRunner, param2:uint, param3:String, param4:uint, param5:Boolean, param6:Boolean, param7:uint) : ExplosionEntity
        {
            var _loc_9:Array = null;
            var _loc_10:uint = 0;
            var _loc_11:int = 0;
            var _loc_8:* = new Uri(TiphonConstants.SWF_SKULL_PATH + "/" + param2 + ".swl");
            if (param3)
            {
                _loc_9 = param3.split(";");
                while (_loc_10 < _loc_9.length)
                {
                    
                    _loc_9[_loc_10] = parseInt(_loc_9[_loc_10], 16);
                    _loc_10 = _loc_10 + 1;
                }
            }
            if (param5)
            {
                _loc_11 = param1.castingSpell.spellRank.spell.spellLevels.indexOf(param1.castingSpell.spellRank.id);
                if (_loc_11 != -1)
                {
                    param4 = param4 * param1.castingSpell.spellRank.spell.spellLevels.length / 10 + param4 * _loc_11 / 10;
                }
            }
            return new ExplosionEntity(_loc_8, _loc_9, param4, param6, param7);
        }// end function

    }
}
