package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import flash.system.LoaderContext;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import com.ankamagames.jerakine.utils.display.spellZone.ZoneEffect;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.dofus.datacenter.livingObjects.LivingObjectSkinJntMood;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;
   
   public class ItemWrapper extends Item implements ISlotData, ICellZoneProvider, IDataCenter
   {
      
      public function ItemWrapper() {
         this.effects = new Vector.<EffectInstance>();
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemWrapper));
      
      public static const ITEM_TYPE_CERTIFICATE:uint = 97;
      
      public static const ITEM_TYPE_LIVING_OBJECT:uint = 113;
      
      public static const ACTION_ID_LIVING_OBJECT_FOOD_DATE:uint = 808;
      
      public static const ACTION_ID_LIVING_OBJECT_ID:uint = 970;
      
      public static const ACTION_ID_LIVING_OBJECT_MOOD:uint = 971;
      
      public static const ACTION_ID_LIVING_OBJECT_SKIN:uint = 972;
      
      public static const ACTION_ID_LIVING_OBJECT_CATEGORY:uint = 973;
      
      public static const ACTION_ID_LIVING_OBJECT_LEVEL:uint = 974;
      
      public static const ACTION_ID_USE_PRESET:uint = 707;
      
      public static const ACTION_ID_SPEAKING_OBJECT:uint = 1102;
      
      public static const ACTION_ITEM_SKIN_ITEM:uint = 1151;
      
      public static const GID_PRESET_SHORTCUT_ITEM:int = 11589;
      
      private static const LEVEL_STEP:Array = [0,10,21,33,46,60,75,91,108,126,145,165,186,208,231,255,280,306,333,361];
      
      private static const EQUIPMENT_SUPER_TYPES:Array = [1,2,3,4,5,7,8,10,11,12,13,23];
      
      private static const OBJECT_GID_SOULSTONE:uint = 7010;
      
      private static const OBJECT_GID_SOULSTONE_BOSS:uint = 10417;
      
      private static const OBJECT_GID_SOULSTONE_MINIBOSS:uint = 10418;
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static var _cache:Array = new Array();
      
      private static var _errorIconUri:Uri;
      
      private static var _fullSizeErrorIconUri:Uri;
      
      private static var _uriLoaderContext:LoaderContext;
      
      private static var _uniqueIndex:int;
      
      private static var _properties:Array;
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>, param6:Boolean=true) : ItemWrapper {
         var _loc7_:ItemWrapper = null;
         var _loc8_:Item = Item.getItemById(param3);
         if(!_cache[param2] || !param6)
         {
            if(_loc8_.isWeapon)
            {
               _loc7_ = new WeaponWrapper();
            }
            else
            {
               _loc7_ = new ItemWrapper();
            }
            _loc7_.objectUID = param2;
            if(param6)
            {
               _cache[param2] = _loc7_;
            }
         }
         else
         {
            _loc7_ = _cache[param2];
         }
         MEMORY_LOG[_loc7_] = 1;
         _loc7_.effectsList = param5;
         _loc7_.isPresetObject = param3 == GID_PRESET_SHORTCUT_ITEM;
         if(_loc7_.objectGID != param3)
         {
            _loc7_._uri = null;
            _loc7_._uriPngMode = null;
         }
         _loc8_.copy(_loc8_,_loc7_);
         _loc7_.position = param1;
         _loc7_.objectGID = param3;
         _loc7_.quantity = param4;
         _uniqueIndex++;
         _loc7_.sortOrder = _uniqueIndex;
         _loc7_.livingObjectCategory = 0;
         _loc7_.effects = new Vector.<EffectInstance>();
         _loc7_.exchangeAllowed = true;
         _loc7_.updateEffects(param5);
         return _loc7_;
      }
      
      public static function clearCache() : void {
         _cache = new Array();
      }
      
      public static function getItemFromUId(param1:uint) : ItemWrapper {
         return _cache[param1];
      }
      
      private var _uriPngMode:Uri;
      
      private var _backGroundIconUri:Uri;
      
      private var _active:Boolean = true;
      
      private var _uri:Uri;
      
      private var _shortName:String;
      
      private var _mimicryItemSkinGID:int;
      
      private var _setCount:int = 0;
      
      public var position:uint = 63;
      
      public var sortOrder:uint = 0;
      
      public var objectUID:uint = 0;
      
      public var objectGID:uint = 0;
      
      public var quantity:uint = 0;
      
      public var effects:Vector.<EffectInstance>;
      
      public var effectsList:Vector.<ObjectEffect>;
      
      public var livingObjectId:uint;
      
      public var livingObjectMood:uint;
      
      public var livingObjectSkin:uint;
      
      public var livingObjectCategory:uint;
      
      public var livingObjectXp:uint;
      
      public var livingObjectMaxXp:uint;
      
      public var livingObjectLevel:uint;
      
      public var livingObjectFoodDate:String;
      
      public var presetIcon:int = -1;
      
      public var exchangeAllowed:Boolean;
      
      public var isPresetObject:Boolean;
      
      public var isOkForMultiUse:Boolean;
      
      public function get iconUri() : Uri {
         return this.getIconUri(true);
      }
      
      override public function get weight() : uint {
         var _loc1_:EffectInstance = null;
         for each (_loc1_ in this.effects)
         {
            if(_loc1_.effectId == 1081)
            {
               return realWeight + _loc1_.parameter0;
            }
         }
         return realWeight;
      }
      
      public function get fullSizeIconUri() : Uri {
         return this.getIconUri(false);
      }
      
      public function get backGroundIconUri() : Uri {
         if(this.linked)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/linkedSlot.png"));
         }
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(param1:Uri) : void {
         this._backGroundIconUri = param1;
      }
      
      public function get errorIconUri() : Uri {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
         }
         return _errorIconUri;
      }
      
      public function get fullSizeErrorIconUri() : Uri {
         if(!_fullSizeErrorIconUri)
         {
            _fullSizeErrorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat("error.swf"));
         }
         return _fullSizeErrorIconUri;
      }
      
      public function get isSpeakingObject() : Boolean {
         var _loc1_:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return true;
         }
         for each (_loc1_ in this.effectsList)
         {
            if(_loc1_.actionId == ACTION_ID_SPEAKING_OBJECT)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isLivingObject() : Boolean {
         return !(this.livingObjectCategory == 0);
      }
      
      public function get isMimicryObject() : Boolean {
         var _loc1_:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return false;
         }
         for each (_loc1_ in this.effectsList)
         {
            if(_loc1_.actionId == ACTION_ITEM_SKIN_ITEM)
            {
               this._mimicryItemSkinGID = (_loc1_ as ObjectEffectInteger).value;
               return true;
            }
         }
         return false;
      }
      
      public function get info1() : String {
         return this.quantity > 1?this.quantity.toString():null;
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
         return this._active;
      }
      
      public function set active(param1:Boolean) : void {
         this._active = param1;
      }
      
      public function set minimalRange(param1:uint) : void {
      }
      
      public function get minimalRange() : uint {
         return hasOwnProperty("minRange")?this["minRange"]:0;
      }
      
      public function set maximalRange(param1:uint) : void {
      }
      
      public function get maximalRange() : uint {
         return hasOwnProperty("range")?this["range"]:0;
      }
      
      public function set castZoneInLine(param1:Boolean) : void {
      }
      
      public function get castZoneInLine() : Boolean {
         return hasOwnProperty("castInLine")?this["castInLine"]:0;
      }
      
      public function set castZoneInDiagonal(param1:Boolean) : void {
      }
      
      public function get castZoneInDiagonal() : Boolean {
         return hasOwnProperty("castInDiagonal")?this["castInDiagonal"]:0;
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape> {
         var _loc2_:EffectInstance = null;
         var _loc3_:ZoneEffect = null;
         var _loc1_:Vector.<IZoneShape> = new Vector.<IZoneShape>();
         for each (_loc2_ in this.effects)
         {
            _loc3_ = new ZoneEffect(_loc2_.zoneSize,_loc2_.zoneShape);
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      public function toString() : String {
         return "[ItemWrapper#" + this.objectUID + "_" + this.name + "]";
      }
      
      public function get isCertificate() : Boolean {
         var _loc1_:Item = Item.getItemById(this.objectGID);
         return (_loc1_) && _loc1_.typeId == ITEM_TYPE_CERTIFICATE;
      }
      
      public function get isEquipment() : Boolean {
         var _loc1_:Item = Item.getItemById(this.objectGID);
         return (_loc1_) && !(EQUIPMENT_SUPER_TYPES.indexOf(_loc1_.type.superTypeId) == -1);
      }
      
      public function get isUsable() : Boolean {
         var _loc1_:Item = Item.getItemById(this.objectGID);
         return (_loc1_) && ((_loc1_.usable) || (_loc1_.targetable));
      }
      
      public function get belongsToSet() : Boolean {
         var _loc1_:Item = Item.getItemById(this.objectGID);
         return (_loc1_) && !(_loc1_.itemSetId == -1);
      }
      
      public function get favoriteEffect() : Vector.<EffectInstance> {
         var _loc2_:Object = null;
         var _loc3_:Item = null;
         var _loc4_:EffectInstance = null;
         var _loc5_:EffectInstance = null;
         var _loc1_:Vector.<EffectInstance> = new Vector.<EffectInstance>();
         if(PlayedCharacterManager.getInstance())
         {
            _loc2_ = PlayedCharacterManager.getInstance().currentSubArea;
            _loc3_ = Item.getItemById(this.objectGID);
            if((_loc2_) && !(_loc3_.favoriteSubAreas.indexOf(_loc2_.id) == -1))
            {
               if((_loc3_.favoriteSubAreas) && (_loc3_.favoriteSubAreas.length) && (_loc3_.favoriteSubAreasBonus))
               {
                  for each (_loc5_ in this.effects)
                  {
                     if(_loc5_ is EffectInstanceInteger && Effect.getEffectById(_loc5_.effectId).bonusType == 1)
                     {
                        _loc4_ = _loc5_.clone();
                        EffectInstanceInteger(_loc4_).value = Math.floor(EffectInstanceInteger(_loc4_).value * _loc3_.favoriteSubAreasBonus / 100);
                        if(EffectInstanceInteger(_loc4_).value)
                        {
                           _loc1_.push(_loc4_);
                        }
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function get setCount() : int {
         return this._setCount;
      }
      
      override public function get name() : String {
         if(this.shortName == super.name)
         {
            return super.name;
         }
         switch(this.objectGID)
         {
            case OBJECT_GID_SOULSTONE_MINIBOSS:
               return I18n.getUiText("ui.item.miniboss") + I18n.getUiText("ui.common.colon") + this.shortName;
            case OBJECT_GID_SOULSTONE_BOSS:
               return I18n.getUiText("ui.item.boss") + I18n.getUiText("ui.common.colon") + this.shortName;
            case OBJECT_GID_SOULSTONE:
               return I18n.getUiText("ui.item.soul") + I18n.getUiText("ui.common.colon") + this.shortName;
            default:
               return super.name;
         }
      }
      
      public function get shortName() : String {
         var _loc1_:* = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:EffectInstance = null;
         var _loc6_:Monster = null;
         var _loc7_:* = 0;
         var _loc8_:MonsterGrade = null;
         if(!this._shortName)
         {
            switch(this.objectGID)
            {
               case OBJECT_GID_SOULSTONE:
                  _loc1_ = 0;
                  _loc2_ = null;
                  for each (_loc5_ in this.effects)
                  {
                     _loc6_ = Monster.getMonsterById(int(_loc5_.parameter2));
                     if(_loc6_)
                     {
                        _loc7_ = int(_loc5_.parameter0);
                        if(_loc7_ < 1 || _loc7_ > _loc6_.grades.length)
                        {
                           _loc7_ = _loc6_.grades.length;
                        }
                        _loc8_ = _loc6_.grades[_loc7_-1];
                        if((_loc8_) && _loc8_.level > _loc1_)
                        {
                           _loc1_ = _loc8_.level;
                           _loc2_ = _loc6_.name;
                        }
                     }
                  }
                  this._shortName = _loc2_;
                  break;
               case OBJECT_GID_SOULSTONE_MINIBOSS:
                  _loc3_ = new Array();
                  for each (_loc5_ in this.effects)
                  {
                     _loc6_ = Monster.getMonsterById(int(_loc5_.parameter2));
                     if((_loc6_) && (_loc6_.isMiniBoss))
                     {
                        _loc3_.push(_loc6_.name);
                     }
                  }
                  if(_loc3_.length)
                  {
                     this._shortName = _loc3_.join(", ");
                  }
                  break;
               case OBJECT_GID_SOULSTONE_BOSS:
                  _loc4_ = new Array();
                  for each (_loc5_ in this.effects)
                  {
                     _loc6_ = Monster.getMonsterById(int(_loc5_.parameter2));
                     if((_loc6_) && (_loc6_.isBoss))
                     {
                        _loc4_.push(_loc6_.name);
                     }
                  }
                  if(_loc4_.length)
                  {
                     this._shortName = _loc4_.join(", ");
                  }
                  break;
            }
         }
         if(!this._shortName)
         {
            this._shortName = super.name;
         }
         return this._shortName;
      }
      
      public function get realName() : String {
         return super.name;
      }
      
      public function get linked() : Boolean {
         return !exchangeable || !this.exchangeAllowed;
      }
      
      public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>) : void {
         if(!(this.objectGID == param3) || !(this.effectsList == param5))
         {
            this._uri = this._uriPngMode = null;
         }
         this.position = param1;
         this.objectGID = param3;
         this.quantity = param4;
         this.effectsList = param5;
         this.effects = new Vector.<EffectInstance>();
         this.livingObjectCategory = 0;
         this.livingObjectId = 0;
         var _loc6_:* = Item.getItemById(param3);
         _loc6_.copy(_loc6_,this);
         this.updateEffects(param5);
         this._setCount++;
      }
      
      public function getIconUri(param1:Boolean=true) : Uri {
         var _loc3_:String = null;
         var _loc4_:Item = null;
         if((param1) && (this._uriPngMode))
         {
            return this._uriPngMode;
         }
         if(!param1 && (this._uri))
         {
            return this._uri;
         }
         var _loc2_:Item = Item.getItemById(this.objectGID);
         if(this.presetIcon != -1)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.presetIcon));
            if(!_uriLoaderContext)
            {
               _uriLoaderContext = new LoaderContext();
               AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
            }
            this._uri.loaderContext = _uriLoaderContext;
            return this._uri;
         }
         if(this.isLivingObject)
         {
            _loc3_ = LivingObjectSkinJntMood.getLivingObjectSkin(this.livingObjectId?this.livingObjectId:this.objectGID,this.livingObjectMood,this.livingObjectSkin).toString();
         }
         else
         {
            if(this.isMimicryObject)
            {
               _loc4_ = Item.getItemById(this._mimicryItemSkinGID);
               _loc3_ = _loc4_?_loc4_.iconId.toString():"error_on_item_" + this.objectGID + ".png";
            }
            else
            {
               _loc3_ = _loc2_?_loc2_.iconId.toString():"error_on_item_" + this.objectGID + ".png";
            }
         }
         if(param1)
         {
            this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(_loc3_).concat(".png"));
            return this._uriPngMode;
         }
         this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(_loc3_).concat(".swf"));
         if(!_uriLoaderContext)
         {
            _uriLoaderContext = new LoaderContext();
            AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
         }
         this._uri.loaderContext = _uriLoaderContext;
         return this._uri;
      }
      
      public function clone(param1:Class=null) : ItemWrapper {
         if(param1 == null)
         {
            param1 = ItemWrapper;
         }
         var _loc2_:ItemWrapper = new param1() as ItemWrapper;
         MEMORY_LOG[_loc2_] = 1;
         _loc2_.copy(this,_loc2_);
         _loc2_.objectUID = this.objectUID;
         _loc2_.position = this.position;
         _loc2_.objectGID = this.objectGID;
         _loc2_.quantity = this.quantity;
         _loc2_.effects = this.effects;
         _loc2_.effectsList = this.effectsList;
         _loc2_.livingObjectCategory = this.livingObjectCategory;
         _loc2_.livingObjectFoodDate = this.livingObjectFoodDate;
         _loc2_.livingObjectId = this.livingObjectId;
         _loc2_.livingObjectLevel = this.livingObjectLevel;
         _loc2_.livingObjectMood = this.livingObjectMood;
         _loc2_.livingObjectSkin = this.livingObjectSkin;
         _loc2_.livingObjectXp = this.livingObjectXp;
         _loc2_.livingObjectMaxXp = this.livingObjectMaxXp;
         _loc2_.exchangeAllowed = this.exchangeAllowed;
         _loc2_.isOkForMultiUse = this.isOkForMultiUse;
         _loc2_.sortOrder = this.sortOrder;
         return _loc2_;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
      
      private function updateLivingObjects(param1:EffectInstance) : void {
         switch(param1.effectId)
         {
            case ACTION_ID_LIVING_OBJECT_FOOD_DATE:
               this.livingObjectFoodDate = param1.description;
               return;
            case ACTION_ID_LIVING_OBJECT_ID:
               this.livingObjectId = EffectInstanceInteger(param1).value;
               break;
            case ACTION_ID_LIVING_OBJECT_MOOD:
               this.livingObjectMood = EffectInstanceInteger(param1).value;
               break;
            case ACTION_ID_LIVING_OBJECT_SKIN:
               this.livingObjectSkin = EffectInstanceInteger(param1).value;
               break;
            case ACTION_ID_LIVING_OBJECT_CATEGORY:
               this.livingObjectCategory = EffectInstanceInteger(param1).value;
               break;
            case ACTION_ID_LIVING_OBJECT_LEVEL:
               this.livingObjectLevel = this.getLivingObjectLevel(EffectInstanceInteger(param1).value);
               this.livingObjectXp = EffectInstanceInteger(param1).value - LEVEL_STEP[this.livingObjectLevel-1];
               this.livingObjectMaxXp = LEVEL_STEP[this.livingObjectLevel] - LEVEL_STEP[this.livingObjectLevel-1];
               break;
         }
      }
      
      private function updatePresets(param1:EffectInstance) : void {
         switch(param1.effectId)
         {
            case ACTION_ID_USE_PRESET:
               this.presetIcon = int(param1.parameter0);
               return;
            default:
               return;
         }
      }
      
      private function getLivingObjectLevel(param1:int) : uint {
         var _loc2_:* = 0;
         while(_loc2_ < LEVEL_STEP.length)
         {
            if(LEVEL_STEP[_loc2_] > param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return LEVEL_STEP.length;
      }
      
      private function updateEffects(param1:Vector.<ObjectEffect>) : void {
         var _loc5_:ObjectEffect = null;
         var _loc6_:EffectInstance = null;
         var _loc2_:Item = Item.getItemById(this.objectGID);
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if((_loc2_) && (_loc2_.isWeapon))
         {
            switch(_loc2_.typeId)
            {
               case 7:
                  _loc3_ = 88;
                  _loc4_ = 1;
                  break;
               case 4:
                  _loc3_ = 84;
                  _loc4_ = 1;
                  break;
               case 8:
                  _loc3_ = 76;
                  _loc4_ = 1;
                  break;
            }
         }
         this.exchangeAllowed = true;
         this.isOkForMultiUse = false;
         for each (_loc5_ in param1)
         {
            _loc6_ = ObjectEffectAdapter.fromNetwork(_loc5_);
            if((_loc3_) && _loc6_.category == 2)
            {
               _loc6_.zoneShape = _loc3_;
               _loc6_.zoneSize = _loc4_;
            }
            this.effects.push(_loc6_);
            this.updateLivingObjects(_loc6_);
            this.updatePresets(_loc6_);
            if(_loc6_.effectId == 139 || _loc6_.effectId == 110)
            {
               this.isOkForMultiUse = true;
            }
            if(_loc6_.effectId == 983)
            {
               this.exchangeAllowed = false;
            }
            if(_loc6_.effectId == 981 || _loc6_.effectId == 982)
            {
               exchangeable = false;
            }
         }
      }
   }
}
