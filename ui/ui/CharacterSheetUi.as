package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.StorageApi;
   import d2api.PlayedCharacterApi;
   import d2api.JobsApi;
   import d2api.ContextMenuApi;
   import d2api.SoundApi;
   import d2api.UtilApi;
   import flash.utils.Dictionary;
   import d2network.CharacterCharacteristicsInformations;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2enums.ProtocolConstantsEnum;
   import d2actions.OpenBook;
   
   public class CharacterSheetUi extends Object
   {
      
      public function CharacterSheetUi() {
         this._boostBtnList = new Dictionary(true);
         this._caracNameList = new Dictionary(true);
         this._caracValueList = new Dictionary(true);
         this._btnJobAssoc = new Array();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var storageApi:StorageApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var jobsApi:JobsApi;
      
      public var menuApi:ContextMenuApi;
      
      public var soundApi:SoundApi;
      
      public var utilApi:UtilApi;
      
      public var modContextMenu:Object;
      
      private var _dataMatrix:Array;
      
      private var _statList:Array;
      
      private var _statListWithLife:Array;
      
      private var _caracList:Array;
      
      private var _bonus:Array;
      
      private var _damages:Array;
      
      private var _resistList:Array;
      
      private var _resistPvp:Array;
      
      private var _pdvLine:Object;
      
      private var _boostBtnList:Dictionary;
      
      private var _caracNameList:Dictionary;
      
      private var _caracValueList:Dictionary;
      
      private var _btnJobAssoc:Array;
      
      private var _characterInfos;
      
      private var _characterCharacteristics:CharacterCharacteristicsInformations;
      
      private var _xpInfoText:String;
      
      private var _isUnloading:Boolean;
      
      private var _storageMod:uint;
      
      private var _nCurrentTab:uint = 0;
      
      public var ctr_regular:GraphicContainer;
      
      public var ctr_advanced:GraphicContainer;
      
      public var lbl_name:Label;
      
      public var lbl_title:Label;
      
      public var lbl_lvl:Label;
      
      public var lbl_xp:Label;
      
      public var lbl_energy:Label;
      
      public var lbl_statPointsTitle:Label;
      
      public var lbl_statPoints:Label;
      
      public var tx_alignmentIcon:Texture;
      
      public var tx_xpGauge:Texture;
      
      public var tx_energyGauge:Texture;
      
      public var tx_jobIcon1:Texture;
      
      public var tx_jobIcon2:Texture;
      
      public var tx_jobIcon3:Texture;
      
      public var tx_subjobIcon1:Texture;
      
      public var tx_subjobIcon2:Texture;
      
      public var tx_subjobIcon3:Texture;
      
      public var gd_stat:Grid;
      
      public var gd_carac:Grid;
      
      public var gd_caracAdvanced:Grid;
      
      public var btn_close:ButtonContainer;
      
      public var btn_advanced:ButtonContainer;
      
      public var btn_regular:ButtonContainer;
      
      public var btn_title:ButtonContainer;
      
      public function main(params:Object) : void {
         this._isUnloading = false;
         this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
         this.ctr_advanced.visible = false;
         this.sysApi.addHook(StatsUpgradeResult,this.onStatsUpgradeResult);
         this.sysApi.addHook(CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(JobsListUpdated,this.onJobsListUpdated);
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         this.uiApi.addComponentHook(this.btn_advanced,"onRelease");
         this.uiApi.addComponentHook(this.btn_advanced,"onRollOver");
         this.uiApi.addComponentHook(this.btn_advanced,"onRollOut");
         this.uiApi.addComponentHook(this.btn_title,"onRollOver");
         this.uiApi.addComponentHook(this.btn_title,"onRollOut");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.tx_alignmentIcon,"onRelease");
         this.tx_alignmentIcon.handCursor = true;
         this.uiApi.addComponentHook(this.tx_xpGauge,"onRollOver");
         this.uiApi.addComponentHook(this.tx_xpGauge,"onRollOut");
         this.uiApi.addComponentHook(this.tx_energyGauge,"onRollOver");
         this.uiApi.addComponentHook(this.tx_energyGauge,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_lvl,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_lvl,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_xp,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_xp,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_energy,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_energy,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_statPointsTitle,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_statPointsTitle,"onRollOut");
         var i:uint = 1;
         while(i < 4)
         {
            this.uiApi.addComponentHook(this["tx_jobIcon" + i],"onRelease");
            this.uiApi.addComponentHook(this["tx_subjobIcon" + i],"onRelease");
            this.uiApi.addComponentHook(this["tx_jobIcon" + i],"onRollOver");
            this.uiApi.addComponentHook(this["tx_subjobIcon" + i],"onRollOver");
            this.uiApi.addComponentHook(this["tx_jobIcon" + i],"onRollOut");
            this.uiApi.addComponentHook(this["tx_subjobIcon" + i],"onRollOut");
            this["tx_jobIcon" + i].handCursor = true;
            this["tx_subjobIcon" + i].handCursor = true;
            i++;
         }
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         this._characterCharacteristics = this.playerApi.characteristics();
         this._dataMatrix = new Array();
         this._statList = new Array();
         this._statListWithLife = new Array();
         this._caracList = new Array();
         this._damages = new Array();
         this._bonus = new Array();
         this._resistList = new Array();
         this._resistPvp = new Array();
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_regular,this.uiApi.me());
         this.btn_regular.selected = true;
         this.dataInit();
         this.characterUpdate();
         this.btn_close.state = 0;
         this.btn_close.reset();
         var alignment:int = this._characterCharacteristics.alignmentInfos.alignmentSide;
         if(alignment == 0)
         {
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusNeutre.png");
         }
         else if(alignment == 1)
         {
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBontarien.png");
         }
         else if(alignment == 2)
         {
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBrakmarien.png");
         }
         else if(alignment == 3)
         {
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusMercenaire.png");
         }
         
         
         
         this.onJobsListUpdated();
      }
      
      private function dataInit() : void {
         this._dataMatrix.push(this._caracList);
         this._dataMatrix.push(this._statList);
         this._dataMatrix.push(this._bonus);
         this._dataMatrix.push(this._damages);
         this._dataMatrix.push(this._resistList);
         this._dataMatrix.push(this._resistPvp);
         this._pdvLine = 
            {
               "id":"life",
               "text":this.uiApi.getText("ui.stats.lifePoints"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"lifePoints"
            };
         this._caracList.push(
            {
               "id":"vitality",
               "text":this.uiApi.getText("ui.stats.vitality"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"vitality",
               "numId":11
            });
         this._caracList.push(
            {
               "id":"wisdom",
               "text":this.uiApi.getText("ui.stats.wisdom"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"wisdom",
               "numId":12
            });
         this._caracList.push(
            {
               "id":"strength",
               "text":this.uiApi.getText("ui.stats.strength"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength",
               "numId":10
            });
         this._caracList.push(
            {
               "id":"intelligence",
               "text":this.uiApi.getText("ui.stats.intelligence"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence",
               "numId":15
            });
         this._caracList.push(
            {
               "id":"chance",
               "text":this.uiApi.getText("ui.stats.chance"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance",
               "numId":13
            });
         this._caracList.push(
            {
               "id":"agility",
               "text":this.uiApi.getText("ui.stats.agility"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility",
               "numId":14
            });
         this._statList.push(
            {
               "id":"AP",
               "text":this.uiApi.getText("ui.stats.actionPoints"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"actionPoints"
            });
         this._statList.push(
            {
               "id":"MP",
               "text":this.uiApi.getText("ui.stats.movementPoints"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"movementPoints"
            });
         this._statList.push(
            {
               "id":"initiative",
               "text":this.uiApi.getText("ui.stats.initiative"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"initiative"
            });
         this._statList.push(
            {
               "id":"prospecting",
               "text":this.uiApi.getText("ui.stats.prospecting"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"prospecting"
            });
         this._statList.push(
            {
               "id":"range",
               "text":this.uiApi.getText("ui.stats.range"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"range"
            });
         this._statList.push(
            {
               "id":"summonableCreatures",
               "text":this.uiApi.getText("ui.stats.summonableCreatures"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"summonableCreaturesBoost"
            });
         this._bonus.push(
            {
               "id":"PAAttack",
               "text":this.uiApi.getText("ui.stats.PAAttack"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"dodgeAP",
               "text":this.uiApi.getText("ui.stats.dodgeAP"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"PMAttack",
               "text":this.uiApi.getText("ui.stats.PMAttack"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"dodgeMP",
               "text":this.uiApi.getText("ui.stats.dodgeMP"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"criticalHit",
               "text":this.uiApi.getText("ui.stats.criticalHit"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"healBonus",
               "text":this.uiApi.getText("ui.stats.healBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._bonus.push(
            {
               "id":"tackleBlock",
               "text":this.uiApi.getText("ui.stats.takleBlock"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"tackle"
            });
         this._bonus.push(
            {
               "id":"tackleEvade",
               "text":this.uiApi.getText("ui.stats.takleEvade"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"escape"
            });
         this._damages.push(
            {
               "id":"damagesBonus",
               "text":this.uiApi.getText("ui.stats.damagesBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"damagesBonusPercent",
               "text":this.uiApi.getText("ui.stats.damagesBonusPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"criticalDamageBonus",
               "text":this.uiApi.getText("ui.stats.criticalDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"neutralDamageBonus",
               "text":this.uiApi.getText("ui.stats.neutralDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"neutral"
            });
         this._damages.push(
            {
               "id":"earthDamageBonus",
               "text":this.uiApi.getText("ui.stats.earthDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength"
            });
         this._damages.push(
            {
               "id":"fireDamageBonus",
               "text":this.uiApi.getText("ui.stats.fireDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence"
            });
         this._damages.push(
            {
               "id":"waterDamageBonus",
               "text":this.uiApi.getText("ui.stats.waterDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance"
            });
         this._damages.push(
            {
               "id":"airDamageBonus",
               "text":this.uiApi.getText("ui.stats.airDamageBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility"
            });
         this._damages.push(
            {
               "id":"return",
               "text":this.uiApi.getText("ui.stats.return"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"weaponDamagesPercent",
               "text":this.uiApi.getText("ui.stats.weaponDamagesPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"trapBonus",
               "text":this.uiApi.getText("ui.stats.trapBonus"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"trapBonusPercent",
               "text":this.uiApi.getText("ui.stats.trapBonusPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._damages.push(
            {
               "id":"pushDamageBonus",
               "text":this.uiApi.getText("ui.stats.push"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._resistList.push(
            {
               "id":"neutralReduction",
               "text":this.uiApi.getText("ui.stats.neutralReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"neutral"
            });
         this._resistList.push(
            {
               "id":"neutralReduction%",
               "text":this.uiApi.getText("ui.stats.neutralReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"neutral"
            });
         this._resistList.push(
            {
               "id":"earthReduction",
               "text":this.uiApi.getText("ui.stats.earthReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength"
            });
         this._resistList.push(
            {
               "id":"earthReduction%",
               "text":this.uiApi.getText("ui.stats.earthReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength"
            });
         this._resistList.push(
            {
               "id":"fireReduction",
               "text":this.uiApi.getText("ui.stats.fireReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence"
            });
         this._resistList.push(
            {
               "id":"fireReduction%",
               "text":this.uiApi.getText("ui.stats.fireReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence"
            });
         this._resistList.push(
            {
               "id":"waterReduction",
               "text":this.uiApi.getText("ui.stats.waterReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance"
            });
         this._resistList.push(
            {
               "id":"waterReduction%",
               "text":this.uiApi.getText("ui.stats.waterReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance"
            });
         this._resistList.push(
            {
               "id":"airReduction",
               "text":this.uiApi.getText("ui.stats.airReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility"
            });
         this._resistList.push(
            {
               "id":"airReduction%",
               "text":this.uiApi.getText("ui.stats.airReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility"
            });
         this._resistList.push(
            {
               "id":"criticalDamageReduction",
               "text":this.uiApi.getText("ui.stats.criticalDamageReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._resistList.push(
            {
               "id":"pushDamageReduction",
               "text":this.uiApi.getText("ui.stats.pushFixed"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"null"
            });
         this._resistPvp.push(
            {
               "id":"neutralPvpReduction",
               "text":this.uiApi.getText("ui.stats.neutralReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"neutral"
            });
         this._resistPvp.push(
            {
               "id":"neutralPvpReduction%",
               "text":this.uiApi.getText("ui.stats.neutralReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"neutral"
            });
         this._resistPvp.push(
            {
               "id":"earthPvpReduction",
               "text":this.uiApi.getText("ui.stats.earthReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength"
            });
         this._resistPvp.push(
            {
               "id":"earthPvpReduction%",
               "text":this.uiApi.getText("ui.stats.earthReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"strength"
            });
         this._resistPvp.push(
            {
               "id":"firePvpReduction",
               "text":this.uiApi.getText("ui.stats.fireReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence"
            });
         this._resistPvp.push(
            {
               "id":"firePvpReduction%",
               "text":this.uiApi.getText("ui.stats.fireReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"intelligence"
            });
         this._resistPvp.push(
            {
               "id":"waterPvpReduction",
               "text":this.uiApi.getText("ui.stats.waterReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance"
            });
         this._resistPvp.push(
            {
               "id":"waterPvpReduction%",
               "text":this.uiApi.getText("ui.stats.waterReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"chance"
            });
         this._resistPvp.push(
            {
               "id":"airPvpReduction",
               "text":this.uiApi.getText("ui.stats.airReduction"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility"
            });
         this._resistPvp.push(
            {
               "id":"airPvpReduction%",
               "text":this.uiApi.getText("ui.stats.airReductionPercent"),
               "base":0,
               "stuff":0,
               "boost":0,
               "gfxId":"agility"
            });
      }
      
      private function characterUpdate() : void {
         var xpPos:uint = 0;
         this._characterCharacteristics = this.playerApi.characteristics();
         this.lbl_name.text = this._characterInfos.name;
         this.lbl_lvl.text = this.dataApi.getBreed(this._characterInfos.breed).shortName + ", " + this.uiApi.getText("ui.common.level") + " " + this._characterInfos.level.toString();
         if(this.playerApi.getTitle())
         {
            this.lbl_title.text = "« " + this.playerApi.getTitle().name + " »";
         }
         else
         {
            this.lbl_title.text = "";
         }
         this._xpInfoText = this.utilApi.formateIntToString(this._characterCharacteristics.experience);
         if(this._characterInfos.level == ProtocolConstantsEnum.MAX_LEVEL)
         {
            xpPos = 100;
         }
         else
         {
            xpPos = int((this._characterCharacteristics.experience - this._characterCharacteristics.experienceLevelFloor) / (this._characterCharacteristics.experienceNextLevelFloor - this._characterCharacteristics.experienceLevelFloor) * 100);
            this._xpInfoText = this._xpInfoText + (" / " + this.utilApi.formateIntToString(this._characterCharacteristics.experienceNextLevelFloor));
         }
         this.tx_xpGauge.gotoAndStop = xpPos.toString();
         var energyPos:uint = int(this._characterCharacteristics.energyPoints / this._characterCharacteristics.maxEnergyPoints * 100);
         this.tx_energyGauge.gotoAndStop = energyPos.toString();
         this.statsUpdate();
      }
      
      public function unload() : void {
         if(!this._isUnloading)
         {
            this._isUnloading = true;
            this.uiApi.hideTooltip();
            this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_CLOSE);
         }
      }
      
      public function updateStatLine(data:*, componentsRef:*, selected:Boolean) : void {
         var initiative:* = 0;
         var total:* = 0;
         if(!this._caracNameList[componentsRef.lbl_nameStat.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_nameStat,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.lbl_nameStat,"onRollOver");
         }
         this._caracNameList[componentsRef.lbl_nameStat.name] = data;
         if(data)
         {
            if(data.gfxId != "null")
            {
               componentsRef.tx_pictoStat.visible = true;
               componentsRef.tx_pictoStat.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + data.gfxId);
            }
            else
            {
               componentsRef.tx_pictoStat.uri = null;
            }
            componentsRef.lbl_nameStat.text = data.text;
            if(data.id == "life")
            {
               componentsRef.lbl_valueStat.text = this._characterCharacteristics.lifePoints + " / " + this._characterCharacteristics.maxLifePoints;
            }
            else if(data.id == "initiative")
            {
               initiative = data.base + data.boost + data.stuff;
               componentsRef.lbl_valueStat.text = int(initiative * this._characterCharacteristics.lifePoints / this._characterCharacteristics.maxLifePoints) + " / " + initiative;
            }
            else
            {
               total = data.base + data.boost + data.stuff;
               if(total != 0)
               {
                  componentsRef.lbl_valueStat.text = total;
               }
               else
               {
                  componentsRef.lbl_valueStat.text = "-";
               }
            }
            
         }
         else
         {
            componentsRef.lbl_nameStat.text = "";
            componentsRef.lbl_valueStat.text = "";
            componentsRef.tx_pictoStat.visible = false;
         }
      }
      
      public function updateCaracLine(data:*, componentsRef:*, selected:Boolean) : void {
         var total:* = 0;
         var statPointName:String = null;
         var statpoints:Array = null;
         var truc:* = undefined;
         var i:* = 0;
         if(!this._boostBtnList[componentsRef.btn_plus.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_plus,"onRelease");
            this.uiApi.addComponentHook(componentsRef.btn_plus,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.btn_plus,"onRollOver");
         }
         this._boostBtnList[componentsRef.btn_plus.name] = data;
         if(!this._caracNameList[componentsRef.lbl_nameCarac.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_nameCarac,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.lbl_nameCarac,"onRollOver");
         }
         this._caracNameList[componentsRef.lbl_nameCarac.name] = data;
         if(!this._caracValueList[componentsRef.lbl_valueCarac.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_valueCarac,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.lbl_valueCarac,"onRollOver");
         }
         this._caracValueList[componentsRef.lbl_valueCarac.name] = data;
         if(data)
         {
            if(data.gfxId != "null")
            {
               componentsRef.tx_pictoCarac.visible = true;
               componentsRef.tx_pictoCarac.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + data.gfxId);
            }
            else
            {
               componentsRef.tx_pictoCarac.uri = null;
            }
            componentsRef.lbl_nameCarac.text = data.text;
            total = data.base + data.boost + data.stuff;
            if(total != 0)
            {
               componentsRef.lbl_valueCarac.text = total;
            }
            else
            {
               componentsRef.lbl_valueCarac.text = "-";
            }
            componentsRef.btn_plus.visible = false;
            statPointName = data.id.substr(0,1).toLocaleUpperCase() + data.id.substr(1);
            statpoints = new Array();
            for each(truc in this.dataApi.getBreed(this.playerApi.getPlayedCharacterInfo().breed)["statsPointsFor" + statPointName])
            {
               statpoints.push(truc);
            }
            i = 0;
            while(i < statpoints.length)
            {
               if((statpoints[i + 1] && statpoints[i + 1][0] > data.base) && (statpoints[i][0] <= data.base) || (!statpoints[i + 1]))
               {
                  if(this._characterCharacteristics.statsPoints >= statpoints[i][1])
                  {
                     componentsRef.btn_plus.visible = true;
                  }
               }
               i++;
            }
         }
         else
         {
            componentsRef.lbl_valueCarac.text = "";
            componentsRef.lbl_nameCarac.text = "";
            componentsRef.btn_plus.visible = false;
            componentsRef.tx_pictoCarac.visible = false;
         }
      }
      
      public function updateAdvancedLine(data:*, componentsRef:*, selected:Boolean) : void {
         var base:* = 0;
         var bonus:* = 0;
         var total:* = 0;
         if(data)
         {
            if(data is String)
            {
               componentsRef.lbl_base.text = "";
               componentsRef.lbl_bonus.text = "";
               componentsRef.lbl_name.width = 305;
               componentsRef.lbl_name.cssClass = "opposite";
               componentsRef.lbl_name.text = data;
               componentsRef.lbl_total.text = "";
               componentsRef.tx_picto.visible = false;
               componentsRef.caracAdvancedItemCtr.bgColor = this.sysApi.getConfigEntry("colors.grid.title");
            }
            else
            {
               componentsRef.caracAdvancedItemCtr.bgColor = -1;
               componentsRef.lbl_name.width = 135;
               componentsRef.lbl_name.cssClass = "p";
               if(data.gfxId != "null")
               {
                  componentsRef.tx_picto.visible = true;
                  componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + data.gfxId);
               }
               else
               {
                  componentsRef.tx_picto.uri = null;
               }
               componentsRef.lbl_name.text = data.text;
               base = data.base;
               bonus = data.boost + data.stuff;
               if(String(data.id).indexOf("%") != -1)
               {
                  total = Math.min(50,data.base + data.boost + data.stuff);
               }
               else
               {
                  total = data.base + data.boost + data.stuff;
               }
               if(base != 0)
               {
                  componentsRef.lbl_base.text = base;
               }
               else
               {
                  componentsRef.lbl_base.text = "-";
               }
               if(bonus != 0)
               {
                  componentsRef.lbl_bonus.text = bonus;
               }
               else
               {
                  componentsRef.lbl_bonus.text = "-";
               }
               if(total != 0)
               {
                  componentsRef.lbl_total.text = total;
               }
               else
               {
                  componentsRef.lbl_total.text = "-";
               }
            }
         }
         else
         {
            componentsRef.lbl_base.text = "";
            componentsRef.lbl_bonus.text = "";
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_total.text = "";
            componentsRef.tx_picto.visible = false;
         }
      }
      
      private function statsUpdate() : void {
         var i:Object = null;
         var statObj:Object = null;
         this._characterCharacteristics = this.playerApi.characteristics();
         var caracs:Array = new Array();
         caracs.push(this._characterCharacteristics.vitality);
         caracs.push(this._characterCharacteristics.wisdom);
         caracs.push(this._characterCharacteristics.strength);
         caracs.push(this._characterCharacteristics.intelligence);
         caracs.push(this._characterCharacteristics.chance);
         caracs.push(this._characterCharacteristics.agility);
         for(i in caracs)
         {
            this._caracList[i].base = caracs[i].base;
            this._caracList[i].stuff = caracs[i].objectsAndMountBonus;
            this._caracList[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         caracs = new Array();
         caracs.push(this._characterCharacteristics.actionPoints);
         caracs.push(this._characterCharacteristics.movementPoints);
         caracs.push(this._characterCharacteristics.initiative);
         caracs.push(this._characterCharacteristics.prospecting);
         caracs.push(this._characterCharacteristics.range);
         caracs.push(this._characterCharacteristics.summonableCreaturesBoost);
         for(i in caracs)
         {
            this._statList[i].base = caracs[i].base;
            this._statList[i].stuff = caracs[i].objectsAndMountBonus;
            this._statList[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         caracs = new Array();
         caracs.push(this._characterCharacteristics.PAAttack);
         caracs.push(this._characterCharacteristics.dodgePALostProbability);
         caracs.push(this._characterCharacteristics.PMAttack);
         caracs.push(this._characterCharacteristics.dodgePMLostProbability);
         caracs.push(this._characterCharacteristics.criticalHit);
         caracs.push(this._characterCharacteristics.healBonus);
         caracs.push(this._characterCharacteristics.tackleBlock);
         caracs.push(this._characterCharacteristics.tackleEvade);
         for(i in caracs)
         {
            this._bonus[i].base = caracs[i].base;
            this._bonus[i].stuff = caracs[i].objectsAndMountBonus;
            this._bonus[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         caracs = new Array();
         caracs.push(this._characterCharacteristics.allDamagesBonus);
         caracs.push(this._characterCharacteristics.damagesBonusPercent);
         caracs.push(this._characterCharacteristics.criticalDamageBonus);
         caracs.push(this._characterCharacteristics.neutralDamageBonus);
         caracs.push(this._characterCharacteristics.earthDamageBonus);
         caracs.push(this._characterCharacteristics.fireDamageBonus);
         caracs.push(this._characterCharacteristics.waterDamageBonus);
         caracs.push(this._characterCharacteristics.airDamageBonus);
         caracs.push(this._characterCharacteristics.reflect);
         caracs.push(this._characterCharacteristics.weaponDamagesBonusPercent);
         caracs.push(this._characterCharacteristics.trapBonus);
         caracs.push(this._characterCharacteristics.trapBonusPercent);
         caracs.push(this._characterCharacteristics.pushDamageBonus);
         for(i in caracs)
         {
            this._damages[i].base = caracs[i].base;
            this._damages[i].stuff = caracs[i].objectsAndMountBonus;
            this._damages[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         caracs = new Array();
         caracs.push(this._characterCharacteristics.neutralElementReduction);
         caracs.push(this._characterCharacteristics.neutralElementResistPercent);
         caracs.push(this._characterCharacteristics.earthElementReduction);
         caracs.push(this._characterCharacteristics.earthElementResistPercent);
         caracs.push(this._characterCharacteristics.fireElementReduction);
         caracs.push(this._characterCharacteristics.fireElementResistPercent);
         caracs.push(this._characterCharacteristics.waterElementReduction);
         caracs.push(this._characterCharacteristics.waterElementResistPercent);
         caracs.push(this._characterCharacteristics.airElementReduction);
         caracs.push(this._characterCharacteristics.airElementResistPercent);
         caracs.push(this._characterCharacteristics.criticalDamageReduction);
         caracs.push(this._characterCharacteristics.pushDamageReduction);
         for(i in caracs)
         {
            this._resistList[i].base = caracs[i].base;
            this._resistList[i].stuff = caracs[i].objectsAndMountBonus;
            this._resistList[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         caracs = new Array();
         caracs.push(this._characterCharacteristics.pvpNeutralElementReduction);
         caracs.push(this._characterCharacteristics.pvpNeutralElementResistPercent);
         caracs.push(this._characterCharacteristics.pvpEarthElementReduction);
         caracs.push(this._characterCharacteristics.pvpEarthElementResistPercent);
         caracs.push(this._characterCharacteristics.pvpFireElementReduction);
         caracs.push(this._characterCharacteristics.pvpFireElementResistPercent);
         caracs.push(this._characterCharacteristics.pvpWaterElementReduction);
         caracs.push(this._characterCharacteristics.pvpWaterElementResistPercent);
         caracs.push(this._characterCharacteristics.pvpAirElementReduction);
         caracs.push(this._characterCharacteristics.pvpAirElementResistPercent);
         for(i in caracs)
         {
            this._resistPvp[i].base = caracs[i].base;
            this._resistPvp[i].stuff = caracs[i].objectsAndMountBonus;
            this._resistPvp[i].boost = caracs[i].alignGiftBonus + caracs[i].contextModif;
         }
         this.lbl_statPoints.text = String(this._characterCharacteristics.statsPoints);
         this._statListWithLife.push(this._pdvLine);
         for each(statObj in this._statList)
         {
            this._statListWithLife.push(statObj);
         }
         this.gridsUpdate();
      }
      
      private function gridsUpdate() : void {
         var allStats:Array = null;
         var scrollValue:* = 0;
         if(this.ctr_regular.visible)
         {
            this.gd_stat.dataProvider = this._statListWithLife;
            this.gd_carac.dataProvider = this._caracList;
         }
         else
         {
            allStats = new Array();
            allStats.push(this.uiApi.getText("ui.charaSheet.primaryStats"));
            allStats = allStats.concat(this._caracList);
            allStats = allStats.concat(this._statList);
            allStats.push(this.uiApi.getText("ui.charaSheet.secondaryStats"));
            allStats = allStats.concat(this._bonus);
            allStats.push(this.uiApi.getText("ui.stats.damagesBonus"));
            allStats = allStats.concat(this._damages);
            allStats.push(this.uiApi.getText("ui.common.resistances"));
            allStats = allStats.concat(this._resistList);
            allStats.push(this.uiApi.getText("ui.common.resistancesPvp"));
            allStats = allStats.concat(this._resistPvp);
            scrollValue = this.gd_caracAdvanced.verticalScrollValue;
            this.gd_caracAdvanced.dataProvider = allStats;
            this.gd_caracAdvanced.verticalScrollValue = scrollValue;
         }
      }
      
      private function displaySelectedTab(tab:uint) : void {
         switch(tab)
         {
            case 0:
               this.ctr_regular.visible = true;
               this.ctr_advanced.visible = false;
               break;
            case 1:
               this.ctr_regular.visible = false;
               this.ctr_advanced.visible = true;
               break;
         }
         this.gridsUpdate();
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_regular:
               if(this._nCurrentTab != 0)
               {
                  this._nCurrentTab = 0;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_advanced:
               if(this._nCurrentTab != 1)
               {
                  this._nCurrentTab = 1;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_title:
               this.sysApi.sendAction(new OpenBook("titleTab"));
               break;
            case this.tx_jobIcon1:
               this.sysApi.sendAction(new OpenBook("jobTab",1));
               break;
            case this.tx_jobIcon2:
               this.sysApi.sendAction(new OpenBook("jobTab",2));
               break;
            case this.tx_jobIcon3:
               this.sysApi.sendAction(new OpenBook("jobTab",3));
               break;
            case this.tx_subjobIcon1:
               this.sysApi.sendAction(new OpenBook("jobTab",4));
               break;
            case this.tx_subjobIcon2:
               this.sysApi.sendAction(new OpenBook("jobTab",5));
               break;
            case this.tx_subjobIcon3:
               this.sysApi.sendAction(new OpenBook("jobTab",6));
               break;
            case this.tx_alignmentIcon:
               this.sysApi.sendAction(new OpenBook("alignmentTab"));
               break;
            default:
               if(target.name.indexOf("btn_plus") != -1)
               {
                  this.uiApi.loadUi("statBoost","statBoost",[this._boostBtnList[target.name].id,this._boostBtnList[target.name].numId]);
               }
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         switch(target)
         {
            case this.lbl_lvl:
               text = this.uiApi.getText("ui.help.level");
               break;
            case this.tx_xpGauge:
               text = this._xpInfoText;
               break;
            case this.tx_energyGauge:
               text = this.utilApi.formateIntToString(this._characterCharacteristics.energyPoints) + " / " + this.utilApi.formateIntToString(this._characterCharacteristics.maxEnergyPoints);
               break;
            case this.lbl_energy:
               text = this.uiApi.getText("ui.help.energy");
               break;
            case this.lbl_xp:
               text = this.uiApi.getText("ui.help.xp");
               break;
            case this.lbl_statPointsTitle:
               text = this.uiApi.getText("ui.help.boostPoints");
               break;
            case this.btn_title:
               text = this.uiApi.getText("ui.common.titles");
               break;
            case this.tx_jobIcon1:
            case this.tx_jobIcon2:
            case this.tx_jobIcon3:
            case this.tx_subjobIcon1:
            case this.tx_subjobIcon2:
            case this.tx_subjobIcon3:
               text = this.jobsApi.getKnownJobs()[this._btnJobAssoc[target.name]].name;
               break;
            default:
               if(target.name.indexOf("lbl_name") != -1)
               {
                  text = this.uiApi.getText("ui.help." + this._caracNameList[target.name].id);
               }
               else if(target.name.indexOf("lbl_value") != -1)
               {
                  text = this.getParsedStat(this._caracValueList[target.name]);
               }
               
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onStatsUpgradeResult(nbCharacBoost:uint) : void {
         if(nbCharacBoost > 0)
         {
            this.statsUpdate();
         }
         else
         {
            this.sysApi.log(16,"le boost de carac a échoué");
         }
      }
      
      public function onInventoryContent(equipment:Object) : void {
         this.characterUpdate();
      }
      
      public function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void {
         this.characterUpdate();
      }
      
      public function onJobsListUpdated() : void {
         var showjob:uint = 0;
         var jobIndex:uint = 0;
         var subJobIndex:uint = 0;
         var j:* = 0;
         var ind:* = 0;
         var job:Object = null;
         var jobs:Object = this.jobsApi.getKnownJobs();
         var ji:int = 1;
         while(ji <= 3)
         {
            this["tx_jobIcon" + ji].uri = null;
            ji++;
         }
         var sji:int = 1;
         while(sji <= 3)
         {
            this["tx_subjobIcon" + sji].uri = null;
            sji++;
         }
         if(jobs)
         {
            showjob = 0;
            jobIndex = 0;
            subJobIndex = 0;
            j = 0;
            while(j < 6)
            {
               ind = j;
               job = jobs[ind];
               if(job)
               {
                  if(!job.specializationOfId)
                  {
                     if(!showjob)
                     {
                        showjob = ind;
                     }
                     jobIndex++;
                     this["tx_jobIcon" + jobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("job_uri") + job.iconId + ".swf");
                     this._btnJobAssoc["tx_jobIcon" + jobIndex] = ind;
                  }
                  else
                  {
                     subJobIndex++;
                     this["tx_subjobIcon" + subJobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("job_uri") + job.iconId + ".swf");
                     this._btnJobAssoc["tx_subjobIcon" + subJobIndex] = ind;
                  }
               }
               j++;
            }
         }
      }
      
      private function onShortCut(s:String) : Boolean {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      private function getParsedStat(stat:Object) : String {
         var parsedStat:String = this.uiApi.getText("ui.common.base") + this.uiApi.getText("ui.common.colon") + stat.base + "\n" + this.uiApi.getText("ui.common.equipement") + this.uiApi.getText("ui.common.colon") + stat.stuff + "\n" + this.uiApi.getText("ui.common.gifts") + "+" + this.uiApi.getText("ui.common.boost") + this.uiApi.getText("ui.common.colon") + stat.boost;
         return parsedStat;
      }
   }
}
