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
      
      private static const _log:Logger;
      
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
      
      private static const LEVEL_STEP:Array;
      
      private static const EQUIPMENT_SUPER_TYPES:Array;
      
      private static const OBJECT_GID_SOULSTONE:uint = 7010;
      
      private static const OBJECT_GID_SOULSTONE_BOSS:uint = 10417;
      
      private static const OBJECT_GID_SOULSTONE_MINIBOSS:uint = 10418;
      
      public static var MEMORY_LOG:Dictionary;
      
      private static var _cache:Array;
      
      private static var _errorIconUri:Uri;
      
      private static var _fullSizeErrorIconUri:Uri;
      
      private static var _uriLoaderContext:LoaderContext;
      
      private static var _uniqueIndex:int;
      
      private static var _properties:Array;
      
      public static function create(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>, useCache:Boolean = true) : ItemWrapper {
         var item:ItemWrapper = null;
         var refItem:Item = Item.getItemById(objectGID);
         if((!_cache[objectUID]) || (!useCache))
         {
            if(refItem.isWeapon)
            {
               item = new WeaponWrapper();
            }
            else
            {
               item = new ItemWrapper();
            }
            item.objectUID = objectUID;
            if(useCache)
            {
               _cache[objectUID] = item;
            }
         }
         else
         {
            item = _cache[objectUID];
         }
         MEMORY_LOG[item] = 1;
         item.effectsList = newEffects;
         item.isPresetObject = objectGID == GID_PRESET_SHORTCUT_ITEM;
         if(item.objectGID != objectGID)
         {
            item._uri = null;
            item._uriPngMode = null;
         }
         refItem.copy(refItem,item);
         item.position = position;
         item.objectGID = objectGID;
         item.quantity = quantity;
         _uniqueIndex++;
         item.sortOrder = _uniqueIndex;
         item.livingObjectCategory = 0;
         item.effects = new Vector.<EffectInstance>();
         item.exchangeAllowed = true;
         item.updateEffects(newEffects);
         return item;
      }
      
      public static function clearCache() : void {
         _cache = new Array();
      }
      
      public static function getItemFromUId(objectUID:uint) : ItemWrapper {
         return _cache[objectUID];
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
         var i:EffectInstance = null;
         for each(i in this.effects)
         {
            if(i.effectId == 1081)
            {
               return realWeight + i.parameter0;
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
      
      public function set backGroundIconUri(bgUri:Uri) : void {
         this._backGroundIconUri = bgUri;
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
         var effect:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return true;
         }
         for each(effect in this.effectsList)
         {
            if(effect.actionId == ACTION_ID_SPEAKING_OBJECT)
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
         var effect:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return false;
         }
         for each(effect in this.effectsList)
         {
            if(effect.actionId == ACTION_ITEM_SKIN_ITEM)
            {
               this._mimicryItemSkinGID = (effect as ObjectEffectInteger).value;
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
      
      public function set endTime(t:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         return this._active;
      }
      
      public function set active(b:Boolean) : void {
         this._active = b;
      }
      
      public function set minimalRange(pMinRange:uint) : void {
      }
      
      public function get minimalRange() : uint {
         return hasOwnProperty("minRange")?this["minRange"]:0;
      }
      
      public function set maximalRange(pRange:uint) : void {
      }
      
      public function get maximalRange() : uint {
         return hasOwnProperty("range")?this["range"]:0;
      }
      
      public function set castZoneInLine(pCastInLine:Boolean) : void {
      }
      
      public function get castZoneInLine() : Boolean {
         return hasOwnProperty("castInLine")?this["castInLine"]:0;
      }
      
      public function set castZoneInDiagonal(pCastInDiagonal:Boolean) : void {
      }
      
      public function get castZoneInDiagonal() : Boolean {
         return hasOwnProperty("castInDiagonal")?this["castInDiagonal"]:0;
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape> {
         var i:EffectInstance = null;
         var zone:ZoneEffect = null;
         var spellEffects:Vector.<IZoneShape> = new Vector.<IZoneShape>();
         for each(i in this.effects)
         {
            zone = new ZoneEffect(uint(i.zoneSize),i.zoneShape);
            spellEffects.push(zone);
         }
         return spellEffects;
      }
      
      public function toString() : String {
         return "[ItemWrapper#" + this.objectUID + "_" + this.name + "]";
      }
      
      public function get isCertificate() : Boolean {
         var itbt:Item = Item.getItemById(this.objectGID);
         return (itbt) && (itbt.typeId == ITEM_TYPE_CERTIFICATE);
      }
      
      public function get isEquipment() : Boolean {
         var itbt:Item = Item.getItemById(this.objectGID);
         return (itbt) && (!(EQUIPMENT_SUPER_TYPES.indexOf(itbt.type.superTypeId) == -1));
      }
      
      public function get isUsable() : Boolean {
         var itbt:Item = Item.getItemById(this.objectGID);
         return (itbt) && ((itbt.usable) || (itbt.targetable));
      }
      
      public function get belongsToSet() : Boolean {
         var itbt:Item = Item.getItemById(this.objectGID);
         return (itbt) && (!(itbt.itemSetId == -1));
      }
      
      public function get favoriteEffect() : Vector.<EffectInstance> {
         var saO:Object = null;
         var itbt:Item = null;
         var boostedEffect:EffectInstance = null;
         var effect:EffectInstance = null;
         var result:Vector.<EffectInstance> = new Vector.<EffectInstance>();
         if(PlayedCharacterManager.getInstance())
         {
            saO = PlayedCharacterManager.getInstance().currentSubArea;
            itbt = Item.getItemById(this.objectGID);
            if((saO) && (!(itbt.favoriteSubAreas.indexOf(saO.id) == -1)))
            {
               if((itbt.favoriteSubAreas) && (itbt.favoriteSubAreas.length) && (itbt.favoriteSubAreasBonus))
               {
                  for each(effect in this.effects)
                  {
                     if((effect is EffectInstanceInteger) && (Effect.getEffectById(effect.effectId).bonusType == 1))
                     {
                        boostedEffect = effect.clone();
                        EffectInstanceInteger(boostedEffect).value = Math.floor(EffectInstanceInteger(boostedEffect).value * itbt.favoriteSubAreasBonus / 100);
                        if(EffectInstanceInteger(boostedEffect).value)
                        {
                           result.push(boostedEffect);
                        }
                     }
                  }
               }
            }
         }
         return result;
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
         var bestLevel:* = 0;
         var bestName:String = null;
         var miniboss:Array = null;
         var boss:Array = null;
         var effect:EffectInstance = null;
         var monster:Monster = null;
         var gradeId:* = 0;
         var grade:MonsterGrade = null;
         if(!this._shortName)
         {
            switch(this.objectGID)
            {
               case OBJECT_GID_SOULSTONE:
                  bestLevel = 0;
                  bestName = null;
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if(monster)
                     {
                        gradeId = int(effect.parameter0);
                        if((gradeId < 1) || (gradeId > monster.grades.length))
                        {
                           gradeId = monster.grades.length;
                        }
                        grade = monster.grades[gradeId - 1];
                        if((grade) && (grade.level > bestLevel))
                        {
                           bestLevel = grade.level;
                           bestName = monster.name;
                        }
                     }
                  }
                  this._shortName = bestName;
                  break;
               case OBJECT_GID_SOULSTONE_MINIBOSS:
                  miniboss = new Array();
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if((monster) && (monster.isMiniBoss))
                     {
                        miniboss.push(monster.name);
                     }
                  }
                  if(miniboss.length)
                  {
                     this._shortName = miniboss.join(", ");
                  }
                  break;
               case OBJECT_GID_SOULSTONE_BOSS:
                  boss = new Array();
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if((monster) && (monster.isBoss))
                     {
                        boss.push(monster.name);
                     }
                  }
                  if(boss.length)
                  {
                     this._shortName = boss.join(", ");
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
         return (!exchangeable) || (!this.exchangeAllowed);
      }
      
      public function update(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>) : void {
         if((!(this.objectGID == objectGID)) || (!(this.effectsList == newEffects)))
         {
            this._uri = this._uriPngMode = null;
         }
         this.position = position;
         this.objectGID = objectGID;
         this.quantity = quantity;
         this.effectsList = newEffects;
         this.effects = new Vector.<EffectInstance>();
         this.livingObjectCategory = 0;
         this.livingObjectId = 0;
         var refItem:Item = Item.getItemById(objectGID);
         refItem.copy(refItem,this);
         this.updateEffects(newEffects);
         this._setCount++;
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri {
         var iconId:String = null;
         var skinItem:Item = null;
         if((pngMode) && (this._uriPngMode))
         {
            return this._uriPngMode;
         }
         if((!pngMode) && (this._uri))
         {
            return this._uri;
         }
         var item:Item = Item.getItemById(this.objectGID);
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
            iconId = LivingObjectSkinJntMood.getLivingObjectSkin(this.livingObjectId?this.livingObjectId:this.objectGID,this.livingObjectMood,this.livingObjectSkin).toString();
         }
         else if(this.isMimicryObject)
         {
            skinItem = Item.getItemById(this._mimicryItemSkinGID);
            iconId = skinItem?skinItem.iconId.toString():"error_on_item_" + this.objectGID + ".png";
         }
         else
         {
            iconId = item?item.iconId.toString():"error_on_item_" + this.objectGID + ".png";
         }
         
         if(pngMode)
         {
            this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(iconId).concat(".png"));
            return this._uriPngMode;
         }
         this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(iconId).concat(".swf"));
         if(!_uriLoaderContext)
         {
            _uriLoaderContext = new LoaderContext();
            AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
         }
         this._uri.loaderContext = _uriLoaderContext;
         return this._uri;
      }
      
      public function clone(baseClass:Class = null) : ItemWrapper {
         if(baseClass == null)
         {
            baseClass = ItemWrapper;
         }
         var item:ItemWrapper = new baseClass() as ItemWrapper;
         MEMORY_LOG[item] = 1;
         item.copy(this,item);
         item.objectUID = this.objectUID;
         item.position = this.position;
         item.objectGID = this.objectGID;
         item.quantity = this.quantity;
         item.effects = this.effects;
         item.effectsList = this.effectsList;
         item.livingObjectCategory = this.livingObjectCategory;
         item.livingObjectFoodDate = this.livingObjectFoodDate;
         item.livingObjectId = this.livingObjectId;
         item.livingObjectLevel = this.livingObjectLevel;
         item.livingObjectMood = this.livingObjectMood;
         item.livingObjectSkin = this.livingObjectSkin;
         item.livingObjectXp = this.livingObjectXp;
         item.livingObjectMaxXp = this.livingObjectMaxXp;
         item.exchangeAllowed = this.exchangeAllowed;
         item.isOkForMultiUse = this.isOkForMultiUse;
         item.sortOrder = this.sortOrder;
         return item;
      }
      
      public function addHolder(h:ISlotDataHolder) : void {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void {
      }
      
      private function updateLivingObjects(effect:EffectInstance) : void {
         switch(effect.effectId)
         {
            case ACTION_ID_LIVING_OBJECT_FOOD_DATE:
               this.livingObjectFoodDate = effect.description;
               return;
            case ACTION_ID_LIVING_OBJECT_ID:
               this.livingObjectId = EffectInstanceInteger(effect).value;
               break;
            case ACTION_ID_LIVING_OBJECT_MOOD:
               this.livingObjectMood = EffectInstanceInteger(effect).value;
               break;
            case ACTION_ID_LIVING_OBJECT_SKIN:
               this.livingObjectSkin = EffectInstanceInteger(effect).value;
               break;
            case ACTION_ID_LIVING_OBJECT_CATEGORY:
               this.livingObjectCategory = EffectInstanceInteger(effect).value;
               break;
            case ACTION_ID_LIVING_OBJECT_LEVEL:
               this.livingObjectLevel = this.getLivingObjectLevel(EffectInstanceInteger(effect).value);
               this.livingObjectXp = EffectInstanceInteger(effect).value - LEVEL_STEP[this.livingObjectLevel - 1];
               this.livingObjectMaxXp = LEVEL_STEP[this.livingObjectLevel] - LEVEL_STEP[this.livingObjectLevel - 1];
               break;
         }
      }
      
      private function updatePresets(effect:EffectInstance) : void {
         switch(effect.effectId)
         {
            case ACTION_ID_USE_PRESET:
               this.presetIcon = int(effect.parameter0);
               return;
            default:
               return;
         }
      }
      
      private function getLivingObjectLevel(xp:int) : uint {
         var i:int = 0;
         while(i < LEVEL_STEP.length)
         {
            if(LEVEL_STEP[i] > xp)
            {
               return i;
            }
            i++;
         }
         return LEVEL_STEP.length;
      }
      
      private function updateEffects(updateEffects:Vector.<ObjectEffect>) : void {
         var effect:ObjectEffect = null;
         var effectInstance:EffectInstance = null;
         var itbt:Item = Item.getItemById(this.objectGID);
         var shape:uint = 0;
         var ray:uint = 0;
         if((itbt) && (itbt.isWeapon))
         {
            switch(itbt.typeId)
            {
               case 7:
                  shape = 88;
                  ray = 1;
                  break;
               case 4:
                  shape = 84;
                  ray = 1;
                  break;
               case 8:
                  shape = 76;
                  ray = 1;
                  break;
            }
         }
         this.exchangeAllowed = true;
         this.isOkForMultiUse = false;
         for each(effect in updateEffects)
         {
            effectInstance = ObjectEffectAdapter.fromNetwork(effect);
            if((shape) && (effectInstance.category == 2))
            {
               effectInstance.zoneShape = shape;
               effectInstance.zoneSize = ray;
            }
            this.effects.push(effectInstance);
            this.updateLivingObjects(effectInstance);
            this.updatePresets(effectInstance);
            if((effectInstance.effectId == 139) || (effectInstance.effectId == 110))
            {
               this.isOkForMultiUse = true;
            }
            if(effectInstance.effectId == 983)
            {
               this.exchangeAllowed = false;
            }
            if((effectInstance.effectId == 981) || (effectInstance.effectId == 982))
            {
               exchangeable = false;
            }
         }
      }
   }
}
