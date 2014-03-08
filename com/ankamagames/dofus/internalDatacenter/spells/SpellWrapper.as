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
   import __AS3__.vec.Vector;
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
   
   use namespace flash_proxy;
   
   public dynamic class SpellWrapper extends Proxy implements ISlotData, IClonable, ICellZoneProvider, IDataCenter
   {
      
      public function SpellWrapper() {
         super();
      }
      
      private static var _cache:Array = new Array();
      
      private static var _playersCache:Dictionary = new Dictionary();
      
      private static var _cac:Array = new Array();
      
      private static var _errorIconUri:Uri;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellWrapper));
      
      public static function create(param1:int, param2:uint, param3:int, param4:Boolean=true, param5:int=0) : SpellWrapper {
         var _loc6_:SpellWrapper = null;
         var _loc8_:EffectInstance = null;
         if(param2 == 0)
         {
            param4 = false;
         }
         var param1:* = 63;
         if(param4)
         {
            if((_cache[param2]) && (_cache[param2].length > 0) && (_cache[param2][param1]) && !param5)
            {
               _loc6_ = _cache[param2][param1];
            }
            else
            {
               if((_playersCache[param5] && _playersCache[param5][param2]) && (_playersCache[param5][param2].length > 0) && (_playersCache[param5][param2][param1]))
               {
                  _loc6_ = _playersCache[param5][param2][param1];
               }
            }
         }
         if(param2 == 0 && !(_cac == null) && _cac.length > 0 && (_cac[param1]))
         {
            _loc6_ = _cac[param1];
         }
         if(!_loc6_)
         {
            _loc6_ = new SpellWrapper();
            _loc6_.id = param2;
            if(param4)
            {
               if(param5)
               {
                  if(!_playersCache[param5])
                  {
                     _playersCache[param5] = new Array();
                  }
                  if(!_playersCache[param5][param2])
                  {
                     _playersCache[param5][param2] = new Array();
                  }
                  _playersCache[param5][param2][param1] = _loc6_;
               }
               else
               {
                  if(!_cache[param2])
                  {
                     _cache[param2] = new Array();
                  }
                  _cache[param2][param1] = _loc6_;
               }
            }
            _loc6_._slotDataHolderManager = new SlotDataHolderManager(_loc6_);
         }
         if(param2 == 0)
         {
            if(!_cac)
            {
               _cac = new Array();
            }
            _cac[param1] = _loc6_;
         }
         _loc6_.id = param2;
         _loc6_.gfxId = param2;
         if(param1 != -1)
         {
            _loc6_.position = param1;
         }
         _loc6_.spellLevel = param3;
         _loc6_.playerId = param5;
         _loc6_.effects = new Vector.<EffectInstance>();
         _loc6_.criticalEffect = new Vector.<EffectInstance>();
         var _loc7_:Spell = Spell.getSpellById(param2);
         _loc6_._spellLevel = _loc7_.getSpellLevel(param3);
         for each (_loc8_ in _loc6_._spellLevel.effects)
         {
            _loc8_ = _loc8_.clone();
            _loc6_.effects.push(_loc8_);
         }
         for each (_loc8_ in _loc6_._spellLevel.criticalEffect)
         {
            _loc8_ = _loc8_.clone();
            _loc6_.criticalEffect.push(_loc8_);
         }
         return _loc6_;
      }
      
      public static function getSpellWrapperById(param1:uint, param2:int, param3:int) : SpellWrapper {
         var _loc4_:* = 0;
         if(param2 != 0)
         {
            if(!_playersCache[param2])
            {
               return null;
            }
            if(!_playersCache[param2][param1] && (_cache[param1]))
            {
               _playersCache[param2][param1] = new Array();
               _loc4_ = 0;
               while(_loc4_ < 20)
               {
                  if(_cache[param1][_loc4_])
                  {
                     _playersCache[param2][param1][_loc4_] = _cache[param1][_loc4_].clone();
                  }
                  _loc4_++;
               }
            }
            if((param1 == 0) && (_cac) && (_cac[param3]))
            {
               return _cac[param3];
            }
            return _playersCache[param2][param1][param3];
         }
         return _cache[param1][param3];
      }
      
      public static function getFirstSpellWrapperById(param1:uint, param2:int) : SpellWrapper {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         if(param2 != 0)
         {
            if(!_playersCache[param2])
            {
               return null;
            }
            if(!_playersCache[param2][param1] && (_cache[param1]))
            {
               _playersCache[param2][param1] = new Array();
               _loc4_ = 0;
               while(_loc4_ < 20)
               {
                  if(_cache[param1][_loc4_])
                  {
                     _playersCache[param2][param1][_loc4_] = _cache[param1][_loc4_].clone();
                  }
                  _loc4_++;
               }
            }
            if((param1 == 0) && (_cac) && (_cac.length))
            {
               _loc3_ = _cac;
            }
            else
            {
               _loc3_ = _playersCache[param2][param1];
            }
         }
         else
         {
            _loc3_ = _cache[param1];
         }
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_])
               {
                  return _loc3_[_loc5_];
               }
               _loc5_++;
            }
         }
         return null;
      }
      
      public static function getSpellWrappersById(param1:uint, param2:int) : Array {
         var _loc3_:* = 0;
         if(param2 != 0)
         {
            if(!_playersCache[param2])
            {
               return null;
            }
            if(!_playersCache[param2][param1] && (_cache[param1]))
            {
               _playersCache[param2][param1] = new Array();
               _loc3_ = 0;
               while(_loc3_ < 20)
               {
                  if(_cache[param1][_loc3_])
                  {
                     _playersCache[param2][param1][_loc3_] = _cache[param1][_loc3_].clone();
                  }
                  _loc3_++;
               }
            }
            if(param1 == 0)
            {
               return _cac;
            }
            return _playersCache[param2][param1];
         }
         return _cache[param1];
      }
      
      public static function refreshAllPlayerSpellHolder(param1:int) : void {
         var _loc2_:Array = null;
         var _loc3_:SpellWrapper = null;
         var _loc4_:SpellWrapper = null;
         var _loc5_:SlotDataHolderManager = null;
         for each (_loc2_ in _playersCache[param1])
         {
            for each (_loc3_ in _loc2_)
            {
               _loc3_._slotDataHolderManager.refreshAll();
            }
         }
         if(_cac)
         {
            for each (_loc4_ in _cac)
            {
               if(_loc4_)
               {
                  _loc5_ = _loc4_._slotDataHolderManager;
                  SpellWrapper(_loc4_)._slotDataHolderManager.refreshAll();
               }
            }
         }
      }
      
      public static function resetAllCoolDown(param1:int, param2:Object) : void {
         var _loc3_:Array = null;
         var _loc4_:SpellWrapper = null;
         SecureCenter.checkAccessKey(param2);
         for each (_loc3_ in _playersCache[param1])
         {
            for each (_loc4_ in _loc3_)
            {
               SpellWrapper(_loc4_).actualCooldown = 0;
            }
         }
      }
      
      public static function removeAllSpellWrapperBut(param1:int, param2:Object) : void {
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         SecureCenter.checkAccessKey(param2);
         var _loc3_:Array = new Array();
         for (_loc4_ in _playersCache)
         {
            if(int(_loc4_) != param1)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc5_ = _loc3_.length;
         _loc6_ = -1;
         while(++_loc6_ < _loc5_)
         {
            delete _playersCache[[_loc3_[_loc6_]]];
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
      
      public function set actualCooldown(param1:uint) : void {
         this._actualCooldown = param1;
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
         var _loc1_:SpellLevel = null;
         if(!(this.id == 0) || !PlayedCharacterManager.getInstance().currentWeapon)
         {
            _loc1_ = this.spell.getSpellLevel(this.spellLevel);
            if(_loc1_)
            {
               return _loc1_.spellZoneEffects;
            }
         }
         return null;
      }
      
      public function get hideEffects() : Boolean {
         if(this.id == 0 && !(PlayedCharacterManager.getInstance().currentWeapon == null))
         {
            return (PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper).hideEffects;
         }
         var _loc1_:SpellLevel = this.spell.getSpellLevel(this.spellLevel);
         if(_loc1_)
         {
            return _loc1_.hideEffects;
         }
         return false;
      }
      
      public function get backGroundIconUri() : Uri {
         if(this.id == 0 && !(PlayedCharacterManager.getInstance().currentWeapon == null))
         {
            return new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/spells/all.swf|noIcon"));
         }
         return null;
      }
      
      public function get iconUri() : Uri {
         return this.fullSizeIconUri;
      }
      
      public function get fullSizeIconUri() : Uri {
         if(!this._uri || this.id == 0)
         {
            if(this.id == 0 && !(PlayedCharacterManager.getInstance().currentWeapon == null))
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
         if(this.actualCooldown == 0 || !PlayedCharacterManager.getInstance().isFighting)
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
      
      public function set endTime(param1:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            return true;
         }
         var _loc1_:Boolean = CurrentPlayedFighterManager.getInstance().canCastThisSpell(this.spellId,this.spellLevel);
         return _loc1_;
      }
      
      public function get spell() : Spell {
         return Spell.getSpellById(this.id);
      }
      
      public function get spellId() : uint {
         return this.spell.id;
      }
      
      public function get playerCriticalRate() : int {
         var _loc1_:* = NaN;
         var _loc2_:CharacterCharacteristicsInformations = null;
         var _loc3_:CharacterBaseCharacteristic = null;
         var _loc4_:CharacterBaseCharacteristic = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         if((this["isSpellWeapon"]) && !this["isDefaultSpellWeapon"])
         {
            _loc1_ = this.getWeaponProperty("criticalHitProbability");
         }
         else
         {
            _loc1_ = this.getCriticalHitProbability();
         }
         if((_loc1_) && PlayedCharacterApi.knowSpell(this.spell.id) >= 0)
         {
            if(!Kernel.getWorker().contains(FightContextFrame) || !CurrentPlayedFighterManager.getInstance() || PlayedCharacterManager.getInstance().id == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
               _loc2_ = PlayedCharacterManager.getInstance().characteristics;
               if(_loc2_)
               {
                  _loc3_ = _loc2_.criticalHit;
                  _loc4_ = _loc2_.agility;
                  _loc5_ = _loc3_.alignGiftBonus + _loc3_.base + _loc3_.contextModif + _loc3_.objectsAndMountBonus;
                  _loc6_ = _loc4_.alignGiftBonus + _loc4_.base + _loc4_.contextModif + _loc4_.objectsAndMountBonus;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = 0;
                  }
                  _loc7_ = _loc1_ - _loc5_;
                  _loc8_ = int(_loc7_ * Math.E * 1.1 / Math.log(_loc6_ + 12));
                  _loc9_ = Math.min(_loc7_,_loc8_);
                  if(_loc9_ < 2)
                  {
                     _loc9_ = 2;
                  }
                  return _loc9_;
               }
            }
            else
            {
               return _loc1_;
            }
         }
         return 0;
      }
      
      public function get playerCriticalFailureRate() : int {
         var _loc2_:CharacterCharacteristicsInformations = null;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc1_:Number = this.criticalFailureProbability;
         if((_loc1_) && PlayedCharacterApi.knowSpell(this.spell.id) >= 0)
         {
            _loc2_ = PlayedCharacterManager.getInstance().characteristics;
            if(_loc2_)
            {
               _loc3_ = _loc2_.criticalMiss;
               _loc4_ = _loc1_ - _loc3_.alignGiftBonus - _loc3_.base - _loc3_.contextModif - _loc3_.objectsAndMountBonus;
               return _loc4_;
            }
         }
         return 0;
      }
      
      public function get maximalRangeWithBoosts() : int {
         var _loc3_:CharacterSpellModification = null;
         var _loc4_:* = 0;
         var _loc1_:CharacterCharacteristicsInformations = PlayedCharacterManager.getInstance().characteristics;
         var _loc2_:Boolean = this._spellLevel.rangeCanBeBoosted;
         if(!_loc2_)
         {
            for each (_loc3_ in _loc1_.spellModifications)
            {
               if(_loc3_.spellId == this.id && _loc3_.modificationType == CharacterSpellModificationTypeEnum.RANGEABLE)
               {
                  _loc2_ = true;
                  break;
               }
            }
         }
         if(_loc2_)
         {
            _loc4_ = _loc1_.range.base + _loc1_.range.alignGiftBonus + _loc1_.range.contextModif + _loc1_.range.objectsAndMountBonus;
            if(this.maximalRange + _loc4_ < this.minimalRange)
            {
               return this.minimalRange;
            }
            return this.maximalRange + _loc4_;
         }
         return this.maximalRange;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return isAttribute(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         var _loc2_:CurrentPlayedFighterManager = null;
         var _loc3_:CharacterSpellModification = null;
         if(isAttribute(param1))
         {
            return this[param1];
         }
         if(this.id == 0 && !(PlayedCharacterManager.getInstance().currentWeapon == null))
         {
            return this.getWeaponProperty(param1);
         }
         _loc2_ = CurrentPlayedFighterManager.getInstance();
         switch(param1.toString())
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
               return Spell.getSpellById(this.id)[param1];
            case "spellBreed":
            case "needFreeCell":
            case "needTakenCell":
            case "criticalFailureEndsTurn":
            case "criticalFailureProbability":
            case "minPlayerLevel":
            case "minRange":
            case "maxStack":
            case "globalCooldown":
               return this._spellLevel[param1.toString()];
            case "criticalHitProbability":
               return this.getCriticalHitProbability();
            case "maxCastPerTurn":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN);
               if(_loc3_)
               {
                  return this._spellLevel["maxCastPerTurn"] + _loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus;
               }
               return this._spellLevel["maxCastPerTurn"];
            case "range":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.RANGE);
               if(_loc3_)
               {
                  return this._spellLevel["range"] + _loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus;
               }
               return this._spellLevel["range"];
            case "maxCastPerTarget":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET);
               if(_loc3_)
               {
                  return this._spellLevel["maxCastPerTarget"] + _loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus;
               }
               return this._spellLevel["maxCastPerTarget"];
            case "castInLine":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CAST_LINE);
               if(_loc3_)
               {
                  return (this._spellLevel["castInLine"]) && (_loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus + _loc3_.value.base + _loc3_.value.alignGiftBonus == 0);
               }
               return this._spellLevel["castInLine"];
            case "castInDiagonal":
               return this._spellLevel["castInDiagonal"];
            case "castTestLos":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.LOS);
               if(_loc3_)
               {
                  return (this._spellLevel["castTestLos"]) && (_loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus + _loc3_.value.base + _loc3_.value.alignGiftBonus == 0);
               }
               return this._spellLevel["castTestLos"];
            case "rangeCanBeBoosted":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.RANGEABLE);
               if(_loc3_)
               {
                  return (this._spellLevel["rangeCanBeBoosted"]) || (_loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus + _loc3_.value.base + _loc3_.value.alignGiftBonus > 0);
               }
               return this._spellLevel["rangeCanBeBoosted"];
            case "apCost":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.AP_COST);
               if(_loc3_)
               {
                  return this._spellLevel["apCost"] - (_loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus + _loc3_.value.base + _loc3_.value.alignGiftBonus);
               }
               return this._spellLevel["apCost"];
            case "minCastInterval":
               _loc3_ = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CAST_INTERVAL);
               if(_loc3_)
               {
                  return this._spellLevel["minCastInterval"] - (_loc3_.value.contextModif + _loc3_.value.objectsAndMountBonus + _loc3_.value.base + _loc3_.value.alignGiftBonus);
               }
               return this._spellLevel["minCastInterval"];
            case "isSpellWeapon":
               return this.id == 0;
            case "isDefaultSpellWeapon":
               return (this.id == 0) && (!PlayedCharacterManager.getInstance().currentWeapon);
            case "statesRequired":
               return this._spellLevel.statesRequired;
            case "statesForbidden":
               return this._spellLevel.statesForbidden;
            default:
               return;
         }
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : * {
         return null;
      }
      
      private function getWeaponProperty(param1:*) : * {
         var _loc3_:* = 0;
         var _loc2_:ItemWrapper = PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper;
         if(!_loc2_)
         {
            return null;
         }
         switch(param1.toString())
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
               return _loc2_[param1];
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
         var _loc2_:* = 0;
         var _loc1_:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(this.id,CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS);
         if(_loc1_)
         {
            _loc2_ = _loc1_.value.contextModif + _loc1_.value.objectsAndMountBonus + _loc1_.value.alignGiftBonus + _loc1_.value.base;
            return this._spellLevel["criticalHitProbability"] > 0?Math.max(this._spellLevel["criticalHitProbability"] - _loc2_,2):0;
         }
         return this._spellLevel["criticalHitProbability"];
      }
      
      public function clone() : * {
         var _loc2_:SpellWrapper = null;
         var _loc1_:* = false;
         if(!(_cache[this.spellId] == null) || (_playersCache[this.playerId][this.spellId]))
         {
            _loc1_ = true;
         }
         _loc2_ = SpellWrapper.create(this.position,this.id,this.spellLevel,_loc1_,this.playerId);
         return _loc2_;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
         this._slotDataHolderManager.addHolder(param1);
      }
      
      public function setLinkedSlotData(param1:ISlotData) : void {
         this._slotDataHolderManager.setLinkedSlotData(param1);
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
         this._slotDataHolderManager.removeHolder(param1);
      }
      
      public function toString() : String {
         return "[SpellWrapper #" + this.id + "]";
      }
   }
}
