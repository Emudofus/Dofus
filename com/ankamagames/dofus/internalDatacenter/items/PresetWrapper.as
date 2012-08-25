package com.ankamagames.dofus.internalDatacenter.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.types.game.inventory.preset.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class PresetWrapper extends ItemWrapper implements IDataCenter
    {
        public var gfxId:int;
        public var _objects:Array;
        public var mount:Boolean;
        private var _uri:Uri;
        private var _pngMode:Boolean;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(PresetWrapper));

        public function PresetWrapper()
        {
            return;
        }// end function

        public function get objects() : Array
        {
            var _loc_1:MountWrapper = null;
            if (this.mount)
            {
                if (PlayedCharacterManager.getInstance().mount || !PlayedCharacterManager.getInstance().mount && this._objects[8])
                {
                    if (!(this._objects[8] is MountWrapper))
                    {
                        _loc_1 = MountWrapper.create();
                        this._objects[8] = _loc_1;
                        this._objects[8].backGroundIconUri = null;
                    }
                    else
                    {
                        this._objects[8].update(0, 0, 0, 0, null);
                    }
                }
            }
            return this._objects;
        }// end function

        public function set objects(param1:Array) : void
        {
            this._objects = param1;
            return;
        }// end function

        override public function get iconUri() : Uri
        {
            return this.getIconUri();
        }// end function

        override public function get fullSizeIconUri() : Uri
        {
            return this.getIconUri();
        }// end function

        override public function get errorIconUri() : Uri
        {
            return null;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        override public function getIconUri(param1:Boolean = true) : Uri
        {
            if (!this._uri)
            {
                this._pngMode = false;
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.gfxId));
            }
            return this._uri;
        }// end function

        override public function get info1() : String
        {
            return null;
        }// end function

        override public function get timer() : int
        {
            return 0;
        }// end function

        override public function get active() : Boolean
        {
            return true;
        }// end function

        public function updateObject(param1:PresetItem) : void
        {
            var _loc_3:Uri = null;
            var _loc_5:uint = 0;
            var _loc_2:* = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
            var _loc_4:* = param1.position;
            if (this._objects[_loc_4])
            {
                if (this._objects[_loc_4].objectGID == param1.objGid)
                {
                    if (param1.objUid)
                    {
                        this._objects[_loc_4] = InventoryManager.getInstance().inventory.getItem(param1.objUid);
                        if (this._objects[_loc_4])
                        {
                            this._objects[_loc_4].backGroundIconUri = null;
                        }
                    }
                    else
                    {
                        _loc_5 = param1.objGid;
                        this._objects[_loc_4] = ItemWrapper.create(0, 0, _loc_5, 1, null, false);
                        this._objects[_loc_4].backGroundIconUri = _loc_2;
                        this._objects[_loc_4].active = false;
                    }
                }
                else if (param1.objGid == 0 && param1.objUid == 0)
                {
                    switch(_loc_4)
                    {
                        case 9:
                        case 10:
                        case 11:
                        case 12:
                        case 13:
                        case 14:
                        {
                            _loc_3 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                            break;
                        }
                        default:
                        {
                            _loc_3 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc_4);
                            break;
                            break;
                        }
                    }
                    this._objects[_loc_4] = SimpleTextureWrapper.create(_loc_3);
                }
            }
            return;
        }// end function

        override public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        override public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public static function create(param1:int, param2:int, param3:Vector.<PresetItem>, param4:Boolean = false) : PresetWrapper
        {
            var _loc_7:Uri = null;
            var _loc_9:Boolean = false;
            var _loc_10:PresetItem = null;
            var _loc_11:MountWrapper = null;
            var _loc_5:* = new PresetWrapper;
            new PresetWrapper.id = param1;
            _loc_5.gfxId = param2;
            _loc_5.objects = new Array(16);
            _loc_5.mount = param4;
            var _loc_6:* = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
            var _loc_8:int = 0;
            while (_loc_8 < 16)
            {
                
                _loc_9 = false;
                for each (_loc_10 in param3)
                {
                    
                    if (_loc_10.position == _loc_8)
                    {
                        if (_loc_10.objUid)
                        {
                            _loc_5.objects[_loc_8] = InventoryManager.getInstance().inventory.getItem(_loc_10.objUid);
                            _loc_5.objects[_loc_8].backGroundIconUri = null;
                        }
                        else
                        {
                            _loc_5.objects[_loc_8] = ItemWrapper.create(0, 0, _loc_10.objGid, 1, null, false);
                            _loc_5.objects[_loc_8].backGroundIconUri = _loc_6;
                            _loc_5.objects[_loc_8].active = false;
                        }
                        _loc_9 = true;
                    }
                }
                if (_loc_8 == 8 && !_loc_9 && param4)
                {
                    _loc_11 = MountWrapper.create();
                    _loc_5.objects[_loc_8] = _loc_11;
                    _loc_5.objects[_loc_8].backGroundIconUri = null;
                    _loc_9 = true;
                }
                if (!_loc_9)
                {
                    switch(_loc_8)
                    {
                        case 9:
                        case 10:
                        case 11:
                        case 12:
                        case 13:
                        case 14:
                        {
                            _loc_7 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotDofus");
                            break;
                        }
                        default:
                        {
                            _loc_7 = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_slotItem" + _loc_8);
                            break;
                            break;
                        }
                    }
                    _loc_5.objects[_loc_8] = SimpleTextureWrapper.create(_loc_7);
                }
                _loc_8++;
            }
            return _loc_5;
        }// end function

    }
}
