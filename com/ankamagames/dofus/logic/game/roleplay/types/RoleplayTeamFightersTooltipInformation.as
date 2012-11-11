package com.ankamagames.dofus.logic.game.roleplay.types
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;

    public class RoleplayTeamFightersTooltipInformation extends Object
    {
        public var fighters:Vector.<Fighter>;

        public function RoleplayTeamFightersTooltipInformation(param1:FightTeam)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this.fighters = new Vector.<Fighter>;
            for each (_loc_2 in param1.teamInfos.teamMembers)
            {
                
                switch(true)
                {
                    case _loc_2 is FightTeamMemberCharacterInformations:
                    {
                        _loc_3 = new Fighter((_loc_2 as FightTeamMemberCharacterInformations).name, (_loc_2 as FightTeamMemberCharacterInformations).level);
                        break;
                    }
                    case _loc_2 is FightTeamMemberMonsterInformations:
                    {
                        _loc_4 = Monster.getMonsterById((_loc_2 as FightTeamMemberMonsterInformations).monsterId);
                        _loc_5 = _loc_4.getMonsterGrade((_loc_2 as FightTeamMemberMonsterInformations).grade).level;
                        _loc_6 = _loc_4.name;
                        _loc_3 = new Fighter(_loc_6, _loc_5);
                        break;
                    }
                    case _loc_2 is FightTeamMemberTaxCollectorInformations:
                    {
                        _loc_7 = (_loc_2 as FightTeamMemberTaxCollectorInformations).level;
                        _loc_8 = TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc_2 as FightTeamMemberTaxCollectorInformations).firstNameId).firstname;
                        _loc_9 = TaxCollectorName.getTaxCollectorNameById((_loc_2 as FightTeamMemberTaxCollectorInformations).lastNameId).name;
                        _loc_10 = _loc_8 + " " + _loc_9;
                        _loc_3 = new Fighter(_loc_10, _loc_7);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.fighters.push(_loc_3);
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.dofus.datacenter.monsters.*;

import com.ankamagames.dofus.datacenter.npcs.*;

import com.ankamagames.dofus.network.types.game.context.fight.*;

class Fighter extends Object
{
    public var name:String;
    public var level:uint;

    function Fighter(param1:String, param2:uint)
    {
        this.name = param1;
        this.level = param2;
        return;
    }// end function

}

