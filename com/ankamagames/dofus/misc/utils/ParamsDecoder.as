package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.datacenter.challenges.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class ParamsDecoder extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ParamsDecoder));

        public function ParamsDecoder()
        {
            return;
        }// end function

        public static function applyParams(param1:String, param2:Array, param3:String = "%") : String
        {
            var _loc_10:String = null;
            var _loc_4:Boolean = false;
            var _loc_5:Boolean = false;
            var _loc_6:String = "";
            var _loc_7:String = "";
            var _loc_8:String = "";
            var _loc_9:uint = 0;
            while (_loc_9 < param1.length)
            {
                
                _loc_10 = param1.charAt(_loc_9);
                if (_loc_10 == "$")
                {
                    _loc_4 = true;
                }
                else if (_loc_10 == param3)
                {
                    if ((_loc_9 + 1) < param1.length && param1.charAt((_loc_9 + 1)) == param3)
                    {
                        _loc_5 = false;
                        _loc_4 = false;
                        _loc_9 = _loc_9 + 1;
                    }
                    else
                    {
                        _loc_4 = false;
                        _loc_5 = true;
                    }
                }
                if (_loc_4)
                {
                    _loc_6 = _loc_6 + _loc_10;
                }
                else if (_loc_5)
                {
                    if (_loc_10 == param3)
                    {
                        if (_loc_7.length == 0)
                        {
                            _loc_7 = _loc_7 + _loc_10;
                        }
                        else
                        {
                            _loc_8 = _loc_8 + processReplace(_loc_6, _loc_7, param2);
                            _loc_6 = "";
                            _loc_7 = "" + _loc_10;
                        }
                    }
                    else if (_loc_10 >= "0" && _loc_10 <= "9")
                    {
                        _loc_7 = _loc_7 + _loc_10;
                        if ((_loc_9 + 1) == param1.length)
                        {
                            _loc_5 = false;
                            _loc_8 = _loc_8 + processReplace(_loc_6, _loc_7, param2);
                            _loc_6 = "";
                            _loc_7 = "";
                        }
                    }
                    else
                    {
                        _loc_5 = false;
                        _loc_8 = _loc_8 + processReplace(_loc_6, _loc_7, param2);
                        _loc_6 = "";
                        _loc_7 = "";
                        _loc_8 = _loc_8 + _loc_10;
                    }
                }
                else
                {
                    if (_loc_7 != "")
                    {
                        _loc_8 = _loc_8 + processReplace(_loc_6, _loc_7, param2);
                        _loc_6 = "";
                        _loc_7 = "";
                    }
                    _loc_8 = _loc_8 + _loc_10;
                }
                _loc_9 = _loc_9 + 1;
            }
            return _loc_8;
        }// end function

        private static function processReplace(param1:String, param2:String, param3:Array) : String
        {
            var _loc_5:int = 0;
            var _loc_6:Item = null;
            var _loc_7:ItemType = null;
            var _loc_8:Job = null;
            var _loc_9:Quest = null;
            var _loc_10:Spell = null;
            var _loc_11:SpellState = null;
            var _loc_12:Breed = null;
            var _loc_13:Area = null;
            var _loc_14:SubArea = null;
            var _loc_15:MapPosition = null;
            var _loc_16:Emoticon = null;
            var _loc_17:Monster = null;
            var _loc_18:MonsterRace = null;
            var _loc_19:MonsterSuperRace = null;
            var _loc_20:Challenge = null;
            var _loc_21:AlignmentSide = null;
            var _loc_22:Array = null;
            var _loc_23:Dungeon = null;
            var _loc_24:ItemWrapper = null;
            var _loc_4:String = "";
            _loc_5 = int(Number(param2.substr(1))) - 1;
            if (param1 == "")
            {
                _loc_4 = param3[_loc_5];
            }
            else
            {
                switch(param1)
                {
                    case "$item":
                    {
                        _loc_6 = Item.getItemById(param3[_loc_5]);
                        if (_loc_6)
                        {
                            _loc_24 = ItemWrapper.create(0, 0, param3[_loc_5], 0, null, false);
                            _loc_4 = HyperlinkItemManager.newChatItem(_loc_24);
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$itemType":
                    {
                        _loc_7 = ItemType.getItemTypeById(param3[_loc_5]);
                        if (_loc_7)
                        {
                            _loc_4 = _loc_7.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$job":
                    {
                        _loc_8 = Job.getJobById(param3[_loc_5]);
                        if (_loc_8)
                        {
                            _loc_4 = _loc_8.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$quest":
                    {
                        _loc_9 = Quest.getQuestById(param3[_loc_5]);
                        if (_loc_9)
                        {
                            _loc_4 = HyperlinkShowQuestManager.addQuest(_loc_9.id);
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$spell":
                    {
                        _loc_10 = Spell.getSpellById(param3[_loc_5]);
                        if (_loc_10)
                        {
                            _loc_4 = _loc_10.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$spellState":
                    {
                        _loc_11 = SpellState.getSpellStateById(param3[_loc_5]);
                        if (_loc_11)
                        {
                            _loc_4 = _loc_11.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$breed":
                    {
                        _loc_12 = Breed.getBreedById(param3[_loc_5]);
                        if (_loc_12)
                        {
                            _loc_4 = _loc_12.shortName;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$area":
                    {
                        _loc_13 = Area.getAreaById(param3[_loc_5]);
                        if (_loc_13)
                        {
                            _loc_4 = _loc_13.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$subarea":
                    {
                        _loc_14 = SubArea.getSubAreaById(param3[_loc_5]);
                        if (_loc_14)
                        {
                            _loc_4 = _loc_14.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$map":
                    {
                        _loc_15 = MapPosition.getMapPositionById(param3[_loc_5]);
                        if (_loc_15)
                        {
                            if (_loc_15.name)
                            {
                                _loc_4 = _loc_15.name;
                            }
                            else
                            {
                                _loc_4 = "{map," + int(_loc_15.posX) + "," + int(_loc_15.posY) + "}";
                            }
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$emote":
                    {
                        _loc_16 = Emoticon.getEmoticonById(param3[_loc_5]);
                        if (_loc_16)
                        {
                            _loc_4 = _loc_16.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$monster":
                    {
                        _loc_17 = Monster.getMonsterById(param3[_loc_5]);
                        if (_loc_17)
                        {
                            _loc_4 = _loc_17.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$monsterRace":
                    {
                        _loc_18 = MonsterRace.getMonsterRaceById(param3[_loc_5]);
                        if (_loc_18)
                        {
                            _loc_4 = _loc_18.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$monsterSuperRace":
                    {
                        _loc_19 = MonsterSuperRace.getMonsterSuperRaceById(param3[_loc_5]);
                        if (_loc_19)
                        {
                            _loc_4 = _loc_19.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$challenge":
                    {
                        _loc_20 = Challenge.getChallengeById(param3[_loc_5]);
                        if (_loc_20)
                        {
                            _loc_4 = _loc_20.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$alignment":
                    {
                        _loc_21 = AlignmentSide.getAlignmentSideById(param3[_loc_5]);
                        if (_loc_21)
                        {
                            _loc_4 = _loc_21.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$stat":
                    {
                        _loc_22 = I18n.getUiText("ui.item.characteristics").split(",");
                        if (_loc_22[param3[_loc_5]])
                        {
                            _loc_4 = _loc_22[param3[_loc_5]];
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$dungeon":
                    {
                        _loc_23 = Dungeon.getDungeonById(param3[_loc_5]);
                        if (_loc_23)
                        {
                            _loc_4 = _loc_23.name;
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return _loc_4;
        }// end function

    }
}
