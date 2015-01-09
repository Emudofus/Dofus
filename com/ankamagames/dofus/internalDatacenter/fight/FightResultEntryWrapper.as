package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultPlayerListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultTaxCollectorListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightTaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultMutantListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultAdditionalData;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultExperienceData;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultPvpData;
    import com.ankamagames.dofus.network.types.game.context.fight.FightResultFighterListEntry;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;

    public class FightResultEntryWrapper implements IDataCenter 
    {

        private var _item:FightResultListEntry;
        public var outcome:int;
        public var id:int;
        public var name:String;
        public var alive:Boolean;
        public var rewards:FightLootWrapper;
        public var level:int;
        public var type:int;
        public var fightInitiator:Boolean;
        public var breed:int = 0;
        public var gender:int = 0;
        public var wave:int;
        public var isLastOfHisWave:Boolean = false;
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
        public var grade:uint;
        public var honor:uint;
        public var honorDelta:int = -1;
        public var maxHonorForGrade:uint;
        public var minHonorForGrade:uint;
        public var isIncarnationExperience:Boolean;

        public function FightResultEntryWrapper(o:FightResultListEntry, infos:GameFightFighterInformations=null)
        {
            var _local_3:FightResultPlayerListEntry;
            var _local_4:FightResultTaxCollectorListEntry;
            var _local_5:GameFightTaxCollectorInformations;
            var _local_6:FightResultMutantListEntry;
            var monsterInfos0:GameFightMonsterInformations;
            var monster0:Monster;
            var tcInfos:GameFightTaxCollectorInformations;
            var _local_10:FightResultAdditionalData;
            var monsterInfos:GameFightMonsterInformations;
            var monster:Monster;
            var companionInfos:GameFightCompanionInformations;
            var companion:Companion;
            super();
            this._item = o;
            this.outcome = o.outcome;
            this.rewards = new FightLootWrapper(o.rewards);
            switch (true)
            {
                case (o is FightResultPlayerListEntry):
                    _local_3 = (o as FightResultPlayerListEntry);
                    if (!(infos)) break;
                    if ((infos is GameFightMonsterInformations))
                    {
                        monsterInfos0 = (infos as GameFightMonsterInformations);
                        monster0 = Monster.getMonsterById(monsterInfos0.creatureGenericId);
                        this.name = monster0.name;
                        this.level = monster0.getMonsterGrade(monsterInfos0.creatureGrade).level;
                        this.id = monster0.id;
                        this.alive = monsterInfos0.alive;
                        this.type = 1;
                    }
                    else
                    {
                        if ((infos is GameFightTaxCollectorInformations))
                        {
                            tcInfos = (infos as GameFightTaxCollectorInformations);
                            this.name = ((TaxCollectorFirstname.getTaxCollectorFirstnameById(tcInfos.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(tcInfos.lastNameId).name);
                            this.level = tcInfos.level;
                            this.id = tcInfos.contextualId;
                            this.alive = tcInfos.alive;
                            this.type = 2;
                        }
                        else
                        {
                            this.name = (infos as GameFightFighterNamedInformations).name;
                            this.level = _local_3.level;
                            this.id = _local_3.id;
                            this.alive = _local_3.alive;
                            if ((infos is GameFightCharacterInformations))
                            {
                                this.breed = (infos as GameFightCharacterInformations).breed;
                                this.gender = int((infos as GameFightCharacterInformations).sex);
                            };
                            this.type = 0;
                            if (_local_3.additional.length == 0)
                            {
                                return;
                            };
                            for each (_local_10 in _local_3.additional)
                            {
                                switch (true)
                                {
                                    case (_local_10 is FightResultExperienceData):
                                        this.rerollXpMultiplicator = (_local_10 as FightResultExperienceData).rerollExperienceMul;
                                        this.experience = (_local_10 as FightResultExperienceData).experience;
                                        this.showExperience = (_local_10 as FightResultExperienceData).showExperience;
                                        this.experienceLevelFloor = (_local_10 as FightResultExperienceData).experienceLevelFloor;
                                        this.showExperienceLevelFloor = (_local_10 as FightResultExperienceData).showExperienceLevelFloor;
                                        this.experienceNextLevelFloor = (_local_10 as FightResultExperienceData).experienceNextLevelFloor;
                                        this.showExperienceNextLevelFloor = (_local_10 as FightResultExperienceData).showExperienceNextLevelFloor;
                                        this.experienceFightDelta = (_local_10 as FightResultExperienceData).experienceFightDelta;
                                        this.showExperienceFightDelta = (_local_10 as FightResultExperienceData).showExperienceFightDelta;
                                        this.experienceForGuild = (_local_10 as FightResultExperienceData).experienceForGuild;
                                        this.showExperienceForGuild = (_local_10 as FightResultExperienceData).showExperienceForGuild;
                                        this.experienceForRide = (_local_10 as FightResultExperienceData).experienceForMount;
                                        this.showExperienceForRide = (_local_10 as FightResultExperienceData).showExperienceForMount;
                                        this.isIncarnationExperience = (_local_10 as FightResultExperienceData).isIncarnationExperience;
                                        this.honorDelta = -1;
                                        break;
                                    case (_local_10 is FightResultPvpData):
                                        this.grade = (_local_10 as FightResultPvpData).grade;
                                        this.honor = (_local_10 as FightResultPvpData).honor;
                                        this.honorDelta = (_local_10 as FightResultPvpData).honorDelta;
                                        this.maxHonorForGrade = (_local_10 as FightResultPvpData).maxHonorForGrade;
                                        this.minHonorForGrade = (_local_10 as FightResultPvpData).minHonorForGrade;
                                        break;
                                };
                            };
                        };
                    };
                    return;
                case (o is FightResultTaxCollectorListEntry):
                    _local_4 = (o as FightResultTaxCollectorListEntry);
                    _local_5 = (infos as GameFightTaxCollectorInformations);
                    if (_local_5)
                    {
                        this.name = ((TaxCollectorFirstname.getTaxCollectorFirstnameById(_local_5.firstNameId).firstname + " ") + TaxCollectorName.getTaxCollectorNameById(_local_5.lastNameId).name);
                    }
                    else
                    {
                        this.name = _local_4.guildInfo.guildName;
                    };
                    this.level = _local_4.level;
                    this.experienceForGuild = _local_4.experienceForGuild;
                    this.id = _local_4.id;
                    this.alive = _local_4.alive;
                    this.type = 2;
                    return;
                case (o is FightResultMutantListEntry):
                    _local_6 = (o as FightResultMutantListEntry);
                    this.name = (infos as GameFightFighterNamedInformations).name;
                    this.level = _local_6.level;
                    this.id = _local_6.id;
                    this.alive = _local_6.alive;
                    this.type = 1;
                    return;
                case (o is FightResultFighterListEntry):
                    if ((infos is GameFightMonsterInformations))
                    {
                        monsterInfos = (infos as GameFightMonsterInformations);
                        monster = Monster.getMonsterById(monsterInfos.creatureGenericId);
                        this.name = monster.name;
                        this.level = monster.getMonsterGrade(monsterInfos.creatureGrade).level;
                        this.id = monster.id;
                        this.alive = monsterInfos.alive;
                        this.type = 1;
                    }
                    else
                    {
                        if ((infos is GameFightCompanionInformations))
                        {
                            companionInfos = (infos as GameFightCompanionInformations);
                            companion = Companion.getCompanionById(companionInfos.companionGenericId);
                            this.name = companion.name;
                            this.level = companionInfos.level;
                            this.id = companion.id;
                            this.alive = companionInfos.alive;
                            this.type = 1;
                        };
                    };
                    return;
                case (o is FightResultListEntry):
                    return;
            };
        }

    }
}//package com.ankamagames.dofus.internalDatacenter.fight

