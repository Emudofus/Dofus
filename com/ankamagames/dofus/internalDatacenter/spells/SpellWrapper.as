package com.ankamagames.dofus.internalDatacenter.spells
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.berilia.interfaces.IClonable;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.berilia.managers.SlotDataHolderManager;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import flash.utils.flash_proxy;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public dynamic class SpellWrapper extends Proxy implements ISlotData, IClonable, ICellZoneProvider, IDataCenter
   {
      
      public function SpellWrapper() {
         super();
      }
      
      private static var _cache:Array;
      
      private static var _playersCache:Dictionary;
      
      private static var _cac:Array;
      
      private static var _errorIconUri:Uri;
      
      protected static const _log:Logger;
      
      public static function create(position:int, spellID:uint, spellLevel:int, useCache:Boolean = true, playerId:int = 0) : SpellWrapper {
         var spell:SpellWrapper = null;
         var effectInstance:EffectInstance = null;
         if(spellID == 0)
         {
            useCache = false;
         }
         var position:int = 63;
         if(useCache)
         {
            if((_cache[spellID]) && (_cache[spellID].length > 0) && (_cache[spellID][position]) && (!playerId))
            {
               spell = _cache[spellID][position];
            }
            else if((_playersCache[playerId] && _playersCache[playerId][spellID]) && (_playersCache[playerId][spellID].length > 0) && (_playersCache[playerId][spellID][position]))
            {
               spell = _playersCache[playerId][spellID][position];
            }
            
         }
         if((spellID == 0) && (!(_cac == null)) && (_cac.length > 0) && (_cac[position]))
         {
            spell = _cac[position];
         }
         if(!spell)
         {
            spell = new SpellWrapper();
            spell.id = spellID;
            if(useCache)
            {
               if(playerId)
               {
                  if(!_playersCache[playerId])
                  {
                     _playersCache[playerId] = new Array();
                  }
                  if(!_playersCache[playerId][spellID])
                  {
                     _playersCache[playerId][spellID] = new Array();
                  }
                  _playersCache[playerId][spellID][position] = spell;
               }
               else
               {
                  if(!_cache[spellID])
                  {
                     _cache[spellID] = new Array();
                  }
                  _cache[spellID][position] = spell;
               }
            }
            spell._slotDataHolderManager = new SlotDataHolderManager(spell);
         }
         if(spellID == 0)
         {
            if(!_cac)
            {
               _cac = new Array();
            }
            _cac[position] = spell;
         }
         spell.id = spellID;
         spell.gfxId = spellID;
         if(position != -1)
         {
            spell.position = position;
         }
         spell.spellLevel = spellLevel;
         spell.playerId = playerId;
         spell.effects = new Vector.<EffectInstance>();
         spell.criticalEffect = new Vector.<EffectInstance>();
         var spellData:Spell = Spell.getSpellById(spellID);
         spell._spellLevel = spellData.getSpellLevel(spellLevel);
         for each(effectInstance in spell._spellLevel.effects)
         {
            effectInstance = effectInstance.clone();
            spell.effects.push(effectInstance);
         }
         for each(effectInstance in spell._spellLevel.criticalEffect)
         {
            effectInstance = effectInstance.clone();
            spell.criticalEffect.push(effectInstance);
         }
         return spell;
      }
      
      public static function getSpellWrapperById(spellId:uint, playerID:int, position:int) : SpellWrapper {
         var i:* = 0;
         if(playerID != 0)
         {
            if(!_playersCache[playerID])
            {
               return null;
            }
            if((!_playersCache[playerID][spellId]) && (_cache[spellId]))
            {
               _playersCache[playerID][spellId] = new Array();
               i = 0;
               while(i < 20)
               {
                  if(_cache[spellId][i])
                  {
                     _playersCache[playerID][spellId][i] = _cache[spellId][i].clone();
                  }
                  i++;
               }
            }
            if((spellId == 0) && (_cac) && (_cac[position]))
            {
               return _cac[position];
            }
            return _playersCache[playerID][spellId][position];
         }
         return _cache[spellId][position];
      }
      
      public static function getFirstSpellWrapperById(spellId:uint, playerID:int) : SpellWrapper {
         var array:Array = null;
         var i:* = 0;
         var j:* = 0;
         if(playerID != 0)
         {
            if(!_playersCache[playerID])
            {
               return null;
            }
            if((!_playersCache[playerID][spellId]) && (_cache[spellId]))
            {
               _playersCache[playerID][spellId] = new Array();
               i = 0;
               while(i < 20)
               {
                  if(_cache[spellId][i])
                  {
                     _playersCache[playerID][spellId][i] = _cache[spellId][i].clone();
                  }
                  i++;
               }
            }
            if((spellId == 0) && (_cac) && (_cac.length))
            {
               array = _cac;
            }
            else
            {
               array = _playersCache[playerID][spellId];
            }
         }
         else
         {
            array = _cache[spellId];
         }
         if(array)
         {
            j = 0;
            while(j < array.length)
            {
               if(array[j])
               {
                  return array[j];
               }
               j++;
            }
         }
         return null;
      }
      
      public static function getSpellWrappersById(spellId:uint, playerID:int) : Array {
         var i:* = 0;
         if(playerID != 0)
         {
            if(!_playersCache[playerID])
            {
               return null;
            }
            if((!_playersCache[playerID][spellId]) && (_cache[spellId]))
            {
               _playersCache[playerID][spellId] = new Array();
               i = 0;
               while(i < 20)
               {
                  if(_cache[spellId][i])
                  {
                     _playersCache[playerID][spellId][i] = _cache[spellId][i].clone();
                  }
                  i++;
               }
            }
            if(spellId == 0)
            {
               return _cac;
            }
            return _playersCache[playerID][spellId];
         }
         return _cache[spellId];
      }
      
      public static function refreshAllPlayerSpellHolder(playerId:int) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function resetAllCoolDown(playerId:int, accessKey:Object) : void {
         var spell:Array = null;
         var wrapper:SpellWrapper = null;
         SecureCenter.checkAccessKey(accessKey);
         for each(spell in _playersCache[playerId])
         {
            for each(wrapper in spell)
            {
               SpellWrapper(wrapper).actualCooldown = 0;
            }
         }
      }
      
      public static function removeAllSpellWrapperBut(playerId:int, accessKey:Object) : void {
         var id:String = null;
         var num:* = 0;
         var i:* = 0;
         SecureCenter.checkAccessKey(accessKey);
         var temp:Array = new Array();
         for(id in _playersCache)
         {
            if(int(id) != playerId)
            {
               temp.push(id);
            }
         }
         num = temp.length;
         i = -1;
         while(++i < num)
         {
            delete _playersCache[temp[i]];
         }
      }
      
      public static function removeAllSpellWrapper() : void {
         _playersCache = new Dictionary();
         _cache = new Array();
      }
      
      private var _uri:Uri;
      
      private var _slotDataHolderManager:SlotDataHolderManager;
      
      private var _spellLevel:SpellLevel;
      
      public var position:uint;
      
      public var id:uint = 0;
      
      public var spellLevel:int;
      
      public var effects:Vector.<EffectInstance>;
      
      public var criticalEffect:Vector.<EffectInstance>;
      
      public var gfxId:int;
      
      public var playerId:int;
      
      public var versionNum:int;
      
      private var _actualCooldown:uint = 0;
      
      public function set actualCooldown(u:uint) : void {
         this._actualCooldown = u;
         this._slotDataHolderManager.refreshAll();
      }
      
      public function get actualCooldown() : uint {
         return PlayedCharacterManager.getInstance().isFighting?this._actualCooldown:0;
      }
      
      public function get spellLevelInfos() : SpellLevel {
         return this._spellLevel;
      }
      
      public function get minimalRange() : uint {
         return this["minRange"];
      }
      
      public function get maximalRange() : uint {
         return this["range"];
      }
      
      public function get castZoneInLine() : Boolean {
         return this["castInLine"];
      }
      
      public function get castZoneInDiagonal() : Boolean {
         return this["castInDiagonal"];
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape> {
         var sl:SpellLevel = null;
         if((!(this.id == 0)) || (!PlayedCharacterManager.getInstance().currentWeapon))
         {
            sl = this.spell.getSpellLevel(this.spellLevel);
            if(sl)
            {
               return sl.spellZoneEffects;
            }
         }
         return null;
      }
      
      public function get hideEffects() : Boolean {
         if((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null)))
         {
            return (PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper).hideEffects;
         }
         var sl:SpellLevel = this.spell.getSpellLevel(this.spellLevel);
         if(sl)
         {
            return sl.hideEffects;
         }
         return false;
      }
      
      public function get backGroundIconUri() : Uri {
         if((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null)))
         {
            return new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/spells/all.swf|noIcon"));
         }
         return null;
      }
      
      public function get iconUri() : Uri {
         return this.fullSizeIconUri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if((!this._uri) || (this.id == 0))
         {
            if((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null)))
            {
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(PlayedCharacterManager.getInstance().currentWeapon.typeId));
            }
            else
            {
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(this.spell.iconId));
            }
            this._uri.tag = Slot.NEED_CACHE_AS_BITMAP;
         }
         return this._uri;
      }
      
      public function get errorIconUri() : Uri {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|noIcon"));
         }
         return _errorIconUri;
      }
      
      public function get info1() : String {
         if((this.actualCooldown == 0) || (!PlayedCharacterManager.getInstance().isFighting))
         {
            return null;
         }
         if(this.actualCooldown == 63)
         {
            return "-";
         }
         return this.actualCooldown.toString();
      }
      
      public function get startTime() : int {
         return 0;
      }
      
      public function get endTime() : int {
         return 0;
      }
      
      public function set endTime(t:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            return true;
         }
         var canCast:Boolean = CurrentPlayedFighterManager.getInstance().canCastThisSpell(this.spellId,this.spellLevel);
         return canCast;
      }
      
      public function get spell() : Spell {
         return Spell.getSpellById(this.id);
      }
      
      public function get spellId() : uint {
         return this.spell.id;
      }
      
      public function get playerCriticalRate() : int {
         var currentCriticalHitProbability:* = NaN;
         var characteristics:CharacterCharacteristicsInformations = null;
         var criticalHit:CharacterBaseCharacteristic = null;
         var agility:CharacterBaseCharacteristic = null;
         var totalCriticalHit:* = 0;
         var totalAgility:* = 0;
         var baseCritik:* = 0;
         var critikPlusBonus:* = 0;
         var critikRate:* = 0;
         if((this["isSpellWeapon"]) && (!this["isDefaultSpellWeapon"]))
         {
            currentCriticalHitProbability = this.getWeaponProperty("criticalHitProbability");
         }
         else
         {
            currentCriticalHitProbability = this.getCriticalHitProbability();
         }
         if((currentCriticalHitProbability) && (PlayedCharacterApi.knowSpell(this.spell.id) >= 0))
         {
            if((!Kernel.getWorker().contains(FightContextFrame)) || (!CurrentPlayedFighterManager.getInstance()) || (PlayedCharacterManager.getInstance().id == CurrentPlayedFighterManager.getInstance().currentFighterId))
            {
               characteristics = PlayedCharacterManager.getInstance().characteristics;
               if(characteristics)
               {
                  criticalHit = characteristics.criticalHit;
                  agility = characteristics.agility;
                  totalCriticalHit = criticalHit.alignGiftBonus + criticalHit.base + criticalHit.contextModif + criticalHit.objectsAndMountBonus;
                  totalAgility = agility.alignGiftBonus + agility.base + agility.contextModif + agility.objectsAndMountBonus;
                  if(totalAgility < 0)
                  {
                     totalAgility = 0;
                  }
                  baseCritik = currentCriticalHitProbability - totalCriticalHit;
                  critikPlusBonus = int(baseCritik * Math.E * 1.1 / Math.log(totalAgility + 12));
                  critikRate = Math.min(baseCritik,critikPlusBonus);
                  if(critikRate < 2)
                  {
                     critikRate = 2;
                  }
                  return critikRate;
               }
            }
            else
            {
               return currentCriticalHitProbability;
            }
         }
         return 0;
      }
      
      public function get playerCriticalFailureRate() : int {
         var characteristics:CharacterCharacteristicsInformations = null;
         var criticalMiss:Object = null;
         var totalCriticalMiss:* = 0;
         var currentCriticalfailProbability:Number = this.criticalFailureProbability;
         if((currentCriticalfailProbability) && (PlayedCharacterApi.knowSpell(this.spell.id) >= 0))
         {
            characteristics = PlayedCharacterManager.getInstance().characteristics;
            if(characteristics)
            {
               criticalMiss = characteristics.criticalMiss;
               totalCriticalMiss = currentCriticalfailProbability - criticalMiss.alignGiftBonus - criticalMiss.base - criticalMiss.contextModif - criticalMiss.objectsAndMountBonus;
               return totalCriticalMiss;
            }
         }
         return 0;
      }
      
      public function get maximalRangeWithBoosts() : int {
         var spellModification:CharacterSpellModification = null;
         var bonus:* = 0;
         var characteristics:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
         var boostableRange:Boolean = this._spellLevel.rangeCanBeBoosted;
         if(!boostableRange)
         {
            for each(spellModification in characteristics.spellModifications)
            {
               if((spellModification.spellId == this.id) && (spellModification.modificationType == CharacterSpellModificationTypeEnum.RANGEABLE))
               {
                  boostableRange = true;
                  break;
               }
            }
         }
         if(boostableRange)
         {
            bonus = characteristics.range.base + characteristics.range.alignGiftBonus + characteristics.range.contextModif + characteristics.range.objectsAndMountBonus;
            if(this.maximalRange + bonus < this.minimalRange)
            {
               return this.minimalRange;
            }
            return this.maximalRange + bonus;
         }
         return this.maximalRange;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean {
         return isAttribute(name);
      }
      
      override flash_proxy function getProperty(name:*) : * {
         var playedFighter:CurrentPlayedFighterManager = null;
         var spellModif:CharacterSpellModification = null;
         if(isAttribute(name))
         {
            return this[name];
         }
         if((this.id == 0) && (!(PlayedCharacterManager.getInstance().currentWeapon == null)))
         {
            return this.getWeaponProperty(name);
         }
         playedFighter = CurrentPlayedFighterManager.getInstance();
         switch(name.toString())
         {
            case "id":
            case "nameId":
            case "descriptionId":
            case "typeId":
            case "scriptParams":
            case "scriptParamsCritical":
            case "scriptId":
            case "scriptIdCritical":
            case "iconId":
            case "spellLevels":
            case "useParamCache":
            case "name":
            case "description":
               return Spell.getSpellById(this.id)[name];
            case "spellBreed":
            case "needFreeCell":
            case "needTakenCell":
            case "criticalFailureEndsTurn":
            case "criticalFailureProbability":
            case "minPlayerLevel":
            case "minRange":
            case "maxStack":
            case "globalCooldown":
               return this._spellLevel[name.toString()];
            case "criticalHitProbability":
               return this.getCriticalHitProbability();
            case "maxCastPerTurn":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN);
               if(spellModif)
               {
                  return this._spellLevel["maxCastPerTurn"] + spellModif.value.contextModif + spellModif.value.objectsAndMountBonus;
               }
               return this._spellLevel["maxCastPerTurn"];
            case "range":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.RANGE);
               if(spellModif)
               {
                  return this._spellLevel["range"] + spellModif.value.contextModif + spellModif.value.objectsAndMountBonus;
               }
               return this._spellLevel["range"];
            case "maxCastPerTarget":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET);
               if(spellModif)
               {
                  return this._spellLevel["maxCastPerTarget"] + spellModif.value.contextModif + spellModif.value.objectsAndMountBonus;
               }
               return this._spellLevel["maxCastPerTarget"];
            case "castInLine":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CAST_LINE);
               if(spellModif)
               {
                  return this._spellLevel["castInLine"] && spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.base + spellModif.value.alignGiftBonus == 0;
               }
               return this._spellLevel["castInLine"];
            case "castInDiagonal":
               return this._spellLevel["castInDiagonal"];
            case "castTestLos":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.LOS);
               if(spellModif)
               {
                  return this._spellLevel["castTestLos"] && spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.base + spellModif.value.alignGiftBonus == 0;
               }
               return this._spellLevel["castTestLos"];
            case "rangeCanBeBoosted":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.RANGEABLE);
               if(spellModif)
               {
                  return this._spellLevel["rangeCanBeBoosted"] || spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.base + spellModif.value.alignGiftBonus > 0;
               }
               return this._spellLevel["rangeCanBeBoosted"];
            case "apCost":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.AP_COST);
               if(spellModif)
               {
                  return this._spellLevel["apCost"] - (spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.base + spellModif.value.alignGiftBonus);
               }
               return this._spellLevel["apCost"];
            case "minCastInterval":
               spellModif = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CAST_INTERVAL);
               if(spellModif)
               {
                  return this._spellLevel["minCastInterval"] - (spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.base + spellModif.value.alignGiftBonus);
               }
               return this._spellLevel["minCastInterval"];
            case "isSpellWeapon":
               return this.id == 0;
            case "isDefaultSpellWeapon":
               return this.id == 0 && !PlayedCharacterManager.getInstance().currentWeapon;
            case "statesRequired":
               return this._spellLevel.statesRequired;
            case "statesForbidden":
               return this._spellLevel.statesForbidden;
            default:
               return;
         }
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : * {
         return null;
      }
      
      private function getWeaponProperty(name:*) : * {
         var modificator:* = 0;
         var weapon:ItemWrapper = PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper;
         if(!weapon)
         {
            return null;
         }
         switch(name.toString())
         {
            case "id":
               return 0;
            case "nameId":
            case "descriptionId":
            case "iconId":
            case "name":
            case "description":
            case "criticalFailureProbability":
            case "criticalHitProbability":
            case "castInLine":
            case "castInDiagonal":
            case "castTestLos":
            case "apCost":
            case "minRange":
            case "range":
               return weapon[name];
            case "isDefaultSpellWeapon":
            case "useParamCache":
            case "needTakenCell":
            case "rangeCanBeBoosted":
               return false;
            case "isSpellWeapon":
            case "needFreeCell":
            case "criticalFailureEndsTurn":
               return true;
            case "minCastInterval":
            case "minPlayerLevel":
            case "maxStack":
            case "maxCastPerTurn":
            case "maxCastPerTarget":
               return 0;
            case "typeId":
               return 24;
            case "scriptParams":
            case "scriptParamsCritical":
            case "spellLevels":
               return null;
            case "scriptId":
            case "scriptIdCritical":
            case "spellBreed":
               return 0;
            default:
               return;
         }
      }
      
      private function getCriticalHitProbability() : Number {
         var modifValue:* = 0;
         var spellModif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS);
         if(spellModif)
         {
            modifValue = spellModif.value.contextModif + spellModif.value.objectsAndMountBonus + spellModif.value.alignGiftBonus + spellModif.value.base;
            return this._spellLevel["criticalHitProbability"] > 0?Math.max(this._spellLevel["criticalHitProbability"] - modifValue,2):0;
         }
         return this._spellLevel["criticalHitProbability"];
      }
      
      public function clone() : * {
         var returnSpellWrapper:SpellWrapper = null;
         var useCache:Boolean = false;
         if((!(_cache[this.spellId] == null)) || (_playersCache[this.playerId][this.spellId]))
         {
            useCache = true;
         }
         returnSpellWrapper = SpellWrapper.create(this.position,this.id,this.spellLevel,useCache,this.playerId);
         return returnSpellWrapper;
      }
      
      public function addHolder(h:ISlotDataHolder) : void {
         this._slotDataHolderManager.addHolder(h);
      }
      
      public function setLinkedSlotData(slotData:ISlotData) : void {
         this._slotDataHolderManager.setLinkedSlotData(slotData);
      }
      
      public function removeHolder(h:ISlotDataHolder) : void {
         this._slotDataHolderManager.removeHolder(h);
      }
      
      public function toString() : String {
         return "[SpellWrapper #" + this.id + "]";
      }
   }
}
