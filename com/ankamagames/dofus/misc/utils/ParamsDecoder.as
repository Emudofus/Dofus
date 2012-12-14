package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.appearance.*;
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
            var _loc_10:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = "";
            var _loc_7:* = "";
            var _loc_8:* = "";
            var _loc_9:* = 0;
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
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_4:* = "";
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
                            _loc_27 = ItemWrapper.create(0, 0, param3[_loc_5], 0, null, false);
                            _loc_4 = HyperlinkItemManager.newChatItem(_loc_27);
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
                    case "$achievement":
                    {
                        _loc_10 = Achievement.getAchievementById(param3[_loc_5]);
                        if (_loc_10)
                        {
                            _loc_4 = HyperlinkShowAchievementManager.addAchievement(_loc_10.id);
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$title":
                    {
                        _loc_11 = Title.getTitleById(param3[_loc_5]);
                        if (_loc_11)
                        {
                            _loc_4 = HyperlinkShowTitleManager.addTitle(_loc_11.id);
                        }
                        else
                        {
                            _log.error(param1 + " " + param3[_loc_5] + " introuvable");
                            _loc_4 = "";
                        }
                        break;
                    }
                    case "$ornament":
                    {
                        _loc_12 = Ornament.getOrnamentById(param3[_loc_5]);
                        if (_loc_12)
                        {
                            _loc_4 = HyperlinkShowOrnamentManager.addOrnament(_loc_12.id);
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
                        _loc_13 = Spell.getSpellById(param3[_loc_5]);
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
                    case "$spellState":
                    {
                        _loc_14 = SpellState.getSpellStateById(param3[_loc_5]);
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
                    case "$breed":
                    {
                        _loc_15 = Breed.getBreedById(param3[_loc_5]);
                        if (_loc_15)
                        {
                            _loc_4 = _loc_15.shortName;
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
                        _loc_16 = Area.getAreaById(param3[_loc_5]);
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
                    case "$subarea":
                    {
                        _loc_17 = SubArea.getSubAreaById(param3[_loc_5]);
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
                    case "$map":
                    {
                        _loc_18 = MapPosition.getMapPositionById(param3[_loc_5]);
                        if (_loc_18)
                        {
                            if (_loc_18.name)
                            {
                                _loc_4 = _loc_18.name;
                            }
                            else
                            {
                                _loc_4 = "{map," + int(_loc_18.posX) + "," + int(_loc_18.posY) + "}";
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
                        _loc_19 = Emoticon.getEmoticonById(param3[_loc_5]);
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
                    case "$monster":
                    {
                        _loc_20 = Monster.getMonsterById(param3[_loc_5]);
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
                    case "$monsterRace":
                    {
                        _loc_21 = MonsterRace.getMonsterRaceById(param3[_loc_5]);
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
                    case "$monsterSuperRace":
                    {
                        _loc_22 = MonsterSuperRace.getMonsterSuperRaceById(param3[_loc_5]);
                        if (_loc_22)
                        {
                            _loc_4 = _loc_22.name;
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
                        _loc_23 = Challenge.getChallengeById(param3[_loc_5]);
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
                    case "$alignment":
                    {
                        _loc_24 = AlignmentSide.getAlignmentSideById(param3[_loc_5]);
                        if (_loc_24)
                        {
                            _loc_4 = _loc_24.name;
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
                        _loc_25 = I18n.getUiText("ui.item.characteristics").split(",");
                        if (_loc_25[param3[_loc_5]])
                        {
                            _loc_4 = _loc_25[param3[_loc_5]];
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
                        _loc_26 = Dungeon.getDungeonById(param3[_loc_5]);
                        if (_loc_26)
                        {
                            _loc_4 = _loc_26.name;
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
