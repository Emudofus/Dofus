package com.ankamagames.dofus.misc
{
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ObjectEffectAdapter extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ObjectEffectAdapter));

        public function ObjectEffectAdapter()
        {
            return;
        }// end function

        public static function fromNetwork(param1:ObjectEffect) : EffectInstance
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1 is ObjectEffectDice && param1.actionId == 669)
            {
                _loc_2 = new EffectInstanceDate();
                EffectInstanceDate(_loc_2).year = ObjectEffectDice(param1).diceNum;
                EffectInstanceDate(_loc_2).month = ObjectEffectDice(param1).diceSide * 32768 + ObjectEffectDice(param1).diceConst;
                _loc_3 = 1;
                do
                {
                    
                    _loc_6 = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(param1).diceNum, _loc_3);
                    if (_loc_6)
                    {
                        _loc_4 = _loc_6.requiredXp;
                    }
                    _loc_3++;
                    _loc_7 = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(param1).diceNum, _loc_3);
                    if (_loc_7)
                    {
                        _loc_5 = _loc_7.requiredXp;
                    }
                }while (_loc_5 < EffectInstanceDate(_loc_2).month && _loc_3 < 51)
                _loc_3 = _loc_3 - 1;
                EffectInstanceDate(_loc_2).day = _loc_3;
                EffectInstanceDate(_loc_2).hour = 0;
                EffectInstanceDate(_loc_2).minute = 0;
            }
            else
            {
                switch(true)
                {
                    case param1 is ObjectEffectString:
                    {
                        _loc_2 = new EffectInstanceString();
                        EffectInstanceString(_loc_2).text = ObjectEffectString(param1).value;
                        break;
                    }
                    case param1 is ObjectEffectInteger:
                    {
                        _loc_2 = new EffectInstanceInteger();
                        EffectInstanceInteger(_loc_2).value = ObjectEffectInteger(param1).value;
                        break;
                    }
                    case param1 is ObjectEffectMinMax:
                    {
                        _loc_2 = new EffectInstanceMinMax();
                        EffectInstanceMinMax(_loc_2).min = ObjectEffectMinMax(param1).min;
                        EffectInstanceMinMax(_loc_2).max = ObjectEffectMinMax(param1).max;
                        break;
                    }
                    case param1 is ObjectEffectDice:
                    {
                        _loc_2 = new EffectInstanceDice();
                        EffectInstanceDice(_loc_2).diceNum = ObjectEffectDice(param1).diceNum;
                        EffectInstanceDice(_loc_2).diceSide = ObjectEffectDice(param1).diceSide;
                        EffectInstanceDice(_loc_2).value = ObjectEffectDice(param1).diceConst;
                        break;
                    }
                    case param1 is ObjectEffectDate:
                    {
                        _loc_2 = new EffectInstanceDate();
                        EffectInstanceDate(_loc_2).year = ObjectEffectDate(param1).year;
                        EffectInstanceDate(_loc_2).month = ObjectEffectDate(param1).month + 1;
                        EffectInstanceDate(_loc_2).day = ObjectEffectDate(param1).day;
                        EffectInstanceDate(_loc_2).hour = ObjectEffectDate(param1).hour;
                        EffectInstanceDate(_loc_2).minute = ObjectEffectDate(param1).minute;
                        break;
                    }
                    case param1 is ObjectEffectDuration:
                    {
                        _loc_2 = new EffectInstanceDuration();
                        EffectInstanceDuration(_loc_2).days = ObjectEffectDuration(param1).days;
                        EffectInstanceDuration(_loc_2).hours = ObjectEffectDuration(param1).hours;
                        EffectInstanceDuration(_loc_2).minutes = ObjectEffectDuration(param1).minutes;
                        break;
                    }
                    case param1 is ObjectEffectLadder:
                    {
                        _loc_2 = new EffectInstanceLadder();
                        EffectInstanceLadder(_loc_2).monsterFamilyId = ObjectEffectLadder(param1).monsterFamilyId;
                        EffectInstanceLadder(_loc_2).monsterCount = ObjectEffectLadder(param1).monsterCount;
                        break;
                    }
                    case param1 is ObjectEffectCreature:
                    {
                        _loc_2 = new EffectInstanceCreature();
                        EffectInstanceCreature(_loc_2).monsterFamilyId = ObjectEffectCreature(param1).monsterFamilyId;
                        break;
                    }
                    case param1 is ObjectEffectMount:
                    {
                        _loc_2 = new EffectInstanceMount();
                        EffectInstanceMount(_loc_2).date = ObjectEffectMount(param1).date;
                        EffectInstanceMount(_loc_2).modelId = ObjectEffectMount(param1).modelId;
                        EffectInstanceMount(_loc_2).mountId = ObjectEffectMount(param1).mountId;
                        break;
                    }
                    default:
                    {
                        _loc_2 = new EffectInstance();
                        break;
                        break;
                    }
                }
            }
            _loc_2.effectId = param1.actionId;
            _loc_2.duration = 0;
            return _loc_2;
        }// end function

    }
}
