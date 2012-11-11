package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class FightResultEntryWrapper extends Object implements IDataCenter
    {
        private var _item:FightResultListEntry;
        public var outcome:int;
        public var id:int;
        public var name:String;
        public var alive:Boolean;
        public var rewards:FightLootWrapper;
        public var level:int;
        public var type:int;
        public var rerollXpMultiplicator:int;
        public var experience:Number;
        public var showExperience:Boolean = false;
        public var experienceLevelFloor:Number;
        public var showExperienceLevelFloor:Boolean = false;
        public var experienceNextLevelFloor:Number;
        public var showExperienceNextLevelFloor:Boolean = false;
        public var experienceFightDelta:Number;
        public var showExperienceFightDelta:Boolean = false;
        public var experienceForGuild:Number;
        public var showExperienceForGuild:Boolean = false;
        public var experienceForRide:Number;
        public var showExperienceForRide:Boolean = false;
        public var dishonor:uint;
        public var dishonorDelta:int = -1;
        public var grade:uint;
        public var honor:uint;
        public var honorDelta:int = -1;
        public var maxHonorForGrade:uint;
        public var minHonorForGrade:uint;
        public var isIncarnationExperience:Boolean;

        public function FightResultEntryWrapper(param1:FightResultListEntry, param2:GameFightFighterInformations = null)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this._item = param1;
            this.outcome = param1.outcome;
            this.rewards = new FightLootWrapper(param1.rewards);
            switch(true)
            {
                case param1 is FightResultPlayerListEntry:
                {
                    _loc_3 = param1 as FightResultPlayerListEntry;
                    if (!param2)
                    {
                        break;
                    }
                    if (param2 is GameFightMonsterInformations)
                    {
                        _loc_9 = param2 as GameFightMonsterInformations;
                        _loc_10 = Monster.getMonsterById(_loc_9.creatureGenericId);
                        this.name = _loc_10.name;
                        this.level = _loc_10.getMonsterGrade(_loc_9.creatureGrade).level;
                        this.id = _loc_10.id;
                        this.alive = _loc_9.alive;
                        this.type = 1;
                    }
                    else if (param2 is GameFightTaxCollectorInformations)
                    {
                        _loc_11 = param2 as GameFightTaxCollectorInformations;
                        this.name = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_11.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_11.lastNameId).name;
                        this.level = _loc_11.level;
                        this.id = _loc_11.contextualId;
                        this.alive = _loc_11.alive;
                        this.type = 2;
                    }
                    else
                    {
                        this.name = (param2 as GameFightFighterNamedInformations).name;
                        this.level = _loc_3.level;
                        this.id = _loc_3.id;
                        this.alive = _loc_3.alive;
                        this.type = 0;
                        if (_loc_3.additional.length == 0)
                        {
                            break;
                        }
                        for each (_loc_12 in _loc_3.additional)
                        {
                            
                            switch(true)
                            {
                                case _loc_12 is FightResultExperienceData:
                                {
                                    this.rerollXpMultiplicator = (_loc_12 as FightResultExperienceData).rerollExperienceMul;
                                    this.experience = (_loc_12 as FightResultExperienceData).experience;
                                    this.showExperience = (_loc_12 as FightResultExperienceData).showExperience;
                                    this.experienceLevelFloor = (_loc_12 as FightResultExperienceData).experienceLevelFloor;
                                    this.showExperienceLevelFloor = (_loc_12 as FightResultExperienceData).showExperienceLevelFloor;
                                    this.experienceNextLevelFloor = (_loc_12 as FightResultExperienceData).experienceNextLevelFloor;
                                    this.showExperienceNextLevelFloor = (_loc_12 as FightResultExperienceData).showExperienceNextLevelFloor;
                                    this.experienceFightDelta = (_loc_12 as FightResultExperienceData).experienceFightDelta;
                                    this.showExperienceFightDelta = (_loc_12 as FightResultExperienceData).showExperienceFightDelta;
                                    this.experienceForGuild = (_loc_12 as FightResultExperienceData).experienceForGuild;
                                    this.showExperienceForGuild = (_loc_12 as FightResultExperienceData).showExperienceForGuild;
                                    this.experienceForRide = (_loc_12 as FightResultExperienceData).experienceForMount;
                                    this.showExperienceForRide = (_loc_12 as FightResultExperienceData).showExperienceForMount;
                                    this.isIncarnationExperience = (_loc_12 as FightResultExperienceData).isIncarnationExperience;
                                    this.dishonorDelta = -1;
                                    this.honorDelta = -1;
                                    break;
                                }
                                case _loc_12 is FightResultPvpData:
                                {
                                    this.dishonor = (_loc_12 as FightResultPvpData).dishonor;
                                    this.dishonorDelta = (_loc_12 as FightResultPvpData).dishonorDelta;
                                    this.grade = (_loc_12 as FightResultPvpData).grade;
                                    this.honor = (_loc_12 as FightResultPvpData).honor;
                                    this.honorDelta = (_loc_12 as FightResultPvpData).honorDelta;
                                    this.maxHonorForGrade = (_loc_12 as FightResultPvpData).maxHonorForGrade;
                                    this.minHonorForGrade = (_loc_12 as FightResultPvpData).minHonorForGrade;
                                    break;
                                }
                                default:
                                {
                                    break;
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                case param1 is FightResultTaxCollectorListEntry:
                {
                    _loc_4 = param1 as FightResultTaxCollectorListEntry;
                    _loc_5 = param2 as GameFightTaxCollectorInformations;
                    if (_loc_5)
                    {
                        this.name = TaxCollectorFirstname.getTaxCollectorFirstnameById(_loc_5.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(_loc_5.lastNameId).name;
                    }
                    else
                    {
                        this.name = _loc_4.guildInfo.guildName;
                    }
                    this.level = _loc_4.level;
                    this.experienceForGuild = _loc_4.experienceForGuild;
                    this.id = _loc_4.id;
                    this.alive = _loc_4.alive;
                    this.type = 2;
                    break;
                }
                case param1 is FightResultMutantListEntry:
                {
                    _loc_6 = param1 as FightResultMutantListEntry;
                    this.name = (param2 as GameFightFighterNamedInformations).name;
                    this.level = _loc_6.level;
                    this.id = _loc_6.id;
                    this.alive = _loc_6.alive;
                    this.type = 1;
                    break;
                }
                case param1 is FightResultFighterListEntry:
                {
                    _loc_7 = param2 as GameFightMonsterInformations;
                    _loc_8 = Monster.getMonsterById(_loc_7.creatureGenericId);
                    this.name = _loc_8.name;
                    this.level = _loc_8.getMonsterGrade(_loc_7.creatureGrade).level;
                    this.id = _loc_8.id;
                    this.alive = _loc_7.alive;
                    this.type = 1;
                    break;
                }
                case param1 is FightResultListEntry:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
