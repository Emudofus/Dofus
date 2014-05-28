package com.ankamagames.dofus.datacenter.effects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.types.enums.LanguageEnum;
   
   public class EffectInstance extends Object implements IDataCenter
   {
      
      public function EffectInstance() {
         super();
      }
      
      private static const UNKNOWN_NAME:String = "???";
      
      protected static const _log:Logger;
      
      private static const UNDEFINED_CATEGORY:int = -2;
      
      private static const UNDEFINED_SHOW:int = -1;
      
      private static const UNDEFINED_DESCRIPTION:String = "undefined";
      
      public var effectId:uint;
      
      public var targetId:int;
      
      public var targetMask:String;
      
      public var duration:int;
      
      public var delay:int;
      
      public var random:int;
      
      public var group:int;
      
      public var modificator:int;
      
      public var trigger:Boolean;
      
      public var triggers:String;
      
      public var hidden:Boolean;
      
      public var order:int;
      
      public var zoneSize:Object;
      
      public var zoneShape:uint;
      
      public var zoneMinSize:Object;
      
      public var zoneEfficiencyPercent:Object;
      
      public var zoneMaxEfficiency:Object;
      
      private var _durationStringValue:int;
      
      private var _delayStringValue:int;
      
      private var _durationString:String;
      
      private var _category:int = -2;
      
      private var _description:String = "undefined";
      
      private var _theoricDescription:String = "undefined";
      
      private var _showSet:int = -1;
      
      private var _rawZoneInit:Boolean;
      
      private var _rawZone:String;
      
      public function set rawZone(data:String) : void {
         this._rawZone = data;
         this.parseZone();
      }
      
      public function get rawZone() : String {
         return this._rawZone;
      }
      
      public function get durationString() : String {
         if((!this._durationString) || (!(this._durationStringValue == this.duration)) || (!(this._delayStringValue == this.delay)))
         {
            this._durationStringValue = this.duration;
            this._delayStringValue = this.delay;
            this._durationString = this.getTurnCountStr(false);
         }
         return this._durationString;
      }
      
      public function get category() : int {
         var e:Effect = null;
         if(this._category == UNDEFINED_CATEGORY)
         {
            e = Effect.getEffectById(this.effectId);
            this._category = e?e.category:-1;
         }
         return this._category;
      }
      
      public function get showInSet() : int {
         var e:Effect = null;
         if(this._showSet == UNDEFINED_SHOW)
         {
            e = Effect.getEffectById(this.effectId);
            this._showSet = e?e.showInSet?1:0:0;
         }
         return this._showSet;
      }
      
      public function get parameter0() : Object {
         return null;
      }
      
      public function get parameter1() : Object {
         return null;
      }
      
      public function get parameter2() : Object {
         return null;
      }
      
      public function get parameter3() : Object {
         return null;
      }
      
      public function get parameter4() : Object {
         return null;
      }
      
      public function get description() : String {
         var effect:Effect = null;
         if(this._description == UNDEFINED_DESCRIPTION)
         {
            effect = Effect.getEffectById(this.effectId);
            if(!effect)
            {
               this._description = null;
               return null;
            }
            this._description = this.prepareDescription(effect.description,this.effectId);
         }
         return this._description;
      }
      
      public function get theoreticalDescription() : String {
         var effect:Effect = null;
         var sSourceDesc:String = null;
         if(this._theoricDescription == UNDEFINED_DESCRIPTION)
         {
            effect = Effect.getEffectById(this.effectId);
            if(!effect)
            {
               this._theoricDescription = null;
               return null;
            }
            if(effect.theoreticalPattern == 0)
            {
               this._theoricDescription = null;
               return null;
            }
            if(effect.theoreticalPattern == 1)
            {
               sSourceDesc = effect.description;
            }
            else
            {
               sSourceDesc = effect.theoreticalDescription;
            }
            this._theoricDescription = this.prepareDescription(sSourceDesc,this.effectId);
         }
         return this._theoricDescription;
      }
      
      public function clone() : EffectInstance {
         var o:EffectInstance = new EffectInstance();
         o.zoneShape = this.zoneShape;
         o.zoneSize = this.zoneSize;
         o.zoneMinSize = this.zoneMinSize;
         o.zoneEfficiencyPercent = this.zoneEfficiencyPercent;
         o.zoneMaxEfficiency = this.zoneMaxEfficiency;
         o.effectId = this.effectId;
         o.duration = this.duration;
         o.delay = this.delay;
         o.random = this.random;
         o.group = this.group;
         o.targetId = this.targetId;
         o.targetMask = this.targetMask;
         o.delay = this.delay;
         o.triggers = this.triggers;
         o.order = this.order;
         return o;
      }
      
      public function add(effect:*) : EffectInstance {
         return new EffectInstance();
      }
      
      public function setParameter(paramIndex:uint, value:*) : void {
      }
      
      public function forceDescriptionRefresh() : void {
         this._description = UNDEFINED_DESCRIPTION;
         this._theoricDescription = UNDEFINED_DESCRIPTION;
      }
      
      private function getTurnCountStr(bShowLast:Boolean) : String {
         var sTmp:String = new String();
         if(this.delay > 0)
         {
            return PatternDecoder.combine(I18n.getUiText("ui.common.delayTurn",[this.delay]),"n",this.delay <= 1);
         }
         var d:int = this.duration;
         if(isNaN(d))
         {
            return "";
         }
         if(d > -1)
         {
            if(d > 1)
            {
               return PatternDecoder.combine(I18n.getUiText("ui.common.turn",[d]),"n",false);
            }
            if(d == 0)
            {
               return "";
            }
            if(bShowLast)
            {
               return I18n.getUiText("ui.common.lastTurn");
            }
            return PatternDecoder.combine(I18n.getUiText("ui.common.turn",[d]),"n",true);
         }
         return I18n.getUiText("ui.common.infinit");
      }
      
      private function getEmoticonName(id:int) : String {
         var o:Emoticon = Emoticon.getEmoticonById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getItemTypeName(id:int) : String {
         var o:ItemType = ItemType.getItemTypeById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getMonsterName(id:int) : String {
         var o:Monster = Monster.getMonsterById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getCompanionName(id:int) : String {
         var o:Companion = Companion.getCompanionById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getMonsterGrade(pId:int, pGrade:int) : String {
         var m:Monster = Monster.getMonsterById(pId);
         return m?m.getMonsterGrade(pGrade).level.toString():UNKNOWN_NAME;
      }
      
      private function getSpellName(id:int) : String {
         var o:Spell = Spell.getSpellById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getSpellLevelName(id:int) : String {
         var o:SpellLevel = SpellLevel.getLevelById(id);
         var name:String = o?this.getSpellName(o.spellId):UNKNOWN_NAME;
         trace(name);
         return o?this.getSpellName(o.spellId):UNKNOWN_NAME;
      }
      
      private function getJobName(id:int) : String {
         var o:Job = Job.getJobById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getDocumentTitle(id:int) : String {
         var o:Document = Document.getDocumentById(id);
         return o?o.title:UNKNOWN_NAME;
      }
      
      private function getAlignmentSideName(id:int) : String {
         var o:AlignmentSide = AlignmentSide.getAlignmentSideById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getItemName(id:int) : String {
         var o:Item = Item.getItemById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getMonsterSuperRaceName(id:int) : String {
         var o:MonsterSuperRace = MonsterSuperRace.getMonsterSuperRaceById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getMonsterRaceName(id:int) : String {
         var o:MonsterRace = MonsterRace.getMonsterRaceById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getTitleName(id:int) : String {
         var o:Title = Title.getTitleById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function getSpellStateName(id:int) : String {
         var o:SpellState = SpellState.getSpellStateById(id);
         return o?o.name:UNKNOWN_NAME;
      }
      
      private function parseZone() : void {
         var params:Array = null;
         var hasMinSize:* = false;
         if((this.rawZone) && (this.rawZone.length))
         {
            this.zoneShape = this.rawZone.charCodeAt(0);
            params = this.rawZone.substr(1).split(",");
            hasMinSize = (this.zoneShape == SpellShapeEnum.C) || (this.zoneShape == SpellShapeEnum.X) || (this.zoneShape == SpellShapeEnum.Q) || (this.zoneShape == SpellShapeEnum.plus) || (this.zoneShape == SpellShapeEnum.sharp);
            switch(params.length)
            {
               case 1:
                  this.zoneSize = parseInt(params[0]);
                  break;
               case 2:
                  this.zoneSize = parseInt(params[0]);
                  if(hasMinSize)
                  {
                     this.zoneMinSize = parseInt(params[1]);
                  }
                  else
                  {
                     this.zoneEfficiencyPercent = parseInt(params[1]);
                  }
                  break;
               case 3:
                  this.zoneSize = parseInt(params[0]);
                  if(hasMinSize)
                  {
                     this.zoneMinSize = parseInt(params[1]);
                     this.zoneEfficiencyPercent = parseInt(params[2]);
                  }
                  else
                  {
                     this.zoneEfficiencyPercent = parseInt(params[1]);
                     this.zoneMaxEfficiency = parseInt(params[2]);
                  }
                  break;
               case 4:
                  this.zoneSize = parseInt(params[0]);
                  this.zoneMinSize = parseInt(params[1]);
                  this.zoneEfficiencyPercent = parseInt(params[2]);
                  this.zoneMaxEfficiency = parseInt(params[3]);
                  break;
            }
            this._rawZoneInit = true;
         }
         else
         {
            _log.error("Zone incorrect (" + this.rawZone + ")");
         }
      }
      
      private function prepareDescription(desc:String, effectId:uint) : String {
         var aTmp:Array = null;
         var nYear:String = null;
         var nMonth:String = null;
         var nDay:String = null;
         var nHours:String = null;
         var nMinutes:String = null;
         var lang:String = null;
         if(desc == null)
         {
            return "";
         }
         var sEffect:String = "";
         if(desc.indexOf("#") != -1)
         {
            aTmp = [this.parameter0,this.parameter1,this.parameter2,this.parameter3,this.parameter4];
            switch(effectId)
            {
               case 10:
                  aTmp[2] = this.getEmoticonName(aTmp[0]);
                  break;
               case 165:
               case 1084:
                  aTmp[0] = this.getItemTypeName(aTmp[0]);
                  break;
               case 197:
               case 181:
               case 185:
                  aTmp[0] = this.getMonsterName(aTmp[0]);
                  break;
               case 281:
               case 282:
               case 283:
               case 284:
               case 285:
               case 286:
               case 287:
               case 288:
               case 289:
               case 290:
               case 291:
               case 292:
               case 293:
               case 294:
               case 1160:
                  aTmp[0] = this.getSpellName(aTmp[0]);
                  break;
               case 406:
                  aTmp[2] = this.getSpellName(aTmp[2]);
                  break;
               case 603:
               case 615:
                  aTmp[2] = this.getJobName(aTmp[0]);
                  break;
               case 604:
                  if(aTmp[2] == null)
                  {
                     aTmp[2] = aTmp[0];
                  }
                  aTmp[2] = this.getSpellLevelName(aTmp[2]);
                  break;
               case 614:
               case 1050:
                  aTmp[0] = aTmp[2];
                  aTmp[1] = this.getJobName(aTmp[1]);
                  break;
               case 616:
               case 624:
                  aTmp[2] = this.getSpellName(aTmp[0]);
                  break;
               case 620:
                  aTmp[2] = this.getDocumentTitle(aTmp[0]);
                  break;
               case 621:
                  aTmp[2] = this.getMonsterName(aTmp[1]);
                  break;
               case 623:
               case 628:
                  aTmp[1] = this.getMonsterGrade(aTmp[2],aTmp[0]);
                  aTmp[2] = this.getMonsterName(aTmp[2]);
                  break;
               case 649:
               case 960:
                  aTmp[2] = this.getAlignmentSideName(aTmp[0]);
                  break;
               case 669:
                  break;
               case 699:
                  aTmp[0] = this.getJobName(aTmp[0]);
                  break;
               case 706:
                  break;
               case 715:
                  aTmp[0] = this.getMonsterSuperRaceName(aTmp[0]);
                  break;
               case 716:
                  aTmp[0] = this.getMonsterRaceName(aTmp[0]);
                  break;
               case 717:
               case 1008:
               case 1011:
                  aTmp[0] = this.getMonsterName(aTmp[0]);
                  break;
               case 724:
                  aTmp[2] = this.getTitleName(aTmp[0]);
                  break;
               case 787:
               case 792:
               case 793:
               case 1017:
               case 1018:
               case 1019:
               case 1035:
               case 1036:
               case 1044:
               case 1045:
                  aTmp[0] = this.getSpellName(aTmp[0]);
                  trace("nom du sort " + aTmp[0]);
                  break;
               case 800:
                  aTmp[2] = aTmp[0];
                  break;
               case 806:
                  if(aTmp[1] > 6)
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.fat",[aTmp[1]]);
                  }
                  else if(aTmp[2] > 6)
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.lean",[aTmp[2]]);
                  }
                  else if((this is EffectInstanceInteger) && (aTmp[0] > 6))
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.lean",[aTmp[0]]);
                  }
                  else
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.nominal");
                  }
                  
                  
                  break;
               case 807:
                  if(aTmp[0])
                  {
                     aTmp[0] = this.getItemName(aTmp[0]);
                  }
                  else
                  {
                     aTmp[0] = I18n.getUiText("ui.common.none");
                  }
                  break;
               case 814:
               case 1151:
                  aTmp[0] = this.getItemName(aTmp[0]);
                  break;
               case 905:
                  aTmp[1] = this.getMonsterName(aTmp[1]);
                  break;
               case 939:
               case 940:
                  aTmp[2] = this.getItemName(aTmp[0]);
                  break;
               case 950:
               case 951:
               case 952:
                  if(aTmp[2])
                  {
                     aTmp[2] = this.getSpellStateName(aTmp[2]);
                  }
                  else
                  {
                     aTmp[2] = this.getSpellStateName(aTmp[0]);
                  }
                  break;
               case 961:
               case 962:
                  aTmp[2] = aTmp[0];
                  break;
               case 982:
                  break;
               case 988:
               case 987:
               case 985:
               case 996:
                  aTmp[3] = "{player," + aTmp[3] + "}";
                  break;
               case 1111:
                  aTmp[2] = aTmp[0];
                  break;
               case 1161:
                  aTmp[0] = this.getCompanionName(aTmp[0]);
                  break;
               case 805:
               case 808:
               case 983:
                  aTmp[2] = aTmp[2] == undefined?0:aTmp[2];
                  nYear = aTmp[0];
                  nMonth = aTmp[1].substr(0,2);
                  nDay = aTmp[1].substr(2,2);
                  nHours = aTmp[2].substr(0,2);
                  nMinutes = aTmp[2].substr(2,2);
                  lang = XmlConfig.getInstance().getEntry("config.lang.current");
                  switch(lang)
                  {
                     case LanguageEnum.LANG_FR:
                        aTmp[0] = nDay + "/" + nMonth + "/" + nYear + " " + nHours + ":" + nMinutes;
                        break;
                     case LanguageEnum.LANG_EN:
                        aTmp[0] = nMonth + "/" + nDay + "/" + nYear + " " + nHours + ":" + nMinutes;
                        break;
                     default:
                        aTmp[0] = nMonth + "/" + nDay + "/" + nYear + " " + nHours + ":" + nMinutes;
                  }
                  break;
            }
            sEffect = PatternDecoder.getDescription(desc,aTmp);
            if((sEffect == null) || (sEffect == ""))
            {
               return "";
            }
         }
         else
         {
            sEffect = desc;
         }
         if(this.modificator != 0)
         {
            sEffect = sEffect + (" " + I18n.getUiText("ui.effect.boosted.spell.complement",[this.modificator],"%"));
         }
         if(this.random > 0)
         {
            if(this.group > 0)
            {
               sEffect = sEffect + (" (" + I18n.getUiText("ui.common.random") + ")");
            }
            else
            {
               sEffect = sEffect + (" " + I18n.getUiText("ui.effect.randomProbability",[this.random],"%"));
            }
         }
         return sEffect;
      }
   }
}
