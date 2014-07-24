package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.TooltipApi;
   import d2api.PlayedCharacterApi;
   import d2api.InventoryApi;
   import flash.geom.ColorTransform;
   import d2data.Companion;
   import d2data.SpellWrapper;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.TextArea;
   import d2data.EffectInstance;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.CharacterInventoryPositionEnum;
   import d2data.ItemWrapper;
   import d2data.CompanionCharacteristic;
   import d2data.CompanionSpell;
   import d2data.SpellLevel;
   import d2enums.LocationEnum;
   
   public class CompanionTab extends Object
   {
      
      public function CompanionTab() {
         this._colorDisable = new ColorTransform(1,1,1,0.4);
         this._coloravailable = new ColorTransform();
         this._allCompanions = new Array();
         this._myCompanions = new Array();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var tooltipApi:TooltipApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var inventoryApi:InventoryApi;
      
      public var modCommon:Object;
      
      private var _colorDisable:ColorTransform;
      
      private var _coloravailable:ColorTransform;
      
      private var _allCompanions:Array;
      
      private var _myCompanions:Array;
      
      private var _selectedCompanion:Companion;
      
      private var _selectedSpell:SpellWrapper;
      
      private var _initialSpellId:uint;
      
      private var _shownTooltipId:int;
      
      private var _currentlyEquipedGID:int;
      
      private var _etherealResText:String;
      
      private var _myLevel:uint;
      
      private var _color1:int;
      
      private var _color2:int;
      
      private var _illusUri:String;
      
      public var gd_companions:Grid;
      
      public var btn_carac:ButtonContainer;
      
      public var btn_spells:ButtonContainer;
      
      public var btn_equip:ButtonContainer;
      
      public var btn_lbl_btn_equip:Label;
      
      public var ctr_carac:GraphicContainer;
      
      public var ctr_spells:GraphicContainer;
      
      public var ctr_spellTooltip:GraphicContainer;
      
      public var tx_spellIcon:Texture;
      
      public var lbl_spellName:Label;
      
      public var lbl_spellInitial:Label;
      
      public var gd_spell:Grid;
      
      public var tx_illu:Texture;
      
      public var tx_etherealGauge:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var gd_carac:Grid;
      
      public var lbl_description:TextArea;
      
      public function main(oParam:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function unload() : void {
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.tx_selected.visible = selected;
            componentsRef.tx_look.uri = this.uiApi.createUri(this._illusUri + "small_" + data.assetId + ".jpg");
            if(this._myCompanions[data.id])
            {
               Texture(componentsRef.tx_look).transform.colorTransform = this._coloravailable;
            }
            else
            {
               Texture(componentsRef.tx_look).transform.colorTransform = this._colorDisable;
            }
         }
         else
         {
            componentsRef.tx_selected.visible = false;
            componentsRef.tx_look.uri = null;
         }
      }
      
      public function updateSpellLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.btn_spell.selected = selected;
            componentsRef.btn_spell.softDisabled = false;
            componentsRef.lbl_spellName.text = data.name;
            componentsRef.slot_icon.allowDrag = false;
            componentsRef.slot_icon.data = data;
            componentsRef.slot_icon.selected = false;
         }
         else
         {
            componentsRef.btn_spell.selected = false;
            componentsRef.lbl_spellName.text = "";
            componentsRef.slot_icon.data = null;
            componentsRef.btn_spell.softDisabled = true;
            componentsRef.btn_spell.reset();
         }
      }
      
      public function updateCaracLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_carac.text = data.text;
         }
         else
         {
            componentsRef.lbl_carac.text = "";
         }
      }
      
      public function onPopupClose() : void {
      }
      
      private function displayCompanionCarac() : void {
         var carac:CompanionCharacteristic = null;
         var caracId:* = 0;
         this.ctr_carac.visible = true;
         this.ctr_spells.visible = false;
         this.lbl_name.text = this._selectedCompanion.name;
         this.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + this._myLevel;
         this.tx_illu.uri = this.uiApi.createUri(this._illusUri + "big_" + this._selectedCompanion.assetId + ".jpg");
         var caracs:Array = new Array();
         var value:int = 0;
         for each(caracId in this._selectedCompanion.characteristics)
         {
            carac = this.dataApi.getCompanionCharacteristic(caracId);
            if((!(carac.levelPerValue == 0)) && (!(carac.valuePerLevel == 0)))
            {
               value = carac.initialValue + carac.valuePerLevel * Math.floor(this._myLevel / carac.levelPerValue);
               caracs.push(
                  {
                     "text":carac.label + this.uiApi.getText("ui.common.colon") + value,
                     "order":carac.order
                  });
            }
         }
         caracs.sortOn("order",Array.NUMERIC);
         this.gd_carac.dataProvider = caracs;
         this.lbl_description.text = this._selectedCompanion.description;
      }
      
      private function displayCompanionSpells() : void {
         var compSpell:CompanionSpell = null;
         var sw:SpellWrapper = null;
         var gradeByLevel:Array = null;
         var compSpellId:* = 0;
         var spellLevel:SpellLevel = null;
         var i:* = 0;
         this.ctr_spells.visible = true;
         this.ctr_carac.visible = false;
         var spells:Array = new Array();
         var grade:uint = 1;
         this._initialSpellId = 0;
         if(this._selectedCompanion.startingSpellLevelId != 0)
         {
            spellLevel = this.dataApi.getSpellLevel(this._selectedCompanion.startingSpellLevelId);
            if(spellLevel)
            {
               sw = this.dataApi.getSpellWrapper(spellLevel.spellId,spellLevel.grade);
               spells.push(sw);
               this._initialSpellId = sw.id;
            }
         }
         for each(compSpellId in this._selectedCompanion.spells)
         {
            compSpell = this.dataApi.getCompanionSpell(compSpellId);
            gradeByLevel = compSpell.gradeByLevel.split(",");
            i = 0;
            while(i < gradeByLevel.length)
            {
               if(gradeByLevel[i + 1] <= this._myLevel)
               {
                  grade = gradeByLevel[i];
               }
               i = i + 2;
            }
            sw = this.dataApi.getSpellWrapper(compSpell.spellId,grade);
            spells.push(sw);
         }
         this.gd_spell.dataProvider = spells;
         this.gd_spell.selectedIndex = 0;
      }
      
      private function displayCompanionInfos() : void {
         var used:* = false;
         var resPos:uint = 0;
         var effect:Object = null;
         var diceNum:uint = 0;
         this.tx_etherealGauge.visible = false;
         this.btn_equip.disabled = true;
         this.btn_lbl_btn_equip.text = this.uiApi.getText("ui.common.equip");
         var myCompanionOfThisType:Object = this._myCompanions[this._selectedCompanion.id];
         if(myCompanionOfThisType)
         {
            used = false;
            if(myCompanionOfThisType.isEthereal)
            {
               for each(effect in myCompanionOfThisType.item.effects)
               {
                  if(effect.effectId == 812)
                  {
                     this._etherealResText = effect.description;
                     if(effect.hasOwnProperty("diceNum"))
                     {
                        diceNum = effect.diceNum;
                     }
                     else
                     {
                        diceNum = 0;
                     }
                     resPos = int(diceNum / effect.value * 100);
                     this.tx_etherealGauge.gotoAndStop = resPos.toString();
                     this.tx_etherealGauge.visible = true;
                     if(diceNum == 0)
                     {
                        used = true;
                     }
                  }
               }
            }
            if(!used)
            {
               this.btn_equip.disabled = false;
               if(this._currentlyEquipedGID == myCompanionOfThisType.item.objectGID)
               {
                  this.btn_lbl_btn_equip.text = this.uiApi.getText("ui.common.unequip");
               }
            }
         }
      }
      
      private function updateSpellDisplay() : void {
         this.lbl_spellName.text = this._selectedSpell.spell.name;
         this.tx_spellIcon.uri = this._selectedSpell.fullSizeIconUri;
         if(this._initialSpellId == this._selectedSpell.id)
         {
            this.lbl_spellInitial.visible = true;
         }
         else
         {
            this.lbl_spellInitial.visible = false;
         }
         this.showSpellTooltip(this._selectedSpell);
      }
      
      private function showSpellTooltip(spellItem:SpellWrapper) : void {
         if(this._shownTooltipId == spellItem.spellId)
         {
            return;
         }
         this._shownTooltipId = spellItem.spellId;
         this.uiApi.showTooltip(spellItem,null,false,"tooltipSpellTab",0,2,3,null,null,
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
      
      public function onRelease(target:Object) : void {
         var myComp:Object = null;
         switch(target)
         {
            case this.btn_carac:
               this.displayCompanionCarac();
               break;
            case this.btn_spells:
               this.displayCompanionSpells();
               break;
            case this.btn_equip:
               myComp = this._myCompanions[this._selectedCompanion.id];
               if(myComp)
               {
                  if(myComp.item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION)
                  {
                     this.sysApi.sendAction(new ObjectSetPosition(myComp.item.objectUID,63,1));
                  }
                  else
                  {
                     this.sysApi.sendAction(new ObjectSetPosition(myComp.item.objectUID,CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION,1));
                  }
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         switch(target)
         {
            case this.tx_etherealGauge:
               text = this._etherealResText;
               break;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_spell)
         {
            this._selectedSpell = this.gd_spell.dataProvider[target.selectedIndex];
            if(this._selectedSpell == null)
            {
               return;
            }
            this.updateSpellDisplay();
         }
         else if(target == this.gd_companions)
         {
            this._selectedCompanion = this.gd_companions.selectedItem;
            if(this.ctr_spells.visible)
            {
               this.displayCompanionSpells();
            }
            else
            {
               this.displayCompanionCarac();
            }
            this.displayCompanionInfos();
         }
         
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
      }
      
      public function onObjectModified(item:Object) : void {
         var isEthereal:* = false;
         var compGID:* = 0;
         var ei:EffectInstance = null;
         if(item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION)
         {
            this._currentlyEquipedGID = item.objectGID;
            isEthereal = false;
            for each(ei in item.effects)
            {
               if(ei.effectId == 1161)
               {
                  compGID = int(ei.parameter0);
               }
               if(ei.effectId == 812)
               {
                  isEthereal = true;
               }
            }
            this._myCompanions[compGID] = 
               {
                  "item":item,
                  "isEthereal":isEthereal
               };
            if(this._myCompanions[this._selectedCompanion.id].item.objectGID == this._currentlyEquipedGID)
            {
               this.displayCompanionInfos();
            }
         }
         else if((item.position == 63) && (this._currentlyEquipedGID == item.objectGID))
         {
            if(this._myCompanions[this._selectedCompanion.id].item.objectGID == this._currentlyEquipedGID)
            {
               this._currentlyEquipedGID = 0;
               this.displayCompanionInfos();
            }
            else
            {
               this._currentlyEquipedGID = 0;
            }
         }
         
      }
   }
}
