package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.datacenter.items.ItemType;
    import com.ankamagames.dofus.datacenter.jobs.Job;
    import com.ankamagames.dofus.datacenter.quest.Quest;
    import com.ankamagames.dofus.datacenter.quest.Achievement;
    import com.ankamagames.dofus.datacenter.appearance.Title;
    import com.ankamagames.dofus.datacenter.appearance.Ornament;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellState;
    import com.ankamagames.dofus.datacenter.breeds.Breed;
    import com.ankamagames.dofus.datacenter.world.Area;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.dofus.datacenter.communication.Emoticon;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
    import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
    import com.ankamagames.dofus.datacenter.challenges.Challenge;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
    import com.ankamagames.dofus.datacenter.world.Dungeon;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowQuestManager;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowAchievementManager;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowTitleManager;
    import com.ankamagames.dofus.logic.common.managers.HyperlinkShowOrnamentManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;

    public class ParamsDecoder 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ParamsDecoder));


        public static function applyParams(txt:String, params:Array, replace:String="%"):String
        {
            var c:String;
            var lectureType:Boolean;
            var lectureId:Boolean;
            var type:String = "";
            var id:String = "";
            var s:String = "";
            var i:uint;
            while (i < txt.length)
            {
                c = txt.charAt(i);
                if (c == "$")
                {
                    lectureType = true;
                }
                else
                {
                    if (c == replace)
                    {
                        if (((((i + 1) < txt.length)) && ((txt.charAt((i + 1)) == replace))))
                        {
                            lectureId = false;
                            lectureType = false;
                            i++;
                        }
                        else
                        {
                            lectureType = false;
                            lectureId = true;
                        };
                    };
                };
                if (lectureType)
                {
                    type = (type + c);
                }
                else
                {
                    if (lectureId)
                    {
                        if (c == replace)
                        {
                            if (id.length == 0)
                            {
                                id = (id + c);
                            }
                            else
                            {
                                s = (s + processReplace(type, id, params));
                                type = "";
                                id = ("" + c);
                            };
                        }
                        else
                        {
                            if ((((c >= "0")) && ((c <= "9"))))
                            {
                                id = (id + c);
                                if ((i + 1) == txt.length)
                                {
                                    lectureId = false;
                                    s = (s + processReplace(type, id, params));
                                    type = "";
                                    id = "";
                                };
                            }
                            else
                            {
                                lectureId = false;
                                s = (s + processReplace(type, id, params));
                                type = "";
                                id = "";
                                s = (s + c);
                            };
                        };
                    }
                    else
                    {
                        if (id != "")
                        {
                            s = (s + processReplace(type, id, params));
                            type = "";
                            id = "";
                        };
                        s = (s + c);
                    };
                };
                i++;
            };
            return (s);
        }

        private static function processReplace(type:String, id:String, params:Array):String
        {
            var nid:int;
            var _local_6:Item;
            var _local_7:ItemType;
            var _local_8:Job;
            var _local_9:Quest;
            var _local_10:Achievement;
            var _local_11:Title;
            var _local_12:Ornament;
            var _local_13:Spell;
            var _local_14:SpellState;
            var _local_15:Breed;
            var _local_16:Area;
            var _local_17:SubArea;
            var _local_18:MapPosition;
            var _local_19:Emoticon;
            var _local_20:Monster;
            var _local_21:MonsterRace;
            var _local_22:MonsterSuperRace;
            var _local_23:Challenge;
            var _local_24:AlignmentSide;
            var _local_25:Array;
            var _local_26:Dungeon;
            var _local_27:Date;
            var _local_28:uint;
            var _local_29:Companion;
            var itemw:ItemWrapper;
            var newString:String = "";
            nid = (int(Number(id.substr(1))) - 1);
            if (type == "")
            {
                newString = params[nid];
            }
            else
            {
                switch (type)
                {
                    case "$item":
                        _local_6 = Item.getItemById(params[nid]);
                        if (_local_6)
                        {
                            itemw = ItemWrapper.create(0, 0, params[nid], 0, null, false);
                            newString = HyperlinkItemManager.newChatItem(itemw);
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$itemType":
                        _local_7 = ItemType.getItemTypeById(params[nid]);
                        if (_local_7)
                        {
                            newString = _local_7.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$quantity":
                        newString = StringUtils.formateIntToString(int(params[nid]));
                        break;
                    case "$job":
                        _local_8 = Job.getJobById(params[nid]);
                        if (_local_8)
                        {
                            newString = _local_8.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$quest":
                        _local_9 = Quest.getQuestById(params[nid]);
                        if (_local_9)
                        {
                            newString = HyperlinkShowQuestManager.addQuest(_local_9.id);
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$achievement":
                        _local_10 = Achievement.getAchievementById(params[nid]);
                        if (_local_10)
                        {
                            newString = HyperlinkShowAchievementManager.addAchievement(_local_10.id);
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$title":
                        _local_11 = Title.getTitleById(params[nid]);
                        if (_local_11)
                        {
                            newString = HyperlinkShowTitleManager.addTitle(_local_11.id);
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$ornament":
                        _local_12 = Ornament.getOrnamentById(params[nid]);
                        if (_local_12)
                        {
                            newString = HyperlinkShowOrnamentManager.addOrnament(_local_12.id);
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$spell":
                        _local_13 = Spell.getSpellById(params[nid]);
                        if (_local_13)
                        {
                            newString = _local_13.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$spellState":
                        _local_14 = SpellState.getSpellStateById(params[nid]);
                        if (_local_14)
                        {
                            newString = _local_14.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$breed":
                        _local_15 = Breed.getBreedById(params[nid]);
                        if (_local_15)
                        {
                            newString = _local_15.shortName;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$area":
                        _local_16 = Area.getAreaById(params[nid]);
                        if (_local_16)
                        {
                            newString = _local_16.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$subarea":
                        _local_17 = SubArea.getSubAreaById(params[nid]);
                        if (_local_17)
                        {
                            newString = (("{subArea," + params[nid]) + "}");
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$map":
                        _local_18 = MapPosition.getMapPositionById(params[nid]);
                        if (_local_18)
                        {
                            if (_local_18.name)
                            {
                                newString = _local_18.name;
                            }
                            else
                            {
                                newString = (((((("{map," + int(_local_18.posX)) + ",") + int(_local_18.posY)) + ",") + int(_local_18.worldMap)) + "}");
                            };
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$emote":
                        _local_19 = Emoticon.getEmoticonById(params[nid]);
                        if (_local_19)
                        {
                            newString = _local_19.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$monster":
                        _local_20 = Monster.getMonsterById(params[nid]);
                        if (_local_20)
                        {
                            newString = _local_20.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$monsterRace":
                        _local_21 = MonsterRace.getMonsterRaceById(params[nid]);
                        if (_local_21)
                        {
                            newString = _local_21.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$monsterSuperRace":
                        _local_22 = MonsterSuperRace.getMonsterSuperRaceById(params[nid]);
                        if (_local_22)
                        {
                            newString = _local_22.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$challenge":
                        _local_23 = Challenge.getChallengeById(params[nid]);
                        if (_local_23)
                        {
                            newString = _local_23.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$alignment":
                        _local_24 = AlignmentSide.getAlignmentSideById(params[nid]);
                        if (_local_24)
                        {
                            newString = _local_24.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$stat":
                        _local_25 = I18n.getUiText("ui.item.characteristics").split(",");
                        if (_local_25[params[nid]])
                        {
                            newString = _local_25[params[nid]];
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$dungeon":
                        _local_26 = Dungeon.getDungeonById(params[nid]);
                        if (_local_26)
                        {
                            newString = _local_26.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    case "$time":
                        _local_27 = new Date();
                        _local_28 = ((params[nid] * 1000) - _local_27.time);
                        newString = TimeManager.getInstance().getDuration(_local_28);
                        break;
                    case "$companion":
                    case "$sidekick":
                        _local_29 = Companion.getCompanionById(params[nid]);
                        if (_local_29)
                        {
                            newString = _local_29.name;
                        }
                        else
                        {
                            _log.error((((type + " ") + params[nid]) + " introuvable"));
                            newString = "";
                        };
                        break;
                    default:
                        trace((("Error ! The parameter type (" + type) + ") is unknown."));
                };
            };
            return (newString);
        }


    }
}//package com.ankamagames.dofus.misc.utils

