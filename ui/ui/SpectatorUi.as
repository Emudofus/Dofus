package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.RoleplayApi;
   import d2api.ContextMenuApi;
   import d2api.TimeApi;
   import d2api.DataApi;
   import d2api.SocialApi;
   import d2api.TooltipApi;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2components.Label;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import flash.events.TimerEvent;
   import d2network.GameFightFighterCompanionLightInformations;
   import d2network.GameFightFighterMonsterLightInformations;
   import d2network.GameFightFighterTaxCollectorLightInformations;
   import d2network.GameFightFighterNamedLightInformations;
   import d2enums.FightTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.AlignementSideEnum;
   import d2enums.TeamTypeEnum;
   import d2components.Texture;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   
   public class SpectatorUi extends Object
   {
      
      public function SpectatorUi() {
         this._fights = new Array();
         this._fightersNameById = new Dictionary(true);
         this._iconsRight = new Array();
         this._iconsLeft = new Array();
         this._initialDurations = new Dictionary(true);
         this._fightsRef = new Dictionary();
         this._fightsRefInverse = new Dictionary();
         this._compsTxVip = new Dictionary(true);
         this._compsTxFightType = new Dictionary(true);
         super();
      }
      
      public static const ORDER_NUMBER:int = 1;
      
      public static const ORDER_LEVEL:int = 2;
      
      public static const ORDER_DURATION:int = 3;
      
      public static const ORDER_VIP:int = 4;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var roleplayApi:RoleplayApi;
      
      public var contextMenuApi:ContextMenuApi;
      
      public var timeApi:TimeApi;
      
      public var dataApi:DataApi;
      
      public var socialApi:SocialApi;
      
      public var contextMod:Object;
      
      public var tooltipApi:TooltipApi;
      
      private var _selectedFight:Object;
      
      private var _fights:Array;
      
      private var _fightersNameById:Dictionary;
      
      private var _timerTest:Timer;
      
      private var _iconsRight:Array;
      
      private var _iconsLeft:Array;
      
      private var _initialDurations:Dictionary;
      
      private var _fightsRef:Dictionary;
      
      private var _fightsRefInverse:Dictionary;
      
      private var _compsTxVip:Dictionary;
      
      private var _compsTxFightType:Dictionary;
      
      private var _timerFights:Timer;
      
      private var _timerStart:Number;
      
      private var _timerTick:Number;
      
      private var _constHeads:String;
      
      private var _constAlignUri:String;
      
      private var _currentSort:int = 4;
      
      public var mainCtr:GraphicContainer;
      
      public var btn_spectate:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var gd_fights:Grid;
      
      public var btn_orderNumberPlayers:ButtonContainer;
      
      public var btn_orderLevel:ButtonContainer;
      
      public var btn_orderDuration:ButtonContainer;
      
      public var btn_orderVip:ButtonContainer;
      
      public var lbl_levelRight:Label;
      
      public var lbl_levelLeft:Label;
      
      public var lbl_wavesRight:Label;
      
      public var lbl_wavesLeft:Label;
      
      public var lbl_attackersName:Label;
      
      public var lbl_defendersName:Label;
      
      public var gd_rightTeam:Grid;
      
      public var gd_leftTeam:Grid;
      
      public var ctr_iconsRight:GraphicContainer;
      
      public var ctr_iconsLeft:GraphicContainer;
      
      public var btn_fightRight:ButtonContainer;
      
      public var btn_fightLeft:ButtonContainer;
      
      public function main(pFights:Object) : void {
         this.btn_fightRight.soundId = SoundEnum.OK_BUTTON;
         this.btn_fightLeft.soundId = SoundEnum.OK_BUTTON;
         this.btn_spectate.soundId = SoundEnum.OK_BUTTON;
         this.sysApi.addHook(MapRunningFightDetails,this.onMapRunningFightDetails);
         this.sysApi.addHook(MapFightCount,this.onMapFightCount);
         this.sysApi.addHook(MapRunningFightList,this.onMapRunningFightList);
         this.sysApi.addHook(GameRolePlayRemoveFight,this.onMapRemoveFight);
         this.sysApi.addHook(GameFightOptionStateUpdate,this.onGameFightOptionStateUpdate);
         this.uiApi.addComponentHook(this.gd_fights,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._constHeads = this.uiApi.me().getConstant("heads");
         this._constAlignUri = this.uiApi.me().getConstant("fighterType_uri");
         this.gd_fights.autoSelectMode = 1;
         this.btn_spectate.disabled = true;
         this.btn_fightRight.disabled = true;
         this.btn_fightLeft.disabled = true;
         this._timerFights = new Timer(1000);
         this._timerTick = 0;
         this._timerStart = Math.floor(new Date().time / 1000);
         this._timerFights.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._timerFights.start();
         this.handleFights(pFights);
         this.updateFightsList();
      }
      
      public function unload() : void {
         this._timerFights.removeEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._timerFights.stop();
         this._fightsRef = null;
         this._fightsRefInverse = null;
         this.sysApi.sendAction(new StopToListenRunningFight());
      }
      
      public function updateFighterLine(data:*, components:*, selected:Boolean) : void {
         var name:String = null;
         var comp:GameFightFighterCompanionLightInformations = null;
         var genericName:String = null;
         var masterName:String = null;
         var monster:GameFightFighterMonsterLightInformations = null;
         var taxcoll:GameFightFighterTaxCollectorLightInformations = null;
         var player:GameFightFighterNamedLightInformations = null;
         if(data)
         {
            if(data is GameFightFighterCompanionLightInformations)
            {
               comp = data as GameFightFighterCompanionLightInformations;
               genericName = this.dataApi.getCompanion(comp.companionId).name;
               masterName = this._fightersNameById[comp.masterId];
               name = this.uiApi.getText("ui.common.belonging",genericName,masterName);
            }
            else if(data is GameFightFighterMonsterLightInformations)
            {
               monster = data as GameFightFighterMonsterLightInformations;
               name = this.dataApi.getMonsterFromId(monster.creatureGenericId).name;
            }
            else if(data is GameFightFighterTaxCollectorLightInformations)
            {
               taxcoll = data as GameFightFighterTaxCollectorLightInformations;
               name = this.dataApi.getTaxCollectorFirstname(taxcoll.firstNameId).firstname + " " + this.dataApi.getTaxCollectorName(taxcoll.lastNameId).name;
            }
            else if(data is GameFightFighterNamedLightInformations)
            {
               player = data as GameFightFighterNamedLightInformations;
               name = "{player," + player.name + "," + player.id + "::" + player.name + "}";
            }
            
            
            
            components.lbl_playerName.text = name;
            components.lbl_playerLevel.text = data.level;
            if(data.breed > 0)
            {
               components.tx_head.uri = this.uiApi.createUri(this._constHeads + "" + data.breed + "" + int(data.sex) + ".png");
               components.tx_head.visible = true;
            }
            else
            {
               components.tx_head.visible = false;
            }
         }
         else
         {
            components.lbl_playerName.text = "";
            components.lbl_playerLevel.text = "";
            components.tx_head.visible = false;
         }
      }
      
      public function updateFightLine(data:*, components:*, selected:Boolean) : void {
         var team1:Object = null;
         var team2:Object = null;
         var alignUris:Array = null;
         var alignUri:String = null;
         var team:Object = null;
         var duration:* = 0;
         delete this._fightsRef[this._fightsRefInverse[components]];
         this._fightsRefInverse[components] = data;
         this._fightsRef[data] = components;
         if(!this._compsTxFightType[components.tx_twoArrows.name])
         {
            this.uiApi.addComponentHook(components.tx_twoArrows,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_twoArrows,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsTxFightType[components.tx_twoArrows.name] = data;
         if(!this._compsTxVip[components.tx_iknowyou.name])
         {
            this.uiApi.addComponentHook(components.tx_iknowyou,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.tx_iknowyou,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsTxVip[components.tx_iknowyou.name] = data;
         if(data)
         {
            components.ctr_itemFight.visible = true;
            components.btn_itemFight.selected = selected;
            team1 = data.fightTeams[0];
            team2 = data.fightTeams[1];
            components.lbl_nbPLayerTeamOne.text = team1.teamMembersCount;
            components.lbl_nbPLayerTeamTwo.text = team2.teamMembersCount;
            if(data.type == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
            {
               components.tx_twoArrows.gotoAndStop = 2;
            }
            else if(data.type == FightTypeEnum.FIGHT_TYPE_CHALLENGE)
            {
               components.tx_twoArrows.gotoAndStop = 3;
            }
            else if((data.type == FightTypeEnum.FIGHT_TYPE_AGRESSION) || (data.type == FightTypeEnum.FIGHT_TYPE_PvT) || (data.type == FightTypeEnum.FIGHT_TYPE_PvPr) || (data.type == FightTypeEnum.FIGHT_TYPE_Koh))
            {
               components.tx_twoArrows.gotoAndStop = 4;
            }
            else
            {
               components.tx_twoArrows.gotoAndStop = 1;
            }
            
            
            alignUris = new Array();
            for each(team in data.fightTeams)
            {
               alignUri = this._constAlignUri;
               if(team.teamSide >= 0)
               {
                  switch(team.teamSide)
                  {
                     case AlignementSideEnum.ALIGNMENT_NEUTRAL:
                        alignUri = alignUri + "Neutre";
                        break;
                     case AlignementSideEnum.ALIGNMENT_ANGEL:
                        alignUri = alignUri + "Bonta";
                        break;
                     case AlignementSideEnum.ALIGNMENT_EVIL:
                        alignUri = alignUri + "Brakmar";
                        break;
                     case AlignementSideEnum.ALIGNMENT_MERCENARY:
                        alignUri = alignUri + "Seriane";
                        break;
                  }
               }
               else
               {
                  switch(team.teamTypeId)
                  {
                     case TeamTypeEnum.TEAM_TYPE_MONSTER:
                        alignUri = alignUri + "Monstre";
                        break;
                     case TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR:
                        alignUri = alignUri + "Perco";
                        break;
                     case TeamTypeEnum.TEAM_TYPE_PRISM:
                        alignUri = alignUri + "Alliance";
                        break;
                     default:
                        alignUri = alignUri + "Neutre";
                  }
               }
               alignUris.push(alignUri);
            }
            components.tx_alignTeamOne.uri = this.uiApi.createUri(alignUris[0] + "G");
            components.tx_alignTeamTwo.uri = this.uiApi.createUri(alignUris[1] + "D");
            components.tx_spectatorLocked.visible = data.spectatorLocked;
            components.lbl_averageLevel.text = data.averageLevel;
            if(team1.nbWaves > 0)
            {
               components.lbl_nbWaveTeamOne.text = team1.nbWaves;
               components.tx_waveTeamOne.visible = true;
            }
            else
            {
               components.lbl_nbWaveTeamOne.text = "";
               components.tx_waveTeamOne.visible = false;
            }
            if(team2.nbWaves > 0)
            {
               components.lbl_nbWaveTeamTwo.text = team2.nbWaves;
               components.tx_waveTeamTwo.visible = true;
            }
            else
            {
               components.lbl_nbWaveTeamTwo.text = "";
               components.tx_waveTeamTwo.visible = false;
            }
            components.tx_iknowyou.visible = true;
            if(data.iKnowYou == 1)
            {
               components.tx_iknowyou.gotoAndStop = 2;
               components.tx_iknowyou.visible = true;
            }
            else if(data.iKnowYou == 2)
            {
               components.tx_iknowyou.gotoAndStop = 3;
               components.tx_iknowyou.visible = true;
            }
            else if(data.iKnowYou == 3)
            {
               components.tx_iknowyou.gotoAndStop = 4;
               components.tx_iknowyou.visible = true;
            }
            else if(data.iKnowYou == 4)
            {
               components.tx_iknowyou.gotoAndStop = 5;
               components.tx_iknowyou.visible = true;
            }
            else
            {
               components.tx_iknowyou.visible = false;
            }
            
            
            
            if(data.start == 0)
            {
               components.lbl_timeStartFight.text = "-";
            }
            else
            {
               duration = this._timerStart - data.start;
               this._initialDurations[data.id] = duration >= -this._timerTick?duration:-this._timerTick;
               components.lbl_timeStartFight.text = this.timeApi.getShortDuration((this._initialDurations[data.id] + this._timerTick) * 1000);
            }
         }
         else
         {
            components.ctr_itemFight.visible = false;
            components.tx_alignTeamOne.uri = null;
            components.tx_alignTeamTwo.uri = null;
            components.lbl_nbPLayerTeamOne.text = "";
            components.lbl_nbPLayerTeamTwo.text = "";
            components.lbl_timeStartFight.text = "";
            components.lbl_averageLevel.text = "";
            components.btn_itemFight.selected = false;
         }
      }
      
      private function updateFightsList() : void {
         var selFightId:* = 0;
         var fight:Object = null;
         var sortedFights:Array = new Array();
         if(this._currentSort < 0)
         {
            if(this._currentSort == -ORDER_NUMBER)
            {
               this._fights.sortOn("fightersNumber",Array.NUMERIC | Array.DESCENDING);
            }
            else if(this._currentSort == -ORDER_LEVEL)
            {
               this._fights.sortOn("averageLevel",Array.NUMERIC | Array.DESCENDING);
            }
            else if(this._currentSort == -ORDER_DURATION)
            {
               this._fights.sortOn("start",Array.NUMERIC | Array.DESCENDING);
            }
            else
            {
               this._fights.sortOn("iKnowYou",Array.NUMERIC | Array.DESCENDING);
            }
            
            
         }
         else if(this._currentSort == ORDER_NUMBER)
         {
            this._fights.sortOn("fightersNumber",Array.NUMERIC);
         }
         else if(this._currentSort == ORDER_LEVEL)
         {
            this._fights.sortOn("averageLevel",Array.NUMERIC);
         }
         else if(this._currentSort == ORDER_DURATION)
         {
            this._fights.sortOn("start",Array.NUMERIC);
         }
         else
         {
            this._fights.sortOn("iKnowYou",Array.NUMERIC);
         }
         
         
         
         if(this.gd_fights.selectedItem)
         {
            selFightId = this.gd_fights.selectedItem.id;
         }
         this.gd_fights.dataProvider = this._fights;
         if(selFightId > 0)
         {
            for each(fight in this._fights)
            {
               if(fight.id == selFightId)
               {
                  this.gd_fights.selectedItem = fight;
                  return;
               }
            }
         }
      }
      
      private function refreshButtons(fightId:uint) : void {
         this.refreshSpectateButton(this._selectedFight.spectatorLocked);
         this.refreshJoinButton(0,this._selectedFight.fightTeamsOptions[0].isClosed);
         this.refreshJoinButton(1,this._selectedFight.fightTeamsOptions[1].isClosed);
      }
      
      private function refreshJoinButton(teamId:uint, isClosed:Boolean) : void {
         var btn:ButtonContainer = teamId == 0?this.btn_fightLeft:this.btn_fightRight;
         var fight:Object = this.roleplayApi.getFight(this._selectedFight.id);
         var otherTeamId:int = (teamId + 1) % 2;
         btn.disabled = (!(this._selectedFight.start == 0) || this._selectedFight.fightTeams[teamId].teamTypeId == TeamTypeEnum.TEAM_TYPE_MONSTER || this._selectedFight.fightTeams[teamId].teamTypeId == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR && !this._selectedFight.fightTeams[teamId].hasMyTaxCollector || this._selectedFight.fightTeams[otherTeamId].teamTypeId == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR && this._selectedFight.fightTeams[otherTeamId].hasMyTaxCollector || isClosed) || (fight == null) || (!fight);
      }
      
      private function refreshSpectateButton(spectatorLocked:Boolean) : void {
         this.btn_spectate.disabled = (!this.sysApi.hasRight()) && (spectatorLocked);
      }
      
      private function joinFight(pFightId:*) : void {
         this.sysApi.sendAction(new JoinAsSpectatorRequest(pFightId));
      }
      
      private function iconIndex(teamId:int, option:int) : int {
         if(teamId == 0)
         {
            if(this._iconsLeft[option] != null)
            {
               return option;
            }
         }
         else if(teamId == 1)
         {
            if(this._iconsRight[option] != null)
            {
               return option;
            }
         }
         
         return -1;
      }
      
      private function handleFights(fights:Object) : void {
         var fight:Object = null;
         var usableFight:Object = null;
         for each(fight in fights)
         {
            usableFight = 
               {
                  "id":fight.fightId,
                  "type":fight.fightType,
                  "start":fight.fightStart,
                  "spectatorLocked":fight.fightSpectatorLocked,
                  "fightTeams":fight.fightTeams,
                  "fightTeamsOptions":fight.fightTeamsOptions
               };
            usableFight.averageLevel = Math.round((fight.fightTeams[0].meanLevel * fight.fightTeams[0].teamMembersCount + fight.fightTeams[1].meanLevel * fight.fightTeams[1].teamMembersCount) / (fight.fightTeams[0].teamMembersCount + fight.fightTeams[1].teamMembersCount));
            usableFight.fightersNumber = fight.fightTeams[0].teamMembersCount + fight.fightTeams[1].teamMembersCount;
            if((fight.fightTeams[0].hasGroupMember) || (fight.fightTeams[1].hasGroupMember))
            {
               usableFight.iKnowYou = 1;
            }
            else if((fight.fightTeams[0].hasFriend) || (fight.fightTeams[1].hasFriend))
            {
               usableFight.iKnowYou = 2;
            }
            else if((fight.fightTeams[0].hasGuildMember) || (fight.fightTeams[1].hasGuildMember))
            {
               usableFight.iKnowYou = 3;
            }
            else if((fight.fightTeams[0].hasAllianceMember) || (fight.fightTeams[1].hasAllianceMember))
            {
               usableFight.iKnowYou = 4;
            }
            else
            {
               usableFight.iKnowYou = 5;
            }
            
            
            
            this._fights.push(usableFight);
         }
         this._fights.sortOn(["iKnowYou","id"],[Array.NUMERIC,Array.NUMERIC]);
      }
      
      private function updateOptions(teamId:int, option:int, state:Boolean) : void {
         var icon:Texture = null;
         if(option == 0)
         {
            return;
         }
         var idx:int = this.iconIndex(teamId,option);
         if(state)
         {
            if(idx == -1)
            {
               icon = this.uiApi.createComponent("Texture") as Texture;
               icon.x = 25 * (option - 1);
               icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "fightOption" + option);
               icon.finalize();
               this.uiApi.addComponentHook(icon,"onRollOver");
               this.uiApi.addComponentHook(icon,"onRollOut");
               if(teamId)
               {
                  this.ctr_iconsRight.addChild(icon);
                  this._iconsRight[option] = icon;
               }
               else
               {
                  this.ctr_iconsLeft.addChild(icon);
                  this._iconsLeft[option] = icon;
               }
            }
            else if(teamId)
            {
               this._iconsRight[option].visible = true;
            }
            else
            {
               this._iconsLeft[option].visible = true;
            }
            
         }
         else if(idx != -1)
         {
            if(teamId)
            {
               this._iconsRight[idx].visible = false;
            }
            else
            {
               this._iconsLeft[idx].visible = false;
            }
         }
         
      }
      
      private function onMapRunningFightList(pFights:Object) : void {
         this._fights = new Array();
         if(pFights.length == 0)
         {
            this.gd_leftTeam.dataProvider = new Array();
            this.gd_rightTeam.dataProvider = new Array();
            this.lbl_levelLeft.text = "";
            this.lbl_levelRight.text = "";
            this.lbl_wavesLeft.text = "";
            this.lbl_wavesRight.text = "";
            this.lbl_attackersName.text = this.uiApi.getText("ui.common.attackers");
            this.lbl_defendersName.text = this.uiApi.getText("ui.common.defenders");
         }
         else
         {
            this.handleFights(pFights);
         }
         this.updateFightsList();
      }
      
      private function onMapFightCount(pFightCount:uint) : void {
         if(pFightCount != this.gd_fights.dataProvider.length)
         {
            this.sysApi.sendAction(new OpenCurrentFight());
         }
      }
      
      private function onMapRunningFightDetails(pFightId:uint, pAttackers:Object, pDefenders:Object, attackersName:String, defendersName:String) : void {
         var nbWavesTotalLeft:* = 0;
         var nbWavesTotalRight:* = 0;
         var attacker:Object = null;
         var defender:Object = null;
         var fight:Object = null;
         var optionsTeam0:* = undefined;
         var optionsTeam1:* = undefined;
         this.refreshButtons(this._selectedFight.id);
         this._fightersNameById = new Dictionary();
         if((attackersName) && (!(attackersName == "")))
         {
            this.lbl_attackersName.text = attackersName;
         }
         else
         {
            this.lbl_attackersName.text = this.uiApi.getText("ui.common.attackers");
         }
         if((defendersName) && (!(defendersName == "")))
         {
            this.lbl_defendersName.text = defendersName;
         }
         else
         {
            this.lbl_defendersName.text = this.uiApi.getText("ui.common.defenders");
         }
         var totalLevel:uint = 0;
         var averageLevel:uint = 0;
         var nbWavesRight:int = 0;
         var nbWavesLeft:int = 0;
         for each(attacker in pAttackers)
         {
            totalLevel = totalLevel + attacker.level;
            if(attacker is GameFightFighterNamedLightInformations)
            {
               this._fightersNameById[(attacker as GameFightFighterNamedLightInformations).id] = (attacker as GameFightFighterNamedLightInformations).name;
            }
            if((attacker.wave > 0) && (attacker.wave > nbWavesLeft))
            {
               nbWavesLeft = attacker.wave;
            }
         }
         averageLevel = Math.round(totalLevel / pAttackers.length);
         this.lbl_levelLeft.text = this.uiApi.getText("ui.common.short.level") + " " + averageLevel.toString();
         totalLevel = 0;
         for each(defender in pDefenders)
         {
            totalLevel = totalLevel + defender.level;
            if(defender is GameFightFighterNamedLightInformations)
            {
               this._fightersNameById[(defender as GameFightFighterNamedLightInformations).id] = (defender as GameFightFighterNamedLightInformations).name;
            }
            if((defender.wave > 0) && (defender.wave > nbWavesRight))
            {
               nbWavesRight = defender.wave;
            }
         }
         averageLevel = Math.round(totalLevel / pDefenders.length);
         this.lbl_levelRight.text = this.uiApi.getText("ui.common.short.level") + " " + averageLevel.toString();
         if((nbWavesLeft > 0) || (nbWavesRight > 0))
         {
            for each(fight in this._fights)
            {
               if((fight) && (fight.id == this._selectedFight.id))
               {
                  if(fight.fightTeams[0])
                  {
                     nbWavesTotalLeft = fight.fightTeams[0].nbWaves;
                  }
                  if(fight.fightTeams[1])
                  {
                     nbWavesTotalRight = fight.fightTeams[1].nbWaves;
                  }
               }
            }
            if(nbWavesTotalLeft > 0)
            {
               this.lbl_wavesLeft.text = this.uiApi.processText(this.uiApi.getText("ui.spectator.wavesDisplayed"),"",nbWavesLeft == 1) + " " + nbWavesLeft + "/" + nbWavesTotalLeft;
            }
            else
            {
               this.lbl_wavesLeft.text = "";
            }
            if(nbWavesTotalRight > 0)
            {
               this.lbl_wavesRight.text = this.uiApi.processText(this.uiApi.getText("ui.spectator.wavesDisplayed"),"",nbWavesRight == 1) + " " + nbWavesRight + "/" + nbWavesTotalRight;
            }
            else
            {
               this.lbl_wavesRight.text = "";
            }
         }
         this.gd_leftTeam.dataProvider = pAttackers;
         this.gd_rightTeam.dataProvider = pDefenders;
         var fight2:Object = this.roleplayApi.getFight(this._selectedFight.id);
         if((!fight2) || (!fight2.teams[0]) || (!fight2.teams[1]))
         {
            this.updateOptions(0,1,false);
            this.updateOptions(0,2,false);
            this.updateOptions(0,3,false);
            this.updateOptions(1,1,false);
            this.updateOptions(1,2,false);
            this.updateOptions(1,3,false);
         }
         else
         {
            for(optionsTeam0 in fight2.teams[0].teamOptions)
            {
               this.updateOptions(0,optionsTeam0,fight2.teams[0].teamOptions[optionsTeam0]);
            }
            for(optionsTeam1 in fight2.teams[1].teamOptions)
            {
               this.updateOptions(1,optionsTeam1,fight2.teams[1].teamOptions[optionsTeam1]);
            }
         }
      }
      
      private function onMapRemoveFight(pFightId:uint) : void {
         this._timerTest = new Timer(100);
         this._timerTest.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
         this._timerTest.start();
      }
      
      private function onTimerEnd(pEvent:TimerEvent) : void {
         this._timerTest.removeEventListener(TimerEvent.TIMER,this.onTimerEnd);
         this._timerTest = null;
         this.sysApi.sendAction(new OpenCurrentFight());
      }
      
      private function onTimerTick(pEvent:TimerEvent) : void {
         var fight:Object = null;
         var duration:* = NaN;
         var durationTxt:String = null;
         for each(fight in this.gd_fights.dataProvider)
         {
            if(this._initialDurations[fight.id])
            {
               duration = this._initialDurations[fight.id] + this._timerTick;
               durationTxt = this.timeApi.getShortDuration(duration * 1000);
               if((this._fightsRef[fight]) && (this._fightsRef[fight].lbl_timeStartFight) && (!(durationTxt == this._fightsRef[fight].lbl_timeStartFight.text)))
               {
                  this._fightsRef[fight].lbl_timeStartFight.text = durationTxt;
               }
            }
         }
         this._timerTick++;
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.gd_fights:
               switch(selectMethod)
               {
                  case GridItemSelectMethodEnum.DOUBLE_CLICK:
                     if(this._selectedFight == null)
                     {
                        break;
                     }
                     this.joinFight(this._selectedFight.id);
                     break;
                  default:
                     if((!isNewSelection) && (!(selectMethod == GridItemSelectMethodEnum.AUTO)))
                     {
                        return;
                     }
                     this._selectedFight = this.gd_fights.dataProvider[target.selectedIndex];
                     if(this._selectedFight == null)
                     {
                        break;
                     }
                     this.sysApi.sendAction(new MapRunningFightDetailsRequest(this._selectedFight.id));
                     break;
               }
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         var fight:Object = null;
         switch(target)
         {
            case this.btn_fightLeft:
               fight = this.roleplayApi.getFight(this._selectedFight.id);
               if(!fight)
               {
                  return;
               }
               this.sysApi.sendAction(new JoinFightRequest(this._selectedFight.id,fight.teams[0].teamInfos.leaderId));
               break;
            case this.btn_fightRight:
               fight = this.roleplayApi.getFight(this._selectedFight.id);
               if(!fight)
               {
                  return;
               }
               if(fight.teams[1].teamType == TeamTypeEnum.TEAM_TYPE_TAXCOLLECTOR)
               {
                  this.sysApi.dispatchHook(OpenSocial,1,2);
               }
               else
               {
                  this.sysApi.sendAction(new JoinFightRequest(this._selectedFight.id,fight.teams[1].teamInfos.leaderId));
               }
               break;
            case this.btn_spectate:
               this.sysApi.sendAction(new JoinAsSpectatorRequest(this._selectedFight.id));
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_orderNumberPlayers:
               if(this._currentSort == ORDER_NUMBER)
               {
                  this._currentSort = -ORDER_NUMBER;
                  this.updateFightsList();
               }
               else
               {
                  this._currentSort = ORDER_NUMBER;
                  this.updateFightsList();
               }
               break;
            case this.btn_orderLevel:
               if(this._currentSort == ORDER_LEVEL)
               {
                  this._currentSort = -ORDER_LEVEL;
                  this.updateFightsList();
               }
               else
               {
                  this._currentSort = ORDER_LEVEL;
                  this.updateFightsList();
               }
               break;
            case this.btn_orderDuration:
               if(this._currentSort == ORDER_DURATION)
               {
                  this._currentSort = -ORDER_DURATION;
                  this.updateFightsList();
               }
               else
               {
                  this._currentSort = ORDER_DURATION;
                  this.updateFightsList();
               }
               break;
            case this.btn_orderVip:
               if(this._currentSort == ORDER_VIP)
               {
                  this._currentSort = -ORDER_VIP;
                  this.updateFightsList();
               }
               else
               {
                  this._currentSort = ORDER_VIP;
                  this.updateFightsList();
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var iKnowYou:* = 0;
         var fightType:* = 0;
         switch(target)
         {
            case this._iconsRight[1]:
            case this._iconsLeft[1]:
               text = this.uiApi.getText("ui.fight.option.blockJoinerExceptParty");
               break;
            case this._iconsRight[2]:
            case this._iconsLeft[2]:
               text = this.uiApi.getText("ui.fight.option.blockJoiner");
               break;
            case this._iconsRight[3]:
            case this._iconsLeft[3]:
               text = this.uiApi.getText("ui.fight.option.help");
               break;
            default:
               if(target.name.indexOf("tx_iknowyou") != -1)
               {
                  iKnowYou = this._compsTxVip[target.name].iKnowYou;
                  if(iKnowYou == 1)
                  {
                     text = this.uiApi.getText("ui.spectator.isGroup");
                  }
                  else if(iKnowYou == 2)
                  {
                     text = this.uiApi.getText("ui.spectator.isFriend");
                  }
                  else if(iKnowYou == 3)
                  {
                     text = this.uiApi.getText("ui.spectator.isGuild");
                  }
                  else if(iKnowYou == 4)
                  {
                     text = this.uiApi.getText("ui.spectator.isAlliance");
                  }
                  
                  
                  
               }
               else if(target.name.indexOf("tx_twoArrows") != -1)
               {
                  fightType = this._compsTxFightType[target.name].type;
                  if(fightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA)
                  {
                     text = this.uiApi.getText("ui.common.koliseum");
                  }
                  else if(fightType == FightTypeEnum.FIGHT_TYPE_CHALLENGE)
                  {
                     text = this.uiApi.getText("ui.fight.challenge");
                  }
                  else if(fightType == FightTypeEnum.FIGHT_TYPE_AGRESSION)
                  {
                     text = this.uiApi.getText("ui.alert.event.11");
                  }
                  else if(fightType == FightTypeEnum.FIGHT_TYPE_PvT)
                  {
                     text = this.uiApi.getText("ui.spectator.taxcollectorAttack");
                  }
                  else if(fightType == FightTypeEnum.FIGHT_TYPE_PvPr)
                  {
                     text = this.uiApi.getText("ui.prism.attackedNotificationTitle");
                  }
                  
                  
                  
                  
               }
               
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onGameFightOptionStateUpdate(fightId:int, pTeamId:uint, option:int, state:Boolean) : void {
         var fight:Object = null;
         var f:Object = null;
         if((this._selectedFight) && (fightId == this._selectedFight.id))
         {
            this.updateOptions(pTeamId,option,state);
            switch(option)
            {
               case 0:
                  this.refreshSpectateButton(state);
                  break;
               case 2:
                  this.refreshJoinButton(pTeamId,state);
            }
         }
         if(option == 0)
         {
            for each(fight in this._fights)
            {
               if((fight) && (fight.id == fightId))
               {
                  fight.spectatorLocked = state;
               }
            }
            for each(f in this.gd_fights.dataProvider)
            {
               if((f.id == fightId) && (this._fightsRef[f]) && (this._fightsRef[f].tx_spectatorLocked))
               {
                  this._fightsRef[f].tx_spectatorLocked.visible = state;
               }
            }
         }
      }
   }
}
