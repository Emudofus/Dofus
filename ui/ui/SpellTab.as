package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.FightApi;
   import d2api.SoundApi;
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.ScrollContainer;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.Label;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2data.Spell;
   import d2data.SpellLevel;
   import d2data.SpellWrapper;
   
   public class SpellTab extends Object
   {
      
      public function SpellTab() {
         this._spells = new Array();
         this._boostBtnList = new Dictionary(true);
         super();
      }
      
      private static var _self:SpellTab;
      
      public static const TOOLTIP_SPELL_TAB:String = "tooltipSpellTab";
      
      private static var _currentSpellIndexSelected:int = 0;
      
      private static var _currentSpellLevelSelected:int = -1;
      
      private static var _initialised:Boolean = false;
      
      private static var _currentSpellTypeIndexSelected:int = 0;
      
      public static function getInstance() : SpellTab {
         if(_self == null)
         {
            throw new Error("SpellTab singleton Error");
         }
         else
         {
            return _self;
         }
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var fightApi:FightApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var modContextMenu:Object;
      
      private var _selectedSpell:Object;
      
      private var _selectedLevel:uint;
      
      private var _shownTooltipId:uint;
      
      private var _shownTooltipLevel:uint;
      
      private var _selectedSpellTypeFilter:Object;
      
      private var _spells:Array;
      
      private var _gridSortedByNameDescending:Boolean = true;
      
      private var _gridSortedByLevelDescending:Boolean = true;
      
      private var _btnSpells:Array;
      
      private var _scrollPosition:Number;
      
      private var _boostBtnList:Dictionary;
      
      private var _spellsHash:String;
      
      private var _lifePoints:int;
      
      private var _gridSortByName:Boolean;
      
      private var _gridSortByLevel:Boolean;
      
      private var _spellsInventory:Object;
      
      private var _playerLevel:int;
      
      public var grid_spell:Grid;
      
      public var cbx_selection_type_spell:ComboBox;
      
      public var toolTipContainer:ScrollContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabBoost:ButtonContainer;
      
      public var btn_SpellLevelOne:ButtonContainer;
      
      public var btn_SpellLevelTwo:ButtonContainer;
      
      public var btn_SpellLevelThree:ButtonContainer;
      
      public var btn_SpellLevelFour:ButtonContainer;
      
      public var btn_SpellLevelFive:ButtonContainer;
      
      public var btn_SpellLevelSix:ButtonContainer;
      
      public var tx_spell_icon_large:Texture;
      
      public var lbl_spell_point:Label;
      
      public var lbl_name:Label;
      
      public var lbl_requiredLevel:Label;
      
      public function main(oParam:Object = null) : void {
         var s:Object = null;
         var swInven:Object = null;
         _initialised = false;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         _self = this;
         this.sysApi.addHook(SpellUpgradeSuccess,this.onSpellUpgradeSuccess);
         this.sysApi.addHook(SpellUpgradeFail,this.onSpellUpgradeFail);
         this.sysApi.addHook(SpellList,this.onSpellsList);
         this.sysApi.addHook(CharacterStatsList,this.onCharacterStatsList);
         this.sysApi.addHook(SpellForgotten,this.onSpellForgotten);
         this.sysApi.dispatchHook(SwitchBannerTab,"spells");
         if((!this.sysApi.isFightContext()) || (this.fightApi.getCurrentPlayedFighterId() == this.playerApi.id()))
         {
            this.sysApi.dispatchHook(SpellMovementAllowed,true);
         }
         this._btnSpells = new Array(this.btn_SpellLevelOne,this.btn_SpellLevelTwo,this.btn_SpellLevelThree,this.btn_SpellLevelFour,this.btn_SpellLevelFive,this.btn_SpellLevelSix);
         var tempInventorySpells:Array = new Array();
         this._playerLevel = this.playerApi.getPlayedCharacterInfo().level;
         this._spellsInventory = this.playerApi.getSpellInventory();
         for each(tempInventorySpells[swInven.id] in this._spellsInventory)
         {
         }
         for each(s in tempInventorySpells)
         {
            this._spells.push(s);
         }
         this._spells.sort(this.sortOnMinPlayerLevel);
         this.cbx_selection_type_spell.dataProvider = this.getComboboxDP();
         this.cbx_selection_type_spell.selectedIndex = _currentSpellTypeIndexSelected;
         this._selectedSpellTypeFilter = this.cbx_selection_type_spell.dataProvider[_currentSpellTypeIndexSelected];
         this.lbl_spell_point.text = this.playerApi.characteristics().spellsPoints.toString();
         this.updateSpellGrid();
         if(oParam != null)
         {
            this.selectSpell(oParam as uint);
         }
         else
         {
            this.grid_spell.selectedIndex = _currentSpellIndexSelected;
         }
      }
      
      public function updateSpellLine(data:*, componentsRef:*, selected:Boolean) : void {
         var spell:Object = null;
         var spellData:Spell = null;
         var obtentionSpellLevel:uint = 0;
         var playerSpellLevel:uint = 0;
         var sp:* = undefined;
         var disable:* = false;
         var sl:Object = null;
         var canBeUp:* = false;
         var i:* = 0;
         var allhidden:* = false;
         var spelllevel:SpellLevel = null;
         componentsRef.slot_icon.dropValidator = this.dropValidatorFunction;
         if(!this._boostBtnList[componentsRef.btn_increase_spell.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_increase_spell,"onRelease");
            this.uiApi.addComponentHook(componentsRef.btn_increase_spell,"onRollOut");
            this.uiApi.addComponentHook(componentsRef.btn_increase_spell,"onRollOver");
         }
         this._boostBtnList[componentsRef.btn_increase_spell.name] = data;
         if(data)
         {
            componentsRef.btn_spell.selected = selected;
            componentsRef.btn_spell.softDisabled = false;
            spell = data;
            if(data.id == 0)
            {
               obtentionSpellLevel = 0;
            }
            else
            {
               spellData = this.dataApi.getSpell(data.id);
               sl = this.dataApi.getSpellLevelBySpell(spellData,1);
               obtentionSpellLevel = sl.minPlayerLevel;
            }
            playerSpellLevel = 1;
            for each(sp in this._spellsInventory)
            {
               if(sp.spellId == data.id)
               {
                  playerSpellLevel = sp.spellLevel;
               }
            }
            componentsRef.lbl_spellName.text = spell.name;
            disable = true;
            if(obtentionSpellLevel <= this._playerLevel)
            {
               disable = false;
            }
            componentsRef.btn_spell.greyedOut = disable;
            if(disable)
            {
               componentsRef.lbl_spellLevel.text = "-";
               componentsRef.btn_increase_spell.visible = false;
               componentsRef.slot_icon.allowDrag = false;
            }
            else
            {
               componentsRef.slot_icon.allowDrag = true;
               canBeUp = true;
               if(data.id == 0)
               {
                  componentsRef.lbl_spellLevel.text = "-";
                  canBeUp = false;
               }
               else
               {
                  componentsRef.lbl_spellLevel.text = playerSpellLevel;
                  if(playerSpellLevel == 6)
                  {
                     canBeUp = false;
                  }
                  else
                  {
                     i = playerSpellLevel + 1;
                     allhidden = true;
                     while(i <= spellData.spellLevels.length)
                     {
                        spelllevel = this.dataApi.getSpellLevelBySpell(spellData,i);
                        if(!spelllevel.hidden)
                        {
                           allhidden = false;
                        }
                        i++;
                     }
                     if(allhidden)
                     {
                        canBeUp = false;
                     }
                     if(playerSpellLevel == 5)
                     {
                        spelllevel = this.dataApi.getSpellLevelBySpell(spellData,playerSpellLevel + 1);
                        if(spelllevel.minPlayerLevel > this.playerApi.getPlayedCharacterInfo().level)
                        {
                           canBeUp = false;
                        }
                     }
                  }
               }
               if((!canBeUp) || (this.playerApi.isIncarnation()))
               {
                  componentsRef.btn_increase_spell.visible = false;
               }
               else
               {
                  componentsRef.btn_increase_spell.visible = true;
                  if(playerSpellLevel <= this.playerApi.characteristics().spellsPoints)
                  {
                     componentsRef.btn_increase_spell.softDisabled = false;
                  }
                  else
                  {
                     componentsRef.btn_increase_spell.softDisabled = true;
                  }
               }
            }
            componentsRef.slot_icon.data = data;
            componentsRef.slot_icon.selected = false;
         }
         else
         {
            componentsRef.btn_spell.selected = false;
            componentsRef.lbl_spellName.text = "";
            componentsRef.lbl_spellLevel.text = "";
            componentsRef.slot_icon.data = null;
            componentsRef.btn_increase_spell.visible = false;
            componentsRef.btn_spell.softDisabled = true;
            componentsRef.btn_spell.reset();
         }
         if(componentsRef.btn_spell.softDisabled)
         {
            componentsRef.slot_icon.allowDrag = true;
         }
      }
      
      public function selectSpell(pSpellID:uint) : void {
         var sp:Object = null;
         var compt:uint = 0;
         for each(sp in this.grid_spell.dataProvider)
         {
            if(sp.spellId == pSpellID)
            {
               this.grid_spell.selectedIndex = compt;
            }
            compt++;
         }
      }
      
      private function sortOnMinPlayerLevel(pSpellA:Object, pSpellB:Object) : Number {
         var aSpellLevelMin:Object = this.dataApi.getSpellLevelBySpell(pSpellA.spell,1);
         var bSpellLevelMin:Object = this.dataApi.getSpellLevelBySpell(pSpellB.spell,1);
         var aMinPlayerLevel:uint = 0;
         var bMinPlayerLevel:uint = 0;
         if(pSpellA.id != 0)
         {
            aMinPlayerLevel = aSpellLevelMin.minPlayerLevel;
         }
         if(pSpellB.id != 0)
         {
            bMinPlayerLevel = bSpellLevelMin.minPlayerLevel;
         }
         if(aMinPlayerLevel > bMinPlayerLevel)
         {
            return 1;
         }
         if(aMinPlayerLevel < bMinPlayerLevel)
         {
            return -1;
         }
         if(pSpellA.id > pSpellB.id)
         {
            return 1;
         }
         if(pSpellA.id < pSpellB.id)
         {
            return -1;
         }
         return 0;
      }
      
      private function sortOnSpellLevel(pSpellA:Object, pSpellB:Object) : Number {
         var direction:int = -1;
         if(this._gridSortedByLevelDescending)
         {
            direction = 1;
         }
         if(pSpellA.id == 0)
         {
            return -direction;
         }
         if(pSpellB.id == 0)
         {
            return direction;
         }
         if(pSpellA.spellLevel > pSpellB.spellLevel)
         {
            return direction;
         }
         if(pSpellA.spellLevel < pSpellB.spellLevel)
         {
            return -direction;
         }
         if(pSpellA.spellLevel == pSpellB.spellLevel)
         {
            if(pSpellA.id > pSpellB.id)
            {
               return direction;
            }
            if(pSpellA.id < pSpellB.id)
            {
               return -direction;
            }
         }
         return 0;
      }
      
      private function getComboboxDP() : Array {
         var spell:Object = null;
         var alreadyIn:* = false;
         var typeId:uint = 0;
         var compt:uint = 0;
         var typeSpell:Object = null;
         var cbSpellTypeDP:Array = new Array();
         cbSpellTypeDP.push(
            {
               "label":this.uiApi.getText("ui.common.allTypes"),
               "value":uint.MAX_VALUE
            });
         for each(spell in this._spells)
         {
            alreadyIn = false;
            typeId = spell.typeId;
            compt = 0;
            for each(typeSpell in cbSpellTypeDP)
            {
               if(cbSpellTypeDP[compt].value == typeId)
               {
                  alreadyIn = true;
               }
               compt++;
            }
            if(!alreadyIn)
            {
               cbSpellTypeDP.push(
                  {
                     "label":this.dataApi.getSpellType(typeId).longName,
                     "value":typeId
                  });
            }
         }
         return cbSpellTypeDP;
      }
      
      private function updateSpellDisplay() : void {
         var spellLevelMinus:int = this._selectedSpell.spellLevel;
         if(spellLevelMinus <= 0)
         {
            spellLevelMinus = 1;
         }
         if(_currentSpellLevelSelected != -1)
         {
            spellLevelMinus = _currentSpellLevelSelected;
         }
         if(_initialised == false)
         {
            _initialised = true;
         }
         else
         {
            _currentSpellLevelSelected = -1;
         }
         this._btnSpells[spellLevelMinus - 1].selected = true;
         var spellItem:Object = this.dataApi.getSpellWrapper(this._selectedSpell.id,spellLevelMinus);
         this.lbl_name.text = this._selectedSpell.name;
         var spellLevel:Object = this.dataApi.getSpellLevelBySpell(this._selectedSpell.spell,spellLevelMinus);
         if(!this._selectedSpell.id)
         {
            this.showSpellLevelButtons(1);
            this.lbl_requiredLevel.text = "1";
         }
         else
         {
            this.showSpellLevelButtons(this._selectedSpell.spell.spellLevels.length);
            this.lbl_requiredLevel.text = spellLevel.minPlayerLevel;
         }
         this.tx_spell_icon_large.uri = this._selectedSpell.fullSizeIconUri;
         if(!this.tx_spell_icon_large.finalized)
         {
            this.tx_spell_icon_large.finalize();
         }
         this.showSpellTooltip(spellItem);
      }
      
      private function manageSpellLevelClickButton(spell:Object, spellLevel:uint, showToolTip:Boolean) : void {
         var spellLvl:Object = null;
         var spellItem:Object = null;
         if((spell.id) && (spellLevel <= this._selectedSpell.spell.spellLevels.length))
         {
            spellLvl = this.dataApi.getSpellLevelBySpell(this._selectedSpell.spell,spellLevel);
            spellItem = this.dataApi.getSpellWrapper(spell.id,spellLevel);
            this.lbl_requiredLevel.text = spellLvl.minPlayerLevel;
            if((!(spellItem == null)) && (showToolTip))
            {
               this.showSpellTooltip(spellItem);
            }
            _currentSpellLevelSelected = spellLevel;
         }
      }
      
      private function getRealSpellLevel(id:uint) : uint {
         var sp:* = undefined;
         var spellLevel:uint = 0;
         for each(sp in this._spellsInventory)
         {
            if(sp.spellId == id)
            {
               spellLevel = sp.spellLevel;
            }
         }
         return spellLevel;
      }
      
      private function showSpellLevelButtons(maxSpellLevel:uint) : void {
         var spelllevel:Object = null;
         var length:uint = this._btnSpells.length;
         var i:uint = 0;
         while(i < length)
         {
            if(i >= maxSpellLevel)
            {
               this._btnSpells[i].visible = false;
            }
            else
            {
               spelllevel = this.dataApi.getSpellLevelBySpell(this._selectedSpell.spell,i + 1);
               this._btnSpells[i].visible = !spelllevel.hidden;
            }
            i++;
         }
      }
      
      private function filterSpellByType() : void {
         var spellw:Object = null;
         var spell:Object = null;
         var newSpellDp:Array = new Array();
         var normalAttackPresent:Boolean = false;
         for each(spellw in this._spells)
         {
            if(spellw.id == 0)
            {
               normalAttackPresent = true;
            }
         }
         if(!normalAttackPresent)
         {
            this._spells.push(this.dataApi.getSpellWrapper(0,1));
         }
         if(this._selectedSpellTypeFilter.value == uint.MAX_VALUE)
         {
            this.grid_spell.dataProvider = this._spells;
            return;
         }
         for each(spell in this._spells)
         {
            if(spell.typeId == this._selectedSpellTypeFilter.value)
            {
               newSpellDp.push(spell);
            }
         }
         this.grid_spell.dataProvider = newSpellDp.sort(this.sortOnMinPlayerLevel);
      }
      
      private function showSpellTooltip(spellItem:Object) : void {
         if((this._shownTooltipId == spellItem.spellId) && (this._shownTooltipLevel == spellItem.spellLevel))
         {
            return;
         }
         this._shownTooltipId = spellItem.spellId;
         this._shownTooltipLevel = spellItem.spellLevel;
         this.uiApi.showTooltip(spellItem,null,false,TOOLTIP_SPELL_TAB,0,2,3,null,null,
            {
               "smallSpell":false,
               "description":true,
               "effects":true,
               "contextual":true,
               "noBg":true,
               "currentCC_EC":false,
               "baseCC_EC":true,
               "spellTab":true
            },null,true);
      }
      
      private function updateSpellGrid() : void {
         var spellWrapper:Object = null;
         var DP:Array = new Array();
         var hash:String = "";
         for each(spellWrapper in this._spells)
         {
            if((spellWrapper && spellWrapper.spell) && (spellWrapper.spell.typeId == this._selectedSpellTypeFilter.value) || (this._selectedSpellTypeFilter.value == uint.MAX_VALUE))
            {
               DP.push(spellWrapper);
               hash = hash + (spellWrapper.spellLevelInfos.id + "-");
            }
         }
         if(this._gridSortByName)
         {
            if(this._gridSortedByNameDescending)
            {
               DP.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
            }
            else
            {
               DP.sortOn("name",Array.CASEINSENSITIVE);
            }
            hash = hash + ("-sortByName" + this._gridSortedByNameDescending);
         }
         else if(this._gridSortByLevel)
         {
            DP.sort(this.sortOnSpellLevel);
            hash = hash + ("-sortByLevel" + this._gridSortedByLevelDescending);
         }
         
         if(this._spellsHash != hash)
         {
            this.grid_spell.dataProvider = DP;
            if(this._scrollPosition != -1)
            {
               this.grid_spell.moveTo(this._scrollPosition,true);
               this._scrollPosition = -1;
            }
            this._spellsHash = hash;
         }
      }
      
      private function boostToLevel(spellId:int, lvl:int) : void {
         this._selectedLevel = lvl;
         var realSpellLevel:int = this.getRealSpellLevel(spellId);
         var pointsRequired:int = lvl * (lvl - 1) / 2 - realSpellLevel * (realSpellLevel - 1) / 2;
         this.modCommon.openPopup(this.uiApi.getText("ui.grimoire.spellLevel.increase"),this.uiApi.getText("ui.grimoire.popup.confirmation",pointsRequired,this.dataApi.getSpell(spellId).name,lvl),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmIncreaseSpellLevel,this.onCancelIncreaseSpellLevel],this.onConfirmIncreaseSpellLevel,this.onCancelIncreaseSpellLevel);
      }
      
      public function onRelease(target:Object) : void {
         var contextMenu:Array = null;
         var levels:Array = null;
         var disabled:* = false;
         var selected:* = false;
         var text:String = null;
         var spellW:SpellWrapper = null;
         var spellData:Spell = null;
         var realSpellLevel:* = 0;
         var mySpellPoints:* = 0;
         var myLevel:* = 0;
         var pointsRequired:* = 0;
         var levelRequired:* = 0;
         var lvl:* = 0;
         switch(target)
         {
            case this.btn_SpellLevelOne:
               this.manageSpellLevelClickButton(this._selectedSpell,1,true);
               break;
            case this.btn_SpellLevelTwo:
               this.manageSpellLevelClickButton(this._selectedSpell,2,true);
               break;
            case this.btn_SpellLevelThree:
               this.manageSpellLevelClickButton(this._selectedSpell,3,true);
               break;
            case this.btn_SpellLevelFour:
               this.manageSpellLevelClickButton(this._selectedSpell,4,true);
               break;
            case this.btn_SpellLevelFive:
               this.manageSpellLevelClickButton(this._selectedSpell,5,true);
               break;
            case this.btn_SpellLevelSix:
               this.manageSpellLevelClickButton(this._selectedSpell,6,true);
               break;
            case this.btn_tabName:
               this._gridSortByName = true;
               this._gridSortByLevel = false;
               if(!this._gridSortedByNameDescending)
               {
                  this.grid_spell.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
                  this._gridSortedByNameDescending = true;
               }
               else
               {
                  this.grid_spell.sortOn("name",Array.CASEINSENSITIVE);
                  this._gridSortedByNameDescending = false;
               }
               break;
            case this.btn_tabLevel:
            case this.btn_tabBoost:
               this._gridSortByName = false;
               this._gridSortByLevel = true;
               this._gridSortedByLevelDescending = !this._gridSortedByLevelDescending;
               this.updateSpellGrid();
               break;
            default:
               if(target.name.indexOf("btn_increase") != -1)
               {
                  contextMenu = new Array();
                  levels = [1,2,3,4,5,6];
                  spellW = this._boostBtnList[target.name];
                  spellData = this.dataApi.getSpell(spellW.id);
                  realSpellLevel = this.getRealSpellLevel(spellW.id);
                  mySpellPoints = this.playerApi.characteristics().spellsPoints;
                  myLevel = this.playerApi.getPlayedCharacterInfo().level;
                  contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.grimoire.spellLevel.increase")));
                  for each(lvl in levels)
                  {
                     disabled = false;
                     selected = false;
                     text = this.uiApi.getText("ui.common.level") + " " + lvl;
                     if(lvl <= realSpellLevel)
                     {
                        disabled = true;
                        selected = true;
                     }
                     levelRequired = this.dataApi.getSpellLevelBySpell(spellData,lvl).minPlayerLevel;
                     pointsRequired = lvl * (lvl - 1) / 2 - realSpellLevel * (realSpellLevel - 1) / 2;
                     if(levelRequired > myLevel)
                     {
                        text = text + ("           " + this.uiApi.getText("ui.spell.requiredLevelShort",levelRequired));
                        disabled = true;
                     }
                     else if(pointsRequired > mySpellPoints)
                     {
                        text = text + ("           " + this.uiApi.processText(this.uiApi.getText("ui.spell.requiredPoints",pointsRequired),"m",pointsRequired == 1));
                        disabled = true;
                     }
                     
                     if(!disabled)
                     {
                        text = text + ("           " + pointsRequired + " " + this.uiApi.processText(this.uiApi.getText("ui.common.point"),"m",pointsRequired == 1));
                     }
                     contextMenu.push(this.modContextMenu.createContextMenuItemObject(text,this.boostToLevel,[spellW.id,lvl],disabled,null,selected,false,null,true));
                  }
                  this.modContextMenu.createContextMenu(contextMenu);
               }
         }
      }
      
      public function onRollOver(target:Object) : void {
         var point:uint = 0;
         var relPoint:uint = 0;
         var tooltipText:String = null;
         if(target.name.indexOf("btn_increase") != -1)
         {
            point = 7;
            relPoint = 1;
            tooltipText = this.uiApi.getText("ui.grimoire.spellLevel.increase");
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.grid_spell:
               this._selectedSpell = this.grid_spell.dataProvider[target.selectedIndex];
               _currentSpellIndexSelected = target.selectedIndex;
               if(this._selectedSpell == null)
               {
                  break;
               }
               this.updateSpellDisplay();
               break;
            case this.cbx_selection_type_spell:
               this._selectedSpellTypeFilter = this.cbx_selection_type_spell.dataProvider[target.selectedIndex];
               _currentSpellTypeIndexSelected = target.selectedIndex;
               switch(selectMethod)
               {
                  case 0:
                  case 3:
                  case 4:
                  case 8:
                     this.updateSpellGrid();
                     break;
               }
               break;
         }
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip(TOOLTIP_SPELL_TAB);
         this.sysApi.dispatchHook(SpellMovementAllowed,false);
      }
      
      public function onConfirmIncreaseSpellLevel() : void {
         var size:uint = this.grid_spell.dataProvider.length;
         var index:uint = 0;
         while(index < size)
         {
            if(!this.grid_spell.indexIsInvisibleSlot(index))
            {
               this._scrollPosition = index;
               break;
            }
            index++;
         }
         this.sysApi.sendAction(new IncreaseSpellLevel(this._selectedSpell.id,this._selectedLevel));
      }
      
      public function onCancelIncreaseSpellLevel() : void {
      }
      
      private function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void {
         if(!oneLifePointRegenOnly)
         {
            this.lbl_spell_point.text = this.playerApi.characteristics().spellsPoints.toString();
            this.updateSpellGrid();
         }
      }
      
      private function onSpellUpgradeSuccess(spellWrapper:Object) : void {
         var sw:Object = null;
         var previousSelectedIndex:uint = this.grid_spell.selectedIndex;
         var comptSW:uint = 0;
         this._spellsInventory = this.playerApi.getSpellInventory();
         for each(sw in this._spells)
         {
            if(sw.id == spellWrapper.id)
            {
               this._spells.splice(comptSW,1,spellWrapper);
            }
            comptSW++;
         }
         this.cbx_selection_type_spell.dataProvider = this.getComboboxDP();
         this.manageSpellLevelClickButton(spellWrapper,spellWrapper.spellLevel,true);
         this._btnSpells[spellWrapper.spellLevel - 1].selected = true;
         this.grid_spell.selectedIndex = previousSelectedIndex;
      }
      
      private function onSpellUpgradeFail() : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.grimoire.popup.upgradeSpellFailMessage"),[this.uiApi.getText("ui.common.ok")],null,null);
      }
      
      public function onSpellsList(spellList:Object) : void {
         this._spellsInventory = this.playerApi.getSpellInventory();
      }
      
      public function onSpellForgotten(pBoostPoint:uint, pSpellsId:Object) : void {
         this.lbl_spell_point.text = this.playerApi.characteristics().spellsPoints.toString();
      }
      
      public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object) : Boolean {
         return false;
      }
      
      public function removeDropSourceFunction(target:Object) : void {
      }
      
      public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object) : void {
         iSlotDataHolder.data = data;
      }
   }
}
