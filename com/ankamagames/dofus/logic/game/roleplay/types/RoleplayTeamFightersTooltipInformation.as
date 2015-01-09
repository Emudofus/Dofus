package com.ankamagames.dofus.logic.game.roleplay.types
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCompanionInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberWithAllianceCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
    import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
    import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.monsters.Companion;
    import __AS3__.vec.*;

    public class RoleplayTeamFightersTooltipInformation 
    {

        private var _waitingCompanions:Dictionary;
        public var fighters:Vector.<Fighter>;
        public var nbWaves:uint;

        public function RoleplayTeamFightersTooltipInformation(pFightTeam:FightTeam)
        {
            var fightMemberInfo:FightTeamMemberInformations;
            var i:int;
            var fighter:Fighter;
            var _local_6:String;
            var _local_7:Monster;
            var _local_8:uint;
            var _local_9:String;
            var _local_10:uint;
            var _local_11:String;
            var _local_12:String;
            var _local_13:String;
            var _local_14:FightTeamMemberCompanionInformations;
            super();
            this.nbWaves = pFightTeam.teamInfos.nbWaves;
            this.fighters = new Vector.<Fighter>();
            var len:int = pFightTeam.teamInfos.teamMembers.length;
            i = 0;
            while (i < len)
            {
                fightMemberInfo = pFightTeam.teamInfos.teamMembers[i];
                fighter = null;
                switch (true)
                {
                    case (fightMemberInfo is FightTeamMemberCharacterInformations):
                        if ((fightMemberInfo is FightTeamMemberWithAllianceCharacterInformations))
                        {
                            _local_6 = (fightMemberInfo as FightTeamMemberWithAllianceCharacterInformations).allianceInfos.allianceTag;
                        };
                        fighter = new Fighter(fightMemberInfo.id, (fightMemberInfo as FightTeamMemberCharacterInformations).name, (fightMemberInfo as FightTeamMemberCharacterInformations).level, _local_6);
                        break;
                    case (fightMemberInfo is FightTeamMemberMonsterInformations):
                        _local_7 = Monster.getMonsterById((fightMemberInfo as FightTeamMemberMonsterInformations).monsterId);
                        _local_8 = _local_7.getMonsterGrade((fightMemberInfo as FightTeamMemberMonsterInformations).grade).level;
                        _local_9 = _local_7.name;
                        fighter = new Fighter(fightMemberInfo.id, _local_9, _local_8);
                        break;
                    case (fightMemberInfo is FightTeamMemberTaxCollectorInformations):
                        _local_10 = (fightMemberInfo as FightTeamMemberTaxCollectorInformations).level;
                        _local_11 = TaxCollectorFirstname.getTaxCollectorFirstnameById((fightMemberInfo as FightTeamMemberTaxCollectorInformations).firstNameId).firstname;
                        _local_12 = TaxCollectorName.getTaxCollectorNameById((fightMemberInfo as FightTeamMemberTaxCollectorInformations).lastNameId).name;
                        _local_13 = ((_local_11 + " ") + _local_12);
                        fighter = new Fighter(fightMemberInfo.id, _local_13, _local_10);
                        break;
                    case (fightMemberInfo is FightTeamMemberCompanionInformations):
                        _local_14 = (fightMemberInfo as FightTeamMemberCompanionInformations);
                        if ((((((this.fighters.length > 0)) && ((i > 0)))) && ((this.fighters[(i - 1)].id == _local_14.masterId))))
                        {
                            fighter = this.getCompanionFighter(this.fighters[(i - 1)], _local_14.id, _local_14.companionId);
                        }
                        else
                        {
                            if (!(this._waitingCompanions))
                            {
                                this._waitingCompanions = new Dictionary();
                            };
                            this._waitingCompanions[_local_14.masterId] = {
                                "id":_local_14.id,
                                "genericId":_local_14.companionId
                            };
                        };
                        break;
                };
                if (fighter)
                {
                    this.fighters.push(fighter);
                    if (((this._waitingCompanions) && (this._waitingCompanions[fighter.id])))
                    {
                        this.fighters.push(this.getCompanionFighter(fighter, this._waitingCompanions[fighter.id].id, this._waitingCompanions[fighter.id].genericId));
                        delete this._waitingCompanions[fighter.id];
                    };
                };
                i++;
            };
        }

        private function getCompanionFighter(pFighter:Fighter, pCompanionId:int, pCompanionGenericId:int):Fighter
        {
            return (new Fighter(pCompanionId, I18n.getUiText("ui.common.belonging", [Companion.getCompanionById(pCompanionGenericId).name, pFighter.name]), pFighter.level, pFighter.allianceTagName));
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.types

class Fighter 
{

    /*private*/ var _id:int;
    public var allianceTagName:String;
    public var name:String;
    public var level:uint;

    public function Fighter(pId:int, pName:String, pLevel:uint, pAllianceTagName:String=null)
    {
        this._id = pId;
        this.name = pName;
        this.level = pLevel;
        this.allianceTagName = pAllianceTagName;
    }

    public function get allianceTag():String
    {
        return (((this.allianceTagName) ? (("[" + this.allianceTagName) + "]") : null));
    }

    public function get id():int
    {
        return (this._id);
    }


}

