package com.ankamagames.dofus.internalDatacenter.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.effects.instances.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.system.*;
    import flash.utils.*;

    public class ItemWrapper extends Item implements ISlotData, ICellZoneProvider, IDataCenter
    {
        private var _uriPngMode:Uri;
        private var _backGroundIconUri:Uri;
        private var _active:Boolean = true;
        private var _uri:Uri;
        private var _shortName:String;
        private var _setCount:int = 0;
        public var position:uint = 63;
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
        public var linked:Boolean;
        public var isPresetObject:Boolean;
        public var isOkForMultiUse:Boolean;
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
        public static const GID_PRESET_SHORTCUT_ITEM:int = 11589;
        private static const LEVEL_STEP:Array = [0, 10, 21, 33, 46, 60, 75, 91, 108, 126, 145, 165, 186, 208, 231, 255, 280, 306, 333, 361];
        private static const EQUIPMENT_SUPER_TYPES:Array = [1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13];
        private static const OBJECT_GID_SOULSTONE:uint = 7010;
        private static const OBJECT_GID_SOULSTONE_BOSS:uint = 10417;
        private static const OBJECT_GID_SOULSTONE_MINIBOSS:uint = 10418;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        private static var _cache:Array = new Array();
        private static var _errorIconUri:Uri;
        private static var _fullSizeErrorIconUri:Uri;
        private static var _uriLoaderContext:LoaderContext;
        private static var _properties:Array;

        public function ItemWrapper()
        {
            this.effects = new Vector.<EffectInstance>;
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this.getIconUri(true);
        }// end function

        override public function get weight() : uint
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.effects)
            {
                
                if (_loc_1.effectId == 1081)
                {
                    return realWeight + _loc_1.parameter0;
                }
            }
            return realWeight;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this.getIconUri(false);
        }// end function

        public function get backGroundIconUri() : Uri
        {
            if (!this._backGroundIconUri)
            {
                this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("bitmap/emptySlot.png"));
            }
            return this._backGroundIconUri;
        }// end function

        public function set backGroundIconUri(param1:Uri) : void
        {
            this._backGroundIconUri = param1;
            return;
        }// end function

        public function get errorIconUri() : Uri
        {
            if (!_errorIconUri)
            {
                _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
            }
            return _errorIconUri;
        }// end function

        public function get fullSizeErrorIconUri() : Uri
        {
            if (!_fullSizeErrorIconUri)
            {
                _fullSizeErrorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat("error.swf"));
            }
            return _fullSizeErrorIconUri;
        }// end function

        public function get isSpeakingObject() : Boolean
        {
            var _loc_1:* = null;
            if (this.isLivingObject)
            {
                return true;
            }
            for each (_loc_1 in this.effectsList)
            {
                
                if (_loc_1.actionId == ACTION_ID_SPEAKING_OBJECT)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function get isLivingObject() : Boolean
        {
            return this.livingObjectCategory != 0;
        }// end function

        public function get info1() : String
        {
            return this.quantity > 1 ? (this.quantity.toString()) : (null);
        }// end function

        public function get timer() : int
        {
            return 0;
        }// end function

        public function get active() : Boolean
        {
            return this._active;
        }// end function

        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            return;
        }// end function

        public function set minimalRange(param1:uint) : void
        {
            return;
        }// end function

        public function get minimalRange() : uint
        {
            return .flash_proxy::getProperty("minRange");
        }// end function

        public function set maximalRange(param1:uint) : void
        {
            return;
        }// end function

        public function get maximalRange() : uint
        {
            return .flash_proxy::getProperty("range");
        }// end function

        public function set castZoneInLine(param1:Boolean) : void
        {
            return;
        }// end function

        public function get castZoneInLine() : Boolean
        {
            return .flash_proxy::getProperty("castInLine");
        }// end function

        public function set castZoneInDiagonal(param1:Boolean) : void
        {
            return;
        }// end function

        public function get castZoneInDiagonal() : Boolean
        {
            return .flash_proxy::getProperty("castInDiagonal");
        }// end function

        public function get spellZoneEffects() : Vector.<IZoneShape>
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<IZoneShape>;
            for each (_loc_2 in this.effects)
            {
                
                _loc_3 = new ZoneEffect(_loc_2.zoneSize, _loc_2.zoneShape);
                _loc_1.push(_loc_3);
            }
            return _loc_1;
        }// end function

        public function toString() : String
        {
            return "[ItemWrapper#" + this.objectUID + "]";
        }// end function

        public function get isCertificate() : Boolean
        {
            var _loc_1:* = Item.getItemById(this.objectGID);
            return _loc_1 && _loc_1.typeId == ITEM_TYPE_CERTIFICATE;
        }// end function

        public function get isEquipment() : Boolean
        {
            var _loc_1:* = Item.getItemById(this.objectGID);
            return _loc_1 && EQUIPMENT_SUPER_TYPES.indexOf(_loc_1.type.superTypeId) != -1;
        }// end function

        public function get isUsable() : Boolean
        {
            var _loc_1:* = Item.getItemById(this.objectGID);
            return _loc_1 && (_loc_1.usable || _loc_1.targetable);
        }// end function

        public function get belongsToSet() : Boolean
        {
            var _loc_1:* = Item.getItemById(this.objectGID);
            return _loc_1 && _loc_1.itemSetId != -1;
        }// end function

        public function get favoriteEffect() : Vector.<EffectInstance>
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = new Vector.<EffectInstance>;
            if (PlayedCharacterManager.getInstance())
            {
                _loc_2 = PlayedCharacterManager.getInstance().currentSubArea;
                _loc_3 = Item.getItemById(this.objectGID);
                if (_loc_2 && _loc_3.favoriteSubAreas.indexOf(_loc_2.id) != -1)
                {
                    if (_loc_3.favoriteSubAreas && _loc_3.favoriteSubAreas.length && _loc_3.favoriteSubAreasBonus)
                    {
                        for each (_loc_5 in this.effects)
                        {
                            
                            if (_loc_5 is EffectInstanceInteger && Effect.getEffectById(_loc_5.effectId).bonusType == 1)
                            {
                                _loc_4 = _loc_5.clone();
                                EffectInstanceInteger(_loc_4).value = Math.floor(EffectInstanceInteger(_loc_4).value * _loc_3.favoriteSubAreasBonus / 100);
                                if (EffectInstanceInteger(_loc_4).value)
                                {
                                    _loc_1.push(_loc_4);
                                }
                            }
                        }
                    }
                }
            }
            return _loc_1;
        }// end function

        public function get setCount() : int
        {
            return this._setCount;
        }// end function

        override public function get name() : String
        {
            if (this.shortName == super.name)
            {
                return super.name;
            }
            switch(this.objectGID)
            {
                case OBJECT_GID_SOULSTONE_MINIBOSS:
                {
                    return I18n.getUiText("ui.item.miniboss") + I18n.getUiText("ui.common.colon") + this.shortName;
                }
                case OBJECT_GID_SOULSTONE_BOSS:
                {
                    return I18n.getUiText("ui.item.boss") + I18n.getUiText("ui.common.colon") + this.shortName;
                }
                case OBJECT_GID_SOULSTONE:
                {
                    return I18n.getUiText("ui.item.soul") + I18n.getUiText("ui.common.colon") + this.shortName;
                }
                default:
                {
                    return super.name;
                    break;
                }
            }
        }// end function

        public function get shortName() : String
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (!this._shortName)
            {
                switch(this.objectGID)
                {
                    case OBJECT_GID_SOULSTONE:
                    {
                        _loc_1 = 0;
                        _loc_2 = null;
                        for each (_loc_5 in this.effects)
                        {
                            
                            _loc_6 = Monster.getMonsterById(int(_loc_5.parameter2));
                            if (_loc_6)
                            {
                                _loc_7 = _loc_6.grades[(int(_loc_5.parameter0) - 1)];
                                if (_loc_7 && _loc_7.level > _loc_1)
                                {
                                    _loc_1 = _loc_7.level;
                                    _loc_2 = _loc_6.name;
                                }
                            }
                        }
                        this._shortName = _loc_2;
                        break;
                    }
                    case OBJECT_GID_SOULSTONE_MINIBOSS:
                    {
                        _loc_3 = new Array();
                        for each (_loc_5 in this.effects)
                        {
                            
                            _loc_6 = Monster.getMonsterById(int(_loc_5.parameter2));
                            if (_loc_6 && _loc_6.isMiniBoss)
                            {
                                _loc_3.push(_loc_6.name);
                            }
                        }
                        if (_loc_3.length)
                        {
                            this._shortName = _loc_3.join(", ");
                        }
                        break;
                    }
                    case OBJECT_GID_SOULSTONE_BOSS:
                    {
                        _loc_4 = new Array();
                        for each (_loc_5 in this.effects)
                        {
                            
                            _loc_6 = Monster.getMonsterById(int(_loc_5.parameter2));
                            if (_loc_6 && _loc_6.isBoss)
                            {
                                _loc_4.push(_loc_6.name);
                            }
                        }
                        if (_loc_4.length)
                        {
                            this._shortName = _loc_4.join(", ");
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            if (!this._shortName)
            {
                this._shortName = super.name;
            }
            return this._shortName;
        }// end function

        public function get realName() : String
        {
            return super.name;
        }// end function

        public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>) : void
        {
            if (this.objectGID != param3 || this.effectsList != param5)
            {
                var _loc_7:* = null;
                this._uriPngMode = null;
                this._uri = _loc_7;
            }
            this.position = param1;
            this.objectGID = param3;
            this.quantity = param4;
            this.effectsList = param5;
            this.effects = new Vector.<EffectInstance>;
            this.livingObjectCategory = 0;
            this.livingObjectId = 0;
            var _loc_6:* = Item.getItemById(param3);
            Item.getItemById(param3).copy(Item.getItemById(param3), this);
            this.updateEffects(param5);
            var _loc_7:* = this;
            var _loc_8:* = this._setCount + 1;
            _loc_7._setCount = _loc_8;
            return;
        }// end function

        public function getIconUri(param1:Boolean = true) : Uri
        {
            var _loc_3:* = null;
            if (param1 && this._uriPngMode)
            {
                return this._uriPngMode;
            }
            if (!param1 && this._uri)
            {
                return this._uri;
            }
            var _loc_2:* = Item.getItemById(this.objectGID);
            if (this.presetIcon != -1)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.presetIcon));
                if (!_uriLoaderContext)
                {
                    _uriLoaderContext = new LoaderContext();
                    AirScanner.allowByteCodeExecution(_uriLoaderContext, true);
                }
                this._uri.loaderContext = _uriLoaderContext;
                return this._uri;
            }
            if (this.isLivingObject)
            {
                _loc_3 = LivingObjectSkinJntMood.getLivingObjectSkin(this.livingObjectId ? (this.livingObjectId) : (this.objectGID), this.livingObjectMood, this.livingObjectSkin).toString();
            }
            else
            {
                _loc_3 = _loc_2 ? (_loc_2.iconId.toString()) : ("error_on_item_" + this.objectGID + ".png");
            }
            if (param1)
            {
                this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(_loc_3).concat(".png"));
                return this._uriPngMode;
            }
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(_loc_3).concat(".swf"));
            if (!_uriLoaderContext)
            {
                _uriLoaderContext = new LoaderContext();
                AirScanner.allowByteCodeExecution(_uriLoaderContext, true);
            }
            this._uri.loaderContext = _uriLoaderContext;
            return this._uri;
        }// end function

        public function clone(param1:Class = null) : ItemWrapper
        {
            if (param1 == null)
            {
                param1 = ItemWrapper;
            }
            var _loc_2:* = new param1 as ItemWrapper;
            MEMORY_LOG[_loc_2] = 1;
            _loc_2.copy(this, _loc_2);
            _loc_2.objectUID = this.objectUID;
            _loc_2.position = this.position;
            _loc_2.objectGID = this.objectGID;
            _loc_2.quantity = this.quantity;
            _loc_2.effects = this.effects;
            _loc_2.effectsList = this.effectsList;
            _loc_2.livingObjectCategory = this.livingObjectCategory;
            _loc_2.livingObjectFoodDate = this.livingObjectFoodDate;
            _loc_2.livingObjectId = this.livingObjectId;
            _loc_2.livingObjectLevel = this.livingObjectLevel;
            _loc_2.livingObjectMood = this.livingObjectMood;
            _loc_2.livingObjectSkin = this.livingObjectSkin;
            _loc_2.livingObjectXp = this.livingObjectXp;
            _loc_2.livingObjectMaxXp = this.livingObjectMaxXp;
            _loc_2.linked = this.linked;
            _loc_2.isOkForMultiUse = this.isOkForMultiUse;
            return _loc_2;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        private function updateLivingObjects(param1:EffectInstance) : void
        {
            switch(param1.effectId)
            {
                case ACTION_ID_LIVING_OBJECT_FOOD_DATE:
                {
                    this.livingObjectFoodDate = param1.description;
                    return;
                }
                case ACTION_ID_LIVING_OBJECT_ID:
                {
                    this.livingObjectId = EffectInstanceInteger(param1).value;
                    break;
                }
                case ACTION_ID_LIVING_OBJECT_MOOD:
                {
                    this.livingObjectMood = EffectInstanceInteger(param1).value;
                    break;
                }
                case ACTION_ID_LIVING_OBJECT_SKIN:
                {
                    this.livingObjectSkin = EffectInstanceInteger(param1).value;
                    break;
                }
                case ACTION_ID_LIVING_OBJECT_CATEGORY:
                {
                    this.livingObjectCategory = EffectInstanceInteger(param1).value;
                    break;
                }
                case ACTION_ID_LIVING_OBJECT_LEVEL:
                {
                    this.livingObjectLevel = this.getLivingObjectLevel(EffectInstanceInteger(param1).value);
                    this.livingObjectXp = EffectInstanceInteger(param1).value - LEVEL_STEP[(this.livingObjectLevel - 1)];
                    this.livingObjectMaxXp = LEVEL_STEP[this.livingObjectLevel] - LEVEL_STEP[(this.livingObjectLevel - 1)];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function updatePresets(param1:EffectInstance) : void
        {
            switch(param1.effectId)
            {
                case ACTION_ID_USE_PRESET:
                {
                    this.presetIcon = int(param1.parameter0);
                    return;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getLivingObjectLevel(param1:int) : uint
        {
            var _loc_2:* = 0;
            while (_loc_2 < LEVEL_STEP.length)
            {
                
                if (LEVEL_STEP[_loc_2] > param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return LEVEL_STEP.length;
        }// end function

        private function updateEffects(param1:Vector.<ObjectEffect>) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = Item.getItemById(this.objectGID);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (_loc_2 && _loc_2.isWeapon)
            {
                switch(_loc_2.typeId)
                {
                    case 7:
                    {
                        _loc_3 = 88;
                        _loc_4 = 1;
                        break;
                    }
                    case 4:
                    {
                        _loc_3 = 84;
                        _loc_4 = 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this.linked = false;
            this.isOkForMultiUse = false;
            for each (_loc_5 in param1)
            {
                
                _loc_6 = ObjectEffectAdapter.fromNetwork(_loc_5);
                if (_loc_3 && _loc_6.category == 2)
                {
                    _loc_6.zoneShape = _loc_3;
                    _loc_6.zoneSize = _loc_4;
                }
                this.effects.push(_loc_6);
                this.updateLivingObjects(_loc_6);
                this.updatePresets(_loc_6);
                if (_loc_6.effectId == 139 || _loc_6.effectId == 110)
                {
                    this.isOkForMultiUse = true;
                }
                if (_loc_6.effectId == 981 || _loc_6.effectId == 982 || _loc_6.effectId == 983)
                {
                    this.linked = true;
                }
            }
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>, param6:Boolean = true) : ItemWrapper
        {
            var _loc_7:* = null;
            var _loc_8:* = Item.getItemById(param3);
            if (!_cache[param2] || !param6)
            {
                if (_loc_8.isWeapon)
                {
                    _loc_7 = new WeaponWrapper();
                }
                else
                {
                    _loc_7 = new ItemWrapper;
                }
                _loc_7.objectUID = param2;
                if (param6)
                {
                    _cache[param2] = _loc_7;
                }
            }
            else
            {
                _loc_7 = _cache[param2];
            }
            MEMORY_LOG[_loc_7] = 1;
            _loc_7.effectsList = param5;
            _loc_7.isPresetObject = param3 == GID_PRESET_SHORTCUT_ITEM;
            if (_loc_7.objectGID != param3)
            {
                _loc_7._uri = null;
                _loc_7._uriPngMode = null;
            }
            _loc_8.copy(_loc_8, _loc_7);
            _loc_7.position = param1;
            _loc_7.objectGID = param3;
            _loc_7.quantity = param4;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (_loc_8 && _loc_8.isWeapon)
            {
                switch(_loc_8.typeId)
                {
                    case 7:
                    {
                        _loc_9 = 88;
                        _loc_10 = 1;
                        break;
                    }
                    case 4:
                    {
                        _loc_9 = 84;
                        _loc_10 = 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            _loc_7.livingObjectCategory = 0;
            _loc_7.effects = new Vector.<EffectInstance>;
            _loc_7.linked = false;
            _loc_7.updateEffects(param5);
            return _loc_7;
        }// end function

        public static function clearCache() : void
        {
            _cache = new Array();
            return;
        }// end function

        public static function getItemFromUId(param1:uint) : ItemWrapper
        {
            return _cache[param1];
        }// end function

    }
}
