package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.ContextMenuApi;
   import d2api.PlayedCharacterApi;
   import d2components.Label;
   import d2components.TextArea;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2data.WeaponWrapper;
   import d2data.MountWrapper;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import d2data.Item;
   import d2data.EffectInstance;
   import flash.utils.Dictionary;
   import d2data.Effect;
   
   public class ItemBox extends Object
   {
      
      public function ItemBox() {
         super();
      }
      
      private static var _itemIconX:Number;
      
      private static var _itemIconY:Number;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var modContextMenu:Object;
      
      public var menuApi:ContextMenuApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _currentTab:uint = 0;
      
      private var _item:Object;
      
      private var _sameItem:Boolean = false;
      
      private var _showTheoretical:Boolean = false;
      
      private var _etherealRes:String;
      
      private var _subareaId:int;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var lbl_weight:Label;
      
      public var lbl_description:TextArea;
      
      public var tx_item:Texture;
      
      public var tx_etherealGauge:Texture;
      
      public var tx_2hands:Texture;
      
      public var tx_mimicry:Texture;
      
      public var btn_info:ButtonContainer;
      
      public var btn_effects:ButtonContainer;
      
      public var btn_conditions:ButtonContainer;
      
      public var btn_caracteristics:ButtonContainer;
      
      public var gd_lines:Grid;
      
      public function main(pParam:Object = null) : void {
         this.btn_info.soundId = SoundEnum.GEN_BUTTON;
         this.btn_effects.soundId = SoundEnum.GEN_BUTTON;
         this.btn_conditions.soundId = SoundEnum.GEN_BUTTON;
         this.btn_caracteristics.soundId = SoundEnum.GEN_BUTTON;
         this.sysApi.addHook(ObjectModified,this.onObjectModified);
         this.sysApi.addHook(TextureLoadFailed,this.onTextureLoadFailed);
         this.sysApi.addHook(MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         this.uiApi.addComponentHook(this.tx_etherealGauge,"onRollOver");
         this.uiApi.addComponentHook(this.tx_etherealGauge,"onRollOut");
         this.uiApi.addComponentHook(this.tx_2hands,"onRollOver");
         this.uiApi.addComponentHook(this.tx_2hands,"onRollOut");
         this.uiApi.addComponentHook(this.tx_mimicry,"onRollOver");
         this.uiApi.addComponentHook(this.tx_mimicry,"onRollOut");
         if(isNaN(_itemIconX))
         {
            _itemIconX = this.tx_item.x;
         }
         if(isNaN(_itemIconY))
         {
            _itemIconY = this.tx_item.y;
         }
         this.tx_item.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_item,"onTextureReady");
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_effects,this.uiApi.me());
         this.btn_effects.selected = true;
         if(pParam.showTheoretical)
         {
            this._showTheoretical = pParam.showTheoretical;
         }
         this.updateItem(pParam.item);
      }
      
      public function unload() : void {
      }
      
      private function updateItem(pItem:Object = null) : void {
         var desc:String = null;
         var resPos:uint = 0;
         var effect:Object = null;
         var diceNum:uint = 0;
         if(pItem)
         {
            if((this._item) && (this._item.objectUID == pItem.objectUID))
            {
               this._sameItem = true;
            }
            else
            {
               this._sameItem = false;
            }
            this._item = pItem;
            this.lbl_name.cssClass = "light";
            if(this._item.etheral)
            {
               this.lbl_name.cssClass = "itemetheral";
            }
            if(this._item.itemSetId != -1)
            {
               this.lbl_name.cssClass = "itemset";
            }
            this.lbl_name.text = this._item.name;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               this.lbl_name.text = this.lbl_name.text + (" (" + this._item.id + ")");
            }
            this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._item.level;
            this.lbl_weight.text = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._item.weight),"m",this._item.weight <= 1);
            desc = "";
            if(this._item.itemSetId != -1)
            {
               desc = desc + (this.dataApi.getItemSet(this._item.itemSetId).name + " - ");
            }
            if(this._item.type)
            {
               desc = desc + (this.uiApi.getText("ui.common.category") + this.uiApi.getText("ui.common.colon") + this._item.type.name);
            }
            desc = desc + ("\n" + this._item.description);
            this.lbl_description.text = desc;
            if(!this._sameItem)
            {
               this.tx_item.visible = false;
            }
            this.tx_item.uri = this._item.fullSizeIconUri;
            this.tx_etherealGauge.visible = false;
            if(!this._showTheoretical)
            {
               for each(effect in this._item.effects)
               {
                  if(effect.effectId == 812)
                  {
                     this._etherealRes = effect.description;
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
                  }
               }
            }
            if((this._item.isWeapon) && (this._item.twoHanded))
            {
               this.tx_2hands.visible = true;
            }
            else
            {
               this.tx_2hands.visible = false;
            }
            if(this._item.isMimicryObject)
            {
               this.tx_mimicry.visible = true;
            }
            else
            {
               this.tx_mimicry.visible = false;
            }
            if(!this._item.isWeapon)
            {
               this.btn_caracteristics.visible = false;
               if(this._currentTab == 2)
               {
                  this._currentTab = 0;
                  this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_effects,this.uiApi.me());
                  this.btn_effects.selected = true;
               }
            }
            else
            {
               this.btn_caracteristics.visible = true;
            }
            this.updateGrid();
         }
         else
         {
            this.sysApi.log(2,"item null, rien à afficher dans ItemBox");
         }
      }
      
      private function updateGrid() : void {
         var pattern0:RegExp = null;
         var pattern1:RegExp = null;
         var weapon:WeaponWrapper = null;
         var ap:String = null;
         var range:String = null;
         var criterion:Object = null;
         var index:uint = 0;
         var criteriaRespected:* = false;
         var css:String = null;
         var ORindex:* = 0;
         var i:* = 0;
         var firstParenthesisIndex:* = 0;
         var logicOperatorIndex:* = 0;
         var newLineOperator:String = null;
         var criteriaText:String = null;
         var inlineCriteria:Object = null;
         var targetCriterion:Object = null;
         var indexT:uint = 0;
         var criteriaTextT:String = null;
         var criteriaRespectedT:* = false;
         var cssT:String = null;
         var inlineCriteriaT:Object = null;
         var CC_EC:String = null;
         var sign:String = null;
         var criticalHit:Object = null;
         var agility:Object = null;
         var totalCriticalHit:* = 0;
         var totalAgility:* = 0;
         var baseCritik:* = 0;
         var critikPlusBonus:* = 0;
         var critikRate:* = 0;
         var list:Array = new Array();
         switch(this._currentTab)
         {
            case 0:
               this.showEffect(list);
               break;
            case 1:
               pattern0 = new RegExp("<","g");
               pattern1 = new RegExp(">","g");
               if(this._item.conditions)
               {
                  for each(criterion in this._item.conditions.criteria)
                  {
                     index = 0;
                     criteriaRespected = criterion.isRespected;
                     css = "p";
                     ORindex = criterion.text.indexOf("|");
                     firstParenthesisIndex = 0;
                     logicOperatorIndex = 0;
                     i = 0;
                     while(i < criterion.inlineCriteria.length)
                     {
                        criteriaText = "";
                        inlineCriteria = criterion.inlineCriteria[i];
                        if(inlineCriteria.text != "")
                        {
                           if(index > 0)
                           {
                              if(ORindex > 0)
                              {
                                 criteriaText = " " + this.uiApi.getText("ui.common.or") + " ";
                              }
                           }
                           if((!criteriaRespected) && (!inlineCriteria.isRespected))
                           {
                              css = "malus";
                           }
                           criteriaText = criteriaText + inlineCriteria.text;
                           if((criterion.inlineCriteria.length > 1) && (i == firstParenthesisIndex))
                           {
                              criteriaText = "(" + criteriaText;
                           }
                           if(newLineOperator == "|")
                           {
                              criteriaText = this.uiApi.getText("ui.common.or") + " " + criteriaText;
                              newLineOperator = "null";
                           }
                           if(criterion.inlineCriteria.length > 1)
                           {
                              if((!(i == firstParenthesisIndex)) && (i == criterion.inlineCriteria.length - 1))
                              {
                                 criteriaText = criteriaText + ")";
                                 newLineOperator = this._item.conditions.operators[logicOperatorIndex];
                                 logicOperatorIndex++;
                              }
                           }
                           else if(this._item.conditions.criteria.length > 1)
                           {
                              if(this._item.conditions.operators[logicOperatorIndex] == "|")
                              {
                                 newLineOperator = this._item.conditions.operators[logicOperatorIndex];
                                 logicOperatorIndex++;
                              }
                           }
                           
                           index++;
                        }
                        else if(i == 0)
                        {
                           firstParenthesisIndex++;
                        }
                        
                        criteriaText = criteriaText.replace(pattern0,"&lt;");
                        criteriaText = criteriaText.replace(pattern1,"&gt;");
                        if(criteriaText)
                        {
                           list.push(
                              {
                                 "label":criteriaText,
                                 "cssClass":css
                              });
                        }
                        i++;
                     }
                  }
               }
               if(this._item.targetConditions)
               {
                  for each(targetCriterion in this._item.targetConditions.criteria)
                  {
                     indexT = 0;
                     criteriaTextT = "";
                     criteriaRespectedT = targetCriterion.isRespected;
                     cssT = "p";
                     for each(inlineCriteriaT in targetCriterion.inlineCriteria)
                     {
                        if(inlineCriteriaT.text != "")
                        {
                           if(indexT > 0)
                           {
                              criteriaTextT = criteriaTextT + (" " + this.uiApi.getText("ui.common.or") + " ");
                           }
                           if((!criteriaRespectedT) && (!inlineCriteriaT.isRespected))
                           {
                              cssT = "malus";
                           }
                           criteriaTextT = criteriaTextT + inlineCriteriaT.text;
                           indexT++;
                        }
                     }
                     criteriaTextT = criteriaTextT.replace(pattern0,"&lt;");
                     criteriaTextT = criteriaTextT.replace(pattern1,"&gt;");
                     if(criteriaTextT)
                     {
                        list.push(
                           {
                              "label":"(" + this.uiApi.getText("ui.item.target") + ") " + criteriaTextT,
                              "cssClass":cssT
                           });
                     }
                  }
               }
               break;
            case 2:
               weapon = this._item as WeaponWrapper;
               ap = this.uiApi.getText("ui.stats.shortAP") + this.uiApi.getText("ui.common.colon") + weapon.apCost;
               if(weapon.maxCastPerTurn)
               {
                  ap = ap + (" (" + this.uiApi.processText(this.uiApi.getText("ui.item.usePerTurn",weapon.maxCastPerTurn),"n",weapon.maxCastPerTurn <= 1) + ")");
               }
               list.push(ap);
               if(weapon.range == weapon.minRange)
               {
                  range = String(weapon.range);
               }
               else
               {
                  range = weapon.minRange + " - " + weapon.range;
               }
               list.push(this.uiApi.getText("ui.common.range") + this.uiApi.getText("ui.common.colon") + range);
               if((weapon.criticalFailureProbability) || (weapon.criticalHitProbability))
               {
                  CC_EC = "";
                  if(weapon.criticalHitProbability)
                  {
                     if(weapon.criticalHitBonus > 0)
                     {
                        sign = "+";
                     }
                     else if(weapon.criticalHitBonus < 0)
                     {
                        sign = "-";
                     }
                     
                     if(sign)
                     {
                        list.push(this.uiApi.getText("ui.item.critical.bonus",weapon.criticalHitBonus));
                     }
                     CC_EC = CC_EC + (this.uiApi.getText("ui.common.short.CriticalHit") + this.uiApi.getText("ui.common.colon") + "1/" + weapon.criticalHitProbability);
                     if(this.playerApi.characteristics() != null)
                     {
                        criticalHit = this.playerApi.characteristics().criticalHit;
                        agility = this.playerApi.characteristics().agility;
                        totalCriticalHit = criticalHit.alignGiftBonus + criticalHit.base + criticalHit.contextModif + criticalHit.objectsAndMountBonus;
                        totalAgility = agility.alignGiftBonus + agility.base + agility.contextModif + agility.objectsAndMountBonus;
                        if(totalAgility < 0)
                        {
                           totalAgility = 0;
                        }
                        baseCritik = weapon.criticalHitProbability - totalCriticalHit;
                        critikPlusBonus = int(baseCritik * Math.E * 1.1 / Math.log(totalAgility + 12));
                        critikRate = Math.min(baseCritik,critikPlusBonus);
                        if(critikRate < 2)
                        {
                           critikRate = 2;
                        }
                        list.push(this.uiApi.getText("ui.itemtooltip.itemCriticalReal","1/" + critikRate));
                     }
                  }
                  if(weapon.criticalFailureProbability)
                  {
                     CC_EC = CC_EC + ((weapon.criticalHitProbability?" - ":"") + this.uiApi.getText("ui.common.short.CriticalFailure") + this.uiApi.getText("ui.common.colon") + "1/" + weapon.criticalFailureProbability + " ");
                  }
                  list.push(CC_EC);
               }
               if((weapon.castInLine) && (weapon.range > 1))
               {
                  list.push(this.uiApi.getText("ui.spellInfo.castInLine"));
               }
               if((!weapon.castTestLos) && (weapon.range > 1))
               {
                  list.push(this.uiApi.getText("ui.spellInfo.castWithoutLos"));
               }
               break;
         }
         var scrollValue:int = this.gd_lines.verticalScrollValue;
         this.gd_lines.dataProvider = list;
         if(this._sameItem)
         {
            this.gd_lines.moveTo(scrollValue,true);
         }
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            if(data is String)
            {
               componentsRef.lbl_text.text = data;
               componentsRef.lbl_text.cssClass = "p";
            }
            else
            {
               componentsRef.lbl_text.text = data.label;
               componentsRef.lbl_text.cssClass = data.cssClass;
            }
            componentsRef.tx_picto.visible = false;
         }
         else
         {
            componentsRef.lbl_text.text = "";
            componentsRef.tx_picto.visible = false;
         }
      }
      
      public function onRelease(target:Object) : void {
         var contextMenu:Object = null;
         switch(target)
         {
            case this.btn_info:
               if((this._item) && (!(this._item == MountWrapper)))
               {
                  contextMenu = this.menuApi.create(this._item,null,[this.uiApi.me()["name"]]);
                  if(contextMenu.content.length > 0)
                  {
                     this.modContextMenu.createContextMenu(contextMenu);
                  }
               }
               break;
            case this.btn_effects:
               this._currentTab = 0;
               this.updateGrid();
               break;
            case this.btn_conditions:
               this._currentTab = 1;
               this.updateGrid();
               break;
            case this.btn_caracteristics:
               this._currentTab = 2;
               this.updateGrid();
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         switch(target)
         {
            case this.tx_etherealGauge:
               text = this._etherealRes;
               break;
            case this.tx_2hands:
               text = this.uiApi.getText("ui.common.twoHandsWeapon");
               break;
            case this.tx_mimicry:
               text = this.uiApi.getText("ui.mimicry.itemTooltip");
               break;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onTextureLoadFailed(target:Object, behavior:Boolean) : void {
         if(target == this.tx_item)
         {
            this.tx_item.uri = this._item.fullSizeErrorIconUri;
         }
      }
      
      public function onTextureReady(pTarget:Object) : void {
         var iconBounds:Rectangle = pTarget.child.getBounds(pTarget as DisplayObject);
         if((!(iconBounds.x == 0)) && (!(iconBounds.y == 0)))
         {
            pTarget.x = _itemIconX - iconBounds.x * pTarget.width / iconBounds.width;
            pTarget.y = _itemIconY - iconBounds.y * pTarget.height / iconBounds.height;
         }
         else
         {
            pTarget.x = _itemIconX;
            pTarget.y = _itemIconY;
         }
         pTarget.visible = true;
      }
      
      public function onItemSelected(pItem:Object, showTheoretical:Boolean = false) : void {
         this._showTheoretical = showTheoretical;
         this.updateItem(pItem);
      }
      
      public function onObjectModified(item:Object) : void {
         if(this._item.objectUID == item.objectUID)
         {
            this.updateItem(item);
         }
      }
      
      public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean) : void {
         var itemObject:Item = null;
         if(this._subareaId != subAreaId)
         {
            if(this._item)
            {
               itemObject = this.dataApi.getItem(this._item.objectGID);
               if((itemObject.favoriteSubAreas) && (itemObject.favoriteSubAreas.length > 0))
               {
                  this.updateGrid();
               }
            }
         }
         this._subareaId = subAreaId;
      }
      
      public function showEffect(list:Array) : void {
         var effects:Object = null;
         var ei:EffectInstance = null;
         var localEffects:Array = null;
         var cacheEffects:Dictionary = null;
         var effect:Effect = null;
         var sortedEffects:Array = null;
         var category:Array = null;
         var sortedCategory:Array = null;
         var lineDmg:Object = null;
         var cssClass:String = null;
         var desc:String = null;
         var line:Object = null;
         var waitingBonus:Object = null;
         var currentCategory:int = 0;
         var theoItem:Object = null;
         var exotic:Boolean = false;
         var theoEffect:Object = null;
         var theoretical:Boolean = false;
         if((!this._showTheoretical) && ((this._item.effects) && (this._item.effects.length > 0) || (this._item.possibleEffects) && (this._item.possibleEffects.length > 0)))
         {
            if((this._item.effects) && (this._item.effects.length > 0))
            {
               effects = this._item.effects;
            }
            else if(this._item.objectUID == 0)
            {
               effects = this._item.possibleEffects;
               theoretical = true;
            }
            
            localEffects = new Array();
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = this._item.favoriteEffect;
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = localEffects;
         }
         else if((this._showTheoretical) || (this._item.objectUID == 0) && (this._item.category == 0))
         {
            if(!this._item.hideEffects)
            {
               effects = this._item.possibleEffects;
               theoretical = true;
            }
            else
            {
               list.push(
                  {
                     "label":this.uiApi.getText("ui.set.secretBonus"),
                     "cssClass":"p"
                  });
               return;
            }
         }
         else
         {
            effects = this._item.effects;
            localEffects = new Array();
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = this._item.favoriteEffect;
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = localEffects;
         }
         
         cacheEffects = new Dictionary();
         for each(ei in effects)
         {
            effect = this.dataApi.getEffect(ei.effectId);
            cacheEffects[ei.effectId] = effect;
         }
         sortedEffects = new Array();
         for each(ei in effects)
         {
            sortedEffects.push(ei);
         }
         sortedEffects.sort(function(a:EffectInstance, b:EffectInstance):int
         {
            var ea:Effect = cacheEffects[a.effectId];
            var eb:Effect = cacheEffects[b.effectId];
            if((ea == null) || (eb == null))
            {
               return 0;
            }
            if(ea.effectPriority > eb.effectPriority)
            {
               return 1;
            }
            if(ea.effectPriority < eb.effectPriority)
            {
               return -1;
            }
            return 0;
         });
         category = new Array();
         for each(ei in sortedEffects)
         {
            if(ei.category != -1)
            {
               if(ei.effectId != 812)
               {
                  currentCategory = ei.category;
                  if(!ei.showInSet)
                  {
                     currentCategory = 3;
                  }
                  if(!category[currentCategory])
                  {
                     category[currentCategory] = new Array();
                  }
                  category[currentCategory].push(
                     {
                        "effect":ei,
                        "cat":currentCategory
                     });
               }
            }
         }
         sortedCategory = new Array();
         for each(lineDmg in category[2])
         {
            desc = lineDmg.effect.description;
            if(!((!desc) || (desc.length == 0)))
            {
               cssClass = "p";
               list.push(
                  {
                     "label":desc,
                     "cssClass":cssClass
                  });
            }
         }
         if((category[0]) && (category[1]))
         {
            sortedCategory = sortedCategory.concat(category[0],category[1]);
         }
         else if((category[0]) || (category[1]))
         {
            sortedCategory = sortedCategory.concat(category[0]?category[0]:category[1]);
         }
         
         if(category[3])
         {
            sortedCategory = sortedCategory.concat(category[3]);
         }
         var waitingBonusList:Array = new Array();
         for each(line in sortedCategory)
         {
            effect = this.dataApi.getEffect(line.effect.effectId);
            if(theoretical)
            {
               desc = line.effect.theoreticalDescription;
            }
            else
            {
               desc = line.effect.description;
            }
            if(!((!desc) || (desc.length == 0)))
            {
               if(effect.bonusType == -1)
               {
                  cssClass = "malus";
               }
               else if(effect.bonusType == 1)
               {
                  cssClass = "bonus";
               }
               else
               {
                  cssClass = "p";
               }
               
               theoItem = this.dataApi.getItem(this._item.id);
               if((!this._item.hideEffects) && (line.effect.showInSet) && (this._item.enhanceable))
               {
                  exotic = true;
                  for each(theoEffect in theoItem.possibleEffects)
                  {
                     if(line.effect.effectId == theoEffect.effectId)
                     {
                        exotic = false;
                     }
                  }
                  if(exotic)
                  {
                     cssClass = "exotic";
                     list.push(
                        {
                           "label":desc,
                           "cssClass":cssClass
                        });
                     continue;
                  }
               }
               waitingBonusList.push(
                  {
                     "label":desc,
                     "cssClass":cssClass
                  });
            }
         }
         for each(waitingBonus in waitingBonusList)
         {
            list.push(waitingBonus);
         }
      }
   }
}
