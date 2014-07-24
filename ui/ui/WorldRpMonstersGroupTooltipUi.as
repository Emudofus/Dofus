package ui
{
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.DataApi;
   import d2api.PartyApi;
   import d2api.PlayedCharacterApi;
   import d2api.SystemApi;
   import d2api.SocialApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2data.Monster;
   import d2data.PartyMemberWrapper;
   import d2network.GuildMember;
   import d2data.PrismSubAreaWrapper;
   import d2network.GroupMonsterStaticInformations;
   import utils.FormulaHandler;
   import d2network.GameRolePlayGroupMonsterWaveInformations;
   import d2network.MonsterInGroupLightInformations;
   import d2network.GroupMonsterStaticInformationsWithAlternatives;
   
   public class WorldRpMonstersGroupTooltipUi extends Object
   {
      
      public function WorldRpMonstersGroupTooltipUi() {
         super();
      }
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var dataApi:DataApi;
      
      public var partyApi:PartyApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var sysApi:SystemApi;
      
      public var socialApi:SocialApi;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_wave:GraphicContainer;
      
      public var ctr_xp:GraphicContainer;
      
      public var ctr_malusDropArena:GraphicContainer;
      
      public var ctr_back:GraphicContainer;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_starsParent:GraphicContainer;
      
      public var ctr_stars:GraphicContainer;
      
      public var ctr_groupOptimal:GraphicContainer;
      
      public var ctr_malusDrop:GraphicContainer;
      
      public var ctr_level:GraphicContainer;
      
      public var ctr_separatorMalus:GraphicContainer;
      
      public var ctr_separatorXp:GraphicContainer;
      
      public var lbl_level:Label;
      
      public var lbl_monsterList:Label;
      
      public var lbl_disabledMonsterList:Label;
      
      public var lbl_nbWaves:Label;
      
      public var lbl_monsterXp:Label;
      
      public var lbl_groupOptimal:Label;
      
      public var lbl_malusDrop:Label;
      
      public var tx_wave:Texture;
      
      public var star00:Texture;
      
      public var star01:Texture;
      
      public var star02:Texture;
      
      public var star03:Texture;
      
      public var star04:Texture;
      
      public var star10:Texture;
      
      public var star11:Texture;
      
      public var star12:Texture;
      
      public var star13:Texture;
      
      public var star14:Texture;
      
      public var star20:Texture;
      
      public var star21:Texture;
      
      public var star22:Texture;
      
      public var star23:Texture;
      
      public var star24:Texture;
      
      public function main(oParam:Object = null) : void {
         var i:* = 0;
         var monster:Monster = null;
         var member:PartyMemberWrapper = null;
         var wisdom:* = 0;
         var pg:GuildMember = null;
         var xpAlliancePrismBonus:* = NaN;
         var m:Object = null;
         var ageBonus:* = 0;
         var color:* = 0;
         var numStars:* = 0;
         var nbCompanions:* = 0;
         var prismInfo:PrismSubAreaWrapper = null;
         var waves:Object = null;
         var waveInfo:GroupMonsterStaticInformations = null;
         var waveXpSolo:* = NaN;
         var waveXpGroup:* = NaN;
         var waveData:MonstersGroupData = null;
         var malus:* = 0;
         var data:Object = oParam.data;
         var hasStars:Boolean = !(data.ageBonus == -1);
         this.ctr_back.width = 1;
         this.ctr_wave.height = 1;
         this.lbl_monsterList.width = 1;
         this.lbl_monsterXp.width = 1;
         this.lbl_disabledMonsterList.width = 1;
         this.ctr_level.width = 1;
         this.ctr_groupOptimal.width = 1;
         this.ctr_malusDrop.width = 1;
         this.ctr_separatorMalus.width = 1;
         this.ctr_separatorXp.width = 1;
         this.ctr_malusDropArena.height = 1;
         this.star00.visible = false;
         this.star01.visible = false;
         this.star02.visible = false;
         this.star03.visible = false;
         this.star04.visible = false;
         this.star10.visible = false;
         this.star11.visible = false;
         this.star12.visible = false;
         this.star13.visible = false;
         this.star14.visible = false;
         this.star20.visible = false;
         this.star21.visible = false;
         this.star22.visible = false;
         this.star23.visible = false;
         this.star24.visible = false;
         if(data.alignmentSide == 1)
         {
            this.lbl_monsterList.cssClass = "bonta";
            this.lbl_disabledMonsterList.cssClass = "bonta";
         }
         else if(data.alignmentSide == 2)
         {
            this.lbl_monsterList.cssClass = "brakmar";
            this.lbl_disabledMonsterList.cssClass = "brakmar";
         }
         else
         {
            this.lbl_monsterList.cssClass = "center";
            this.lbl_disabledMonsterList.cssClass = "center";
         }
         
         if(hasStars)
         {
            this.ctr_starsParent.visible = true;
            this.ctr_starsParent.height = 15;
            ageBonus = data.ageBonus;
            if(ageBonus == -1)
            {
               ageBonus = 0;
            }
            if(ageBonus > 100)
            {
               color = 2;
               ageBonus = ageBonus - 100;
            }
            else
            {
               color = 1;
            }
            numStars = Math.round(ageBonus / 20);
            i = 0;
            while(i < numStars)
            {
               this["star" + color + "" + i].visible = true;
               i++;
            }
            i = i;
            while(i < 5)
            {
               this["star" + (color - 1) + "" + i].visible = true;
               i++;
            }
         }
         else
         {
            this.hideBloc(this.ctr_starsParent);
         }
         var partyMembers:Object = this.partyApi.getPartyMembers();
         var currentPlayerInfo:Object = this.playerApi.getPlayedCharacterInfo();
         var currentPlayerCharac:Object = this.playerApi.characteristics();
         var formulaGroupMembers:Array = new Array();
         if((partyMembers.length == 0) && (this.playerApi.hasCompanion()))
         {
            formulaGroupMembers.push(FormulaHandler.createGroupMember(this.playerApi.getPlayedCharacterInfo().level));
            formulaGroupMembers.push(FormulaHandler.createGroupMember(this.playerApi.getPlayedCharacterInfo().level,true));
         }
         else
         {
            for each(member in partyMembers)
            {
               formulaGroupMembers.push(FormulaHandler.createGroupMember(member.level));
               nbCompanions = member.companions.length;
               i = 0;
               while(i < nbCompanions)
               {
                  formulaGroupMembers.push(FormulaHandler.createGroupMember(member.level,true));
                  i++;
               }
            }
         }
         wisdom = currentPlayerCharac.wisdom.base + currentPlayerCharac.wisdom.objectsAndMountBonus + currentPlayerCharac.wisdom.alignGiftBonus + currentPlayerCharac.wisdom.contextModif;
         pg = this.getPlayerGuild(currentPlayerInfo.id);
         if(this.socialApi.hasAlliance())
         {
            prismInfo = this.socialApi.getPrismSubAreaById(this.playerApi.currentSubArea().id);
            if((this.socialApi.hasAlliance() && prismInfo) && (!(prismInfo.mapId == -1)) && ((!prismInfo.alliance) || (prismInfo.alliance && prismInfo.alliance.allianceId == this.socialApi.getAlliance().allianceId)))
            {
               xpAlliancePrismBonus = 25;
            }
         }
         var playerData:* = FormulaHandler.createPlayerData(currentPlayerInfo.level,wisdom,this.playerApi.getExperienceBonusPercent(),(!(this.playerApi.getMount() == null)) && (this.playerApi.isRidding())?this.playerApi.getMount().xpRatio:0,!(pg == null)?pg.experienceGivenPercent:0,xpAlliancePrismBonus);
         var groupData:MonstersGroupData = this.getMonstersGroupData(data.staticInfos,playerData,formulaGroupMembers,data.ageBonus);
         this.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + groupData.level;
         var textList:String = "";
         var textListDisabled:String = "";
         var grp:Array = groupData.group;
         for each(m in grp)
         {
            if(m.visible)
            {
               monster = this.dataApi.getMonsterFromId(m.monsterId);
               textList = textList + ("\n" + (monster.isMiniBoss?"<b>":"") + monster.name + " (" + m.level + ")" + (monster.isMiniBoss?"</b>":""));
            }
            else
            {
               monster = this.dataApi.getMonsterFromId(m.monsterId);
               textListDisabled = textListDisabled + ("\n" + monster.name + " (" + m.level + ")");
            }
         }
         if(textList)
         {
            textList = textList.substr(1);
         }
         var xpText:String = "";
         var inParty:Boolean = formulaGroupMembers.length > 0;
         var grpgmwi:GameRolePlayGroupMonsterWaveInformations = data as GameRolePlayGroupMonsterWaveInformations;
         if(grpgmwi)
         {
            this.ctr_wave.visible = true;
            this.lbl_nbWaves.text = "x " + (grpgmwi.nbWaves + 1);
            this.lbl_nbWaves.fullWidth();
            this.ctr_wave.height = this.lbl_nbWaves.height;
            waves = grpgmwi.alternatives;
            waveXpSolo = groupData.xpSolo;
            waveXpGroup = groupData.xpGroup;
            for each(waveInfo in waves)
            {
               waveData = this.getMonstersGroupData(waveInfo,playerData,formulaGroupMembers,data.ageBonus);
               waveXpSolo = waveXpSolo + waveData.xpSolo;
               waveXpGroup = waveXpGroup + waveData.xpGroup;
            }
            xpText = xpText + this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(waveXpSolo));
            if(inParty)
            {
               xpText = xpText + ("\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(waveXpGroup)));
            }
         }
         else
         {
            this.hideBloc(this.ctr_wave);
            xpText = xpText + this.uiApi.getText("ui.tooltip.monsterXpAlone",this.utilApi.formateIntToString(groupData.xpSolo));
            if(inParty)
            {
               xpText = xpText + ("\n" + this.uiApi.getText("ui.tooltip.monsterXpParty",this.utilApi.formateIntToString(groupData.xpGroup)));
            }
         }
         this.lbl_monsterXp.text = xpText;
         this.lbl_monsterList.text = textList;
         this.lbl_disabledMonsterList.visible = !(textListDisabled == "");
         this.lbl_disabledMonsterList.text = textListDisabled;
         this.lbl_monsterList.fullWidth();
         this.lbl_disabledMonsterList.fullWidth();
         this.lbl_monsterXp.fullWidth();
         this.lbl_level.fullWidth();
         if((!(data.lootShare == null)) && (data.lootShare > 0))
         {
            malus = FormulaHandler.getArenaMalusDrop(data.lootShare,partyMembers.length);
            if(malus > 0)
            {
               this.ctr_separatorMalus.visible = true;
               this.lbl_groupOptimal.text = this.uiApi.getText("ui.tooltip.maxMemberParty",data.lootShare);
               this.lbl_groupOptimal.fullWidth();
               this.lbl_malusDrop.text = this.uiApi.getText("ui.tooltip.arenaMalus",malus);
               this.lbl_malusDrop.fullWidth();
               this.ctr_malusDropArena.visible = true;
            }
            else
            {
               this.ctr_separatorMalus.visible = false;
               this.hideBloc(this.ctr_malusDropArena);
            }
         }
         else
         {
            this.ctr_separatorMalus.visible = false;
            this.hideBloc(this.ctr_malusDropArena);
         }
         var maxWidth:int = this.getMaxWidth();
         this.lbl_monsterList.width = maxWidth;
         this.lbl_monsterXp.width = maxWidth;
         this.lbl_disabledMonsterList.width = maxWidth;
         this.ctr_xp.width = maxWidth;
         this.ctr_level.width = maxWidth;
         this.ctr_starsParent.width = maxWidth;
         this.ctr_main.width = maxWidth;
         this.ctr_groupOptimal.width = maxWidth;
         this.ctr_malusDrop.width = maxWidth;
         this.ctr_malusDropArena.width = maxWidth;
         this.ctr_separatorMalus.width = maxWidth;
         this.ctr_separatorXp.width = maxWidth;
         if(this.ctr_wave.visible)
         {
            this.tx_wave.x = maxWidth / 2 - (this.tx_wave.width + this.lbl_nbWaves.width) / 2;
            this.lbl_nbWaves.x = this.tx_wave.x + this.tx_wave.width;
         }
         this.ctr_back.width = maxWidth + 8;
         if(this.ctr_malusDropArena.visible)
         {
            this.ctr_malusDropArena.height = this.lbl_groupOptimal.textHeight + this.lbl_malusDrop.textHeight;
         }
         this.uiApi.me().render();
         var firstInit:Boolean = this.ctr_back.height == 0;
         var backHeight:Number = this.ctr_main.height;
         var th:int = this.ctr_separatorXp.y + this.lbl_monsterList.height + this.lbl_disabledMonsterList.height - (this.lbl_disabledMonsterList.visible?25:0);
         if(backHeight < th)
         {
            backHeight = th;
         }
         if(firstInit)
         {
            if(inParty)
            {
               backHeight = backHeight + 21;
            }
            if((hasStars) && (this.ctr_wave.visible))
            {
               backHeight = backHeight + 13;
            }
            else if(!this.ctr_wave.visible)
            {
               backHeight = backHeight - (hasStars?14:28);
            }
            
         }
         if((!firstInit) && (this.lbl_disabledMonsterList.visible))
         {
            backHeight = backHeight + 8;
         }
         this.ctr_back.height = backHeight;
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset,true,oParam.data.disposition.cellId);
      }
      
      private function getMaxWidth() : int {
         var maxValue:int = 0;
         if((this.ctr_stars.visible) && (this.ctr_stars.width > this.lbl_monsterList.width) && (this.ctr_stars.width > this.lbl_monsterXp.width) && (this.ctr_stars.width > this.lbl_disabledMonsterList.width) && (this.ctr_stars.width > this.lbl_level.width))
         {
            maxValue = this.ctr_stars.width;
         }
         else if((this.lbl_level.width > this.ctr_stars.width) && (this.lbl_level.width > this.lbl_monsterList.width) && (this.lbl_level.width > this.lbl_monsterXp.width) && (this.lbl_level.width > this.lbl_disabledMonsterList.width))
         {
            maxValue = this.lbl_level.width;
         }
         else if((this.lbl_groupOptimal.visible) && (this.lbl_groupOptimal.width > this.lbl_monsterList.width) && (this.lbl_groupOptimal.width > this.lbl_monsterXp.width) && (this.lbl_groupOptimal.width > this.lbl_disabledMonsterList.width) && (this.lbl_groupOptimal.width > this.lbl_level.width))
         {
            maxValue = this.lbl_groupOptimal.width;
         }
         else if((this.lbl_malusDrop.visible) && (this.lbl_malusDrop.width > this.lbl_monsterList.width) && (this.lbl_malusDrop.width > this.lbl_monsterXp.width) && (this.lbl_malusDrop.width > this.lbl_disabledMonsterList.width) && (this.lbl_malusDrop.width > this.lbl_level.width))
         {
            maxValue = this.lbl_malusDrop.width;
         }
         else if((this.lbl_disabledMonsterList.visible) && (this.lbl_disabledMonsterList.width > this.lbl_monsterXp.width) && (this.lbl_disabledMonsterList.width >= this.lbl_disabledMonsterList.width) && (this.lbl_disabledMonsterList.width > this.lbl_monsterList.width) && (this.lbl_disabledMonsterList.width >= this.ctr_stars.width) && (this.lbl_disabledMonsterList.width > this.lbl_level.width))
         {
            maxValue = this.lbl_disabledMonsterList.width;
         }
         else if((this.lbl_monsterXp.visible) && (this.lbl_monsterXp.width > this.ctr_stars.width) && (this.lbl_monsterXp.width > this.lbl_monsterList.width) && (this.lbl_monsterXp.width > this.lbl_disabledMonsterList.width) && (this.lbl_monsterXp.width > this.lbl_level.width))
         {
            maxValue = this.lbl_monsterXp.width;
         }
         else
         {
            maxValue = this.lbl_monsterList.width;
         }
         
         
         
         
         
         return maxValue;
      }
      
      private function hideBloc(ctr:GraphicContainer) : void {
         ctr.height = 0;
         ctr.visible = false;
      }
      
      public function getRealMonsterGrade(realGroup:Array, creatureGenericId:int) : int {
         var mob:MonsterInGroupLightInformations = null;
         if(realGroup == null)
         {
            return 0;
         }
         for each(mob in realGroup)
         {
            if(mob.creatureGenericId == creatureGenericId)
            {
               realGroup.splice(realGroup.indexOf(mob),1);
               return mob.grade;
            }
         }
         return -1;
      }
      
      private function xtremAdvancedSortMonster(monsterA:Object, monsterB:Object) : Number {
         var result:int = 0;
         if(monsterA.monsterId == monsterB.monsterId)
         {
            if(monsterA.level > monsterB.level)
            {
               result = -1;
            }
            else if(monsterA.level < monsterB.level)
            {
               result = 1;
            }
            else
            {
               result = 0;
            }
            
         }
         else if(monsterA.maxLevel > monsterB.maxLevel)
         {
            result = -1;
         }
         else if(monsterA.maxLevel < monsterB.maxLevel)
         {
            result = 1;
         }
         else if(monsterA.totalLevel > monsterB.totalLevel)
         {
            result = -1;
         }
         else if(monsterA.totalLevel < monsterB.totalLevel)
         {
            result = 1;
         }
         else
         {
            result = 0;
         }
         
         
         
         
         return result;
      }
      
      private function truncate(val:Number) : int {
         var multiplier:uint = Math.pow(10,0);
         var truncatedVal:Number = val * multiplier;
         return int(truncatedVal) / multiplier;
      }
      
      private function getPlayerGuild(idPlayer:int) : GuildMember {
         var mem:GuildMember = null;
         for each(mem in this.socialApi.getGuildMembers())
         {
            if(mem.id == idPlayer)
            {
               return mem;
            }
         }
         return null;
      }
      
      private function getMonstersGroupData(pStaticInfos:GroupMonsterStaticInformations, pPlayerData:*, pGroupMembersData:Array, pAgeBonus:int) : MonstersGroupData {
         var groupData:MonstersGroupData = null;
         var monsterData:* = undefined;
         var member:PartyMemberWrapper = null;
         var monster:Monster = null;
         var lvlMonster:* = 0;
         var realMonstersList:Array = null;
         var formulaMobs:Array = null;
         var m:Object = null;
         var members:* = 0;
         var realMonstersListObject:Object = null;
         var realGroup:Object = null;
         var val:Object = null;
         var monstersLevel:Array = new Array();
         var maxMonsterLevel:Array = new Array();
         var mainCreatureLvl:int = this.dataApi.getMonsterFromId(pStaticInfos.mainCreatureLightInfos.creatureGenericId).grades[pStaticInfos.mainCreatureLightInfos.grade - 1].level;
         monstersLevel[pStaticInfos.mainCreatureLightInfos.creatureGenericId] = mainCreatureLvl;
         maxMonsterLevel[pStaticInfos.mainCreatureLightInfos.creatureGenericId] = mainCreatureLvl;
         var partyMembers:Object = this.partyApi.getPartyMembers();
         for each(monsterData in pStaticInfos.underlings)
         {
            monster = this.dataApi.getMonsterFromId(monsterData.creatureGenericId);
            lvlMonster = monster.grades[monsterData.grade - 1].level;
            if((monstersLevel[monsterData.creatureGenericId]) && (monstersLevel[monsterData.creatureGenericId] > 0))
            {
               monstersLevel[monsterData.creatureGenericId] = monstersLevel[monsterData.creatureGenericId] + lvlMonster;
            }
            else
            {
               monstersLevel[monsterData.creatureGenericId] = lvlMonster;
            }
            if((maxMonsterLevel[monsterData.creatureGenericId]) && (maxMonsterLevel[monsterData.creatureGenericId] > 0))
            {
               if(maxMonsterLevel[monsterData.creatureGenericId] < lvlMonster)
               {
                  maxMonsterLevel[monsterData.creatureGenericId] = lvlMonster;
               }
            }
            else
            {
               maxMonsterLevel[monsterData.creatureGenericId] = lvlMonster;
            }
         }
         if(pStaticInfos is GroupMonsterStaticInformationsWithAlternatives)
         {
            realMonstersList = new Array();
            members = partyMembers.length;
            if((members == 0) && (this.playerApi.hasCompanion()))
            {
               members = 2;
            }
            else
            {
               for each(member in partyMembers)
               {
                  members = members + member.companions.length;
               }
            }
            for each(realGroup in (pStaticInfos as GroupMonsterStaticInformationsWithAlternatives).alternatives)
            {
               if((realMonstersListObject == null) || (realGroup.playerCount <= members))
               {
                  realMonstersListObject = realGroup;
               }
            }
            for each(val in realMonstersListObject.monsters)
            {
               realMonstersList.push(val);
            }
         }
         var grp:Array = [];
         var m1:Monster = this.dataApi.getMonsterFromId(pStaticInfos.mainCreatureLightInfos.creatureGenericId);
         var realMonsterGrade:int = this.getRealMonsterGrade(realMonstersList,pStaticInfos.mainCreatureLightInfos.creatureGenericId);
         var totalLevel:uint = realMonsterGrade <= 0?m1.grades[pStaticInfos.mainCreatureLightInfos.grade - 1].level:m1.grades[realMonsterGrade - 1].level;
         grp.push(
            {
               "monsterId":pStaticInfos.mainCreatureLightInfos.creatureGenericId,
               "level":totalLevel,
               "gradeXp":(realMonsterGrade <= 0?m1.grades[pStaticInfos.mainCreatureLightInfos.grade - 1].gradeXp:m1.grades[realMonsterGrade - 1].gradeXp),
               "totalLevel":monstersLevel[pStaticInfos.mainCreatureLightInfos.creatureGenericId],
               "maxLevel":maxMonsterLevel[pStaticInfos.mainCreatureLightInfos.creatureGenericId],
               "visible":realMonsterGrade >= 0
            });
         for each(monsterData in pStaticInfos.underlings)
         {
            m1 = this.dataApi.getMonsterFromId(monsterData.creatureGenericId);
            realMonsterGrade = this.getRealMonsterGrade(realMonstersList,monsterData.creatureGenericId);
            lvlMonster = realMonsterGrade <= 0?m1.grades[monsterData.grade - 1].level:m1.grades[realMonsterGrade - 1].level;
            if(realMonsterGrade >= 0)
            {
               totalLevel = totalLevel + lvlMonster;
            }
            grp.push(
               {
                  "monsterId":monsterData.creatureGenericId,
                  "level":lvlMonster,
                  "gradeXp":(realMonsterGrade <= 0?m1.grades[monsterData.grade - 1].gradeXp:m1.grades[realMonsterGrade - 1].gradeXp),
                  "totalLevel":monstersLevel[monsterData.creatureGenericId],
                  "maxLevel":maxMonsterLevel[monsterData.creatureGenericId],
                  "visible":realMonsterGrade >= 0
               });
         }
         grp.sort(this.xtremAdvancedSortMonster);
         formulaMobs = new Array();
         for each(m in grp)
         {
            if(m.visible)
            {
               formulaMobs.push(FormulaHandler.createMonsterData(m.level,m.gradeXp));
            }
         }
         FormulaHandler.getInstance().initXpFormula(pPlayerData,formulaMobs,pGroupMembersData,pAgeBonus);
         groupData = new MonstersGroupData(totalLevel,grp,FormulaHandler.getInstance().xpSolo,FormulaHandler.getInstance().xpGroup);
         return groupData;
      }
      
      public function unload() : void {
      }
   }
}
class MonstersGroupData extends Object
{
   
   function MonstersGroupData(pLevel:int, pGroup:Array, pXpSolo:Number, pXpGroup:Number) {
      super();
      this._level = pLevel;
      this._group = pGroup;
      this._xpSolo = pXpSolo;
      this._xpGroup = pXpGroup;
   }
   
   private var _level:int;
   
   private var _group:Array;
   
   private var _xpSolo:Number;
   
   private var _xpGroup:Number;
   
   public function get level() : int {
      return this._level;
   }
   
   public function get group() : Array {
      return this._group;
   }
   
   public function get xpSolo() : Number {
      return this._xpSolo;
   }
   
   public function get xpGroup() : Number {
      return this._xpGroup;
   }
}
