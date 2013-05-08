package com.ankamagames.dofus.logic.game.roleplay.types
{
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;


   public class RoleplayTeamFightersTooltipInformation extends Object
   {
         

      public function RoleplayTeamFightersTooltipInformation(pFightTeam:FightTeam) {
         var fighter:FightTeamMemberInformations = null;
         var newFighter:Fighter = null;
         var monster:Monster = null;
         var monsterLevel:uint = 0;
         var monsterName:String = null;
         var taxCollectorLevel:uint = 0;
         var firstName:String = null;
         var lastName:String = null;
         var taxCollectorName:String = null;
         super();
         this.fighters=new Vector.<Fighter>();
         for each (fighter in pFightTeam.teamInfos.teamMembers)
         {
            switch(true)
            {
               case fighter is FightTeamMemberCharacterInformations:
                  newFighter=new Fighter((fighter as FightTeamMemberCharacterInformations).name,(fighter as FightTeamMemberCharacterInformations).level);
                  break;
               case fighter is FightTeamMemberMonsterInformations:
                  monster=Monster.getMonsterById((fighter as FightTeamMemberMonsterInformations).monsterId);
                  monsterLevel=monster.getMonsterGrade((fighter as FightTeamMemberMonsterInformations).grade).level;
                  monsterName=monster.name;
                  newFighter=new Fighter(monsterName,monsterLevel);
                  break;
               case fighter is FightTeamMemberTaxCollectorInformations:
                  taxCollectorLevel=(fighter as FightTeamMemberTaxCollectorInformations).level;
                  firstName=TaxCollectorFirstname.getTaxCollectorFirstnameById((fighter as FightTeamMemberTaxCollectorInformations).firstNameId).firstname;
                  lastName=TaxCollectorName.getTaxCollectorNameById((fighter as FightTeamMemberTaxCollectorInformations).lastNameId).name;
                  taxCollectorName=firstName+" "+lastName;
                  newFighter=new Fighter(taxCollectorName,taxCollectorLevel);
                  break;
            }
            this.fighters.push(newFighter);
         }
      }



      public var fighters:Vector.<Fighter>;
   }

}



   class Fighter extends Object
   {
         

      function Fighter(pName:String, pLevel:uint) {
         super();
         this.name=pName;
         this.level=pLevel;
      }



      public var name:String;

      public var level:uint;
   }
