package com.ankamagames.dofus.internalDatacenter.items
{
    import com.ankamagames.dofus.internalDatacenter.communication.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.system.*;
    import flash.utils.*;

    public class ShortcutWrapper extends Proxy implements ISlotData, IDataCenter
    {
        private var _uri:Uri;
        private var _uriFullsize:Uri;
        private var _backGroundIconUri:Uri;
        private var _active:Boolean = true;
        private var _setCount:int = 0;
        public var slot:uint = 0;
        public var id:int = 0;
        public var gid:int = 0;
        public var type:int = 0;
        public var quantity:int = 0;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutWrapper));
        private static const TYPE_ITEM_WRAPPER:int = 0;
        private static const TYPE_PRESET_WRAPPER:int = 1;
        private static const TYPE_SPELL_WRAPPER:int = 2;
        private static const TYPE_SMILEY_WRAPPER:int = 3;
        private static const TYPE_EMOTE_WRAPPER:int = 4;
        private static var _errorIconUri:Uri;
        private static var _uriLoaderContext:LoaderContext;
        private static var _properties:Array;

        public function ShortcutWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            return this.getIconUri(true);
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

        public function get info1() : String
        {
            var _loc_1:* = null;
            if (this.type == TYPE_ITEM_WRAPPER)
            {
                return this.quantity.toString();
            }
            if (this.type == TYPE_SPELL_WRAPPER)
            {
                _loc_1 = SpellWrapper.getFirstSpellWrapperById(this.id, this.getCharaId());
                return _loc_1 ? (_loc_1.info1) : ("");
            }
            return "";
        }// end function

        public function get timer() : int
        {
            var _loc_1:* = null;
            if (this.type == TYPE_EMOTE_WRAPPER)
            {
                _loc_1 = EmoteWrapper.getEmoteWrapperById(this.id);
                return _loc_1 ? (_loc_1.timer) : (0);
            }
            return 0;
        }// end function

        public function get active() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.type == TYPE_SPELL_WRAPPER)
            {
                _loc_1 = SpellWrapper.getFirstSpellWrapperById(this.id, this.getCharaId());
                return _loc_1 ? (_loc_1.active) : (false);
            }
            else if (this.type == TYPE_EMOTE_WRAPPER)
            {
                _loc_2 = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                return _loc_2.isKnownEmote(this.id);
            }
            return this._active;
        }// end function

        public function set active(param1:Boolean) : void
        {
            this._active = param1;
            return;
        }// end function

        public function get realItem() : ISlotData
        {
            var _loc_1:* = null;
            if (this.type == TYPE_ITEM_WRAPPER)
            {
                if (this.id != 0)
                {
                    _loc_1 = InventoryManager.getInstance().inventory.getItem(this.id);
                }
                else
                {
                    _loc_1 = ItemWrapper.create(0, 0, this.gid, 0, null, false);
                }
                return _loc_1;
            }
            else
            {
                if (this.type == TYPE_PRESET_WRAPPER)
                {
                    return InventoryManager.getInstance().presets[this.id];
                }
                if (this.type == TYPE_SPELL_WRAPPER)
                {
                    return SpellWrapper.getFirstSpellWrapperById(this.id, this.getCharaId());
                }
                if (this.type == TYPE_EMOTE_WRAPPER)
                {
                    return EmoteWrapper.getEmoteWrapperById(this.id);
                }
                if (this.type == TYPE_SMILEY_WRAPPER)
                {
                    return SmileyWrapper.getSmileyWrapperById(this.id);
                }
            }
            return null;
        }// end function

        override function getProperty(param1)
        {
            var itemWrapper:ItemWrapper;
            var presetWrapper:PresetWrapper;
            var emoteWrapper:EmoteWrapper;
            var spellWrapper:SpellWrapper;
            var name:* = param1;
            if (isAttribute(name))
            {
                return this[name];
            }
            if (this.type == TYPE_ITEM_WRAPPER)
            {
                if (this.id != 0)
                {
                    itemWrapper = InventoryManager.getInstance().inventory.getItem(this.id);
                }
                else
                {
                    itemWrapper = ItemWrapper.create(0, 0, this.gid, 0, null, false);
                }
                if (!itemWrapper)
                {
                    _log.debug("Null item " + this.id + " - " + this.gid);
                }
                else
                {
                    try
                    {
                        return itemWrapper[name];
                    }
                    catch (e:Error)
                    {
                        if (e.getStackTrace())
                        {
                            _log.error("Item " + id + " " + gid + " " + name + " : " + e.getStackTrace());
                        }
                        return "Error_on_item_" + name;
                    }
                }
            }
            else if (this.type == TYPE_PRESET_WRAPPER)
            {
                presetWrapper = InventoryManager.getInstance().presets[this.id];
                if (!presetWrapper)
                {
                    _log.debug("Null preset " + this.id + " - " + this.gid);
                }
                else
                {
                    try
                    {
                        return presetWrapper[name];
                    }
                    catch (e:Error)
                    {
                        if (e.getStackTrace())
                        {
                            _log.error("Preset " + id + " " + name + " : " + e.getStackTrace());
                        }
                        return "Error_on_preset_" + name;
                    }
                }
            }
            else if (this.type == TYPE_EMOTE_WRAPPER)
            {
                emoteWrapper = EmoteWrapper.getEmoteWrapperById(this.id);
                if (!emoteWrapper)
                {
                    _log.debug("Null emote " + this.id);
                }
                else
                {
                    try
                    {
                        return emoteWrapper[name];
                    }
                    catch (e:Error)
                    {
                        if (e.getStackTrace())
                        {
                            _log.error("Emote " + id + " " + name + " : " + e.getStackTrace());
                        }
                        return "Error_on_emote_" + name;
                    }
                }
            }
            else if (this.type == TYPE_SPELL_WRAPPER)
            {
                spellWrapper = SpellWrapper.getFirstSpellWrapperById(this.id, this.getCharaId());
                if (!spellWrapper)
                {
                    _log.debug("Null preset " + this.id + " - " + this.gid);
                }
                else
                {
                    try
                    {
                        return presetWrapper[name];
                    }
                    catch (e:Error)
                    {
                        if (e.getStackTrace())
                        {
                            _log.error("Preset " + id + " " + name + " : " + e.getStackTrace());
                        }
                        return "Error_on_preset_" + name;
                    }
                }
            }
            return "Error on getProperty " + name;
        }// end function

        override function callProperty(param1, ... args)
        {
            args = undefined;
            switch(QName(param1).localName)
            {
                case "toString":
                {
                    args = "[ShortcutWrapper : type " + this.type + ", id " + this.id + ", slot " + this.slot + ", gid " + this.gid + ", quantity " + this.quantity + "]";
                    break;
                }
                case "hasOwnProperty":
                {
                    args = this.hasProperty(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return args;
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            return 0;
        }// end function

        override function nextName(param1:int) : String
        {
            return "nextName";
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return false;
        }// end function

        public function update(param1:uint, param2:uint, param3:uint = 0, param4:uint = 0) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.id != param2 || this.type != param3)
            {
                var _loc_7:* = null;
                this._uriFullsize = null;
                this._uri = _loc_7;
            }
            this.slot = param1;
            this.id = param2;
            this.type = param3;
            this.gid = param4;
            this.active = true;
            if (this.type == TYPE_ITEM_WRAPPER)
            {
                if (this.id != 0)
                {
                    _loc_5 = InventoryManager.getInstance().inventory.getItem(this.id);
                }
                else
                {
                    _loc_5 = ItemWrapper.create(0, 0, this.gid, 0, null, false);
                }
                if (_loc_5)
                {
                    this.quantity = _loc_5.quantity;
                }
                if (this.quantity == 0)
                {
                    this.active = false;
                }
            }
            if (this.type == TYPE_PRESET_WRAPPER)
            {
                var _loc_7:* = null;
                this._uriFullsize = null;
                this._uri = _loc_7;
            }
            if (param3 == TYPE_EMOTE_WRAPPER)
            {
                _loc_6 = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                if (!_loc_6.isKnownEmote(param2))
                {
                    this.active = false;
                }
            }
            return;
        }// end function

        public function getIconUri(param1:Boolean = true) : Uri
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.type != TYPE_SPELL_WRAPPER || this.id != 0)
            {
                if (param1 && this._uri)
                {
                    return this._uri;
                }
                if (!param1 && this._uriFullsize)
                {
                    return this._uriFullsize;
                }
            }
            if (this.type == TYPE_ITEM_WRAPPER)
            {
                if (this.id != 0)
                {
                    _loc_2 = InventoryManager.getInstance().inventory.getItem(this.id);
                    if (_loc_2)
                    {
                        this._uri = _loc_2.iconUri;
                        this._uriFullsize = _loc_2.fullSizeIconUri;
                    }
                    else
                    {
                        var _loc_8:* = null;
                        this._uriFullsize = null;
                        this._uri = _loc_8;
                    }
                }
                else
                {
                    _loc_3 = ItemWrapper.create(0, 0, this.gid, 0, null, false);
                    if (_loc_3)
                    {
                        this._uri = _loc_3.iconUri;
                        this._uriFullsize = _loc_3.fullSizeIconUri;
                    }
                    else
                    {
                        var _loc_8:* = null;
                        this._uriFullsize = null;
                        this._uri = _loc_8;
                    }
                }
            }
            else if (this.type == TYPE_PRESET_WRAPPER)
            {
                _loc_4 = InventoryManager.getInstance().presets[this.id];
                if (_loc_4)
                {
                    this._uri = _loc_4.iconUri;
                    this._uriFullsize = _loc_4.fullSizeIconUri;
                }
                else
                {
                    var _loc_8:* = null;
                    this._uriFullsize = null;
                    this._uri = _loc_8;
                }
            }
            else if (this.type == TYPE_SPELL_WRAPPER)
            {
                _loc_5 = SpellWrapper.getFirstSpellWrapperById(this.id, this.getCharaId());
                if (_loc_5)
                {
                    this._uri = _loc_5.iconUri;
                    this._uriFullsize = _loc_5.fullSizeIconUri;
                }
                else
                {
                    var _loc_8:* = null;
                    this._uriFullsize = null;
                    this._uri = _loc_8;
                }
            }
            else if (this.type == TYPE_SMILEY_WRAPPER)
            {
                _loc_6 = SmileyWrapper.getSmileyWrapperById(this.id);
                if (_loc_6)
                {
                    this._uri = _loc_6.iconUri;
                    this._uriFullsize = _loc_6.fullSizeIconUri;
                }
                else
                {
                    var _loc_8:* = null;
                    this._uriFullsize = null;
                    this._uri = _loc_8;
                }
            }
            else if (this.type == TYPE_EMOTE_WRAPPER)
            {
                _loc_7 = EmoteWrapper.getEmoteWrapperById(this.id);
                if (_loc_7)
                {
                    this._uri = _loc_7.iconUri;
                    this._uriFullsize = _loc_7.fullSizeIconUri;
                }
                else
                {
                    var _loc_8:* = null;
                    this._uriFullsize = null;
                    this._uri = _loc_8;
                }
            }
            if (param1 && this._uri)
            {
                return this._uri;
            }
            if (!param1 && this._uriFullsize)
            {
                return this._uriFullsize;
            }
            return null;
        }// end function

        public function clone() : ShortcutWrapper
        {
            var _loc_1:* = new ShortcutWrapper();
            _loc_1.slot = this.slot;
            _loc_1.id = this.id;
            _loc_1.type = this.type;
            _loc_1.gid = this.gid;
            _loc_1.quantity = this.quantity;
            return _loc_1;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.type == TYPE_SPELL_WRAPPER)
            {
                _loc_2 = SpellWrapper.getSpellWrappersById(this.id, this.getCharaId());
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3)
                    {
                        _loc_3.addHolder(param1);
                        _loc_3.setLinkedSlotData(this);
                    }
                }
            }
            else if (this.type == TYPE_EMOTE_WRAPPER)
            {
                _loc_4 = EmoteWrapper.getEmoteWrapperById(this.id);
                if (_loc_4)
                {
                    _loc_4.addHolder(param1);
                    _loc_4.setLinkedSlotData(this);
                }
            }
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        private function getCharaId() : int
        {
            if (CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                return CurrentPlayedFighterManager.getInstance().currentFighterId;
            }
            return PlayedCharacterManager.getInstance().id;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint = 0, param4:uint = 0) : ShortcutWrapper
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_5:* = new ShortcutWrapper;
            new ShortcutWrapper.slot = param1;
            _loc_5.id = param2;
            _loc_5.type = param3;
            _loc_5.gid = param4;
            if (param3 == TYPE_ITEM_WRAPPER)
            {
                if (param2 != 0)
                {
                    _loc_6 = InventoryManager.getInstance().inventory.getItem(param2);
                }
                else
                {
                    _loc_6 = ItemWrapper.create(0, 0, param4, 0, null, false);
                }
                if (_loc_6)
                {
                    _loc_5.quantity = _loc_6.quantity;
                }
                if (_loc_5.quantity == 0)
                {
                    _loc_5.active = false;
                }
                else
                {
                    _loc_5.active = true;
                }
            }
            if (param3 == TYPE_EMOTE_WRAPPER)
            {
                _loc_7 = EmoteWrapper.create(_loc_5.id, _loc_5.slot);
                _loc_8 = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
                if (_loc_8.isKnownEmote(_loc_5.id))
                {
                    _loc_5.active = true;
                }
                else
                {
                    _loc_5.active = false;
                }
            }
            return _loc_5;
        }// end function

    }
}
