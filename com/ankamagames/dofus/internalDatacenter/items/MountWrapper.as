package com.ankamagames.dofus.internalDatacenter.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.system.*;
    import flash.utils.*;

    public class MountWrapper extends ItemWrapper implements IDataCenter
    {
        public var mountId:int;
        private var _uri:Uri;
        private var _uriPngMode:Uri;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(MountWrapper));
        private static var _mountUtil:Object = new Object();
        private static var _uriLoaderContext:LoaderContext;

        public function MountWrapper()
        {
            return;
        }// end function

        override public function get name() : String
        {
            if (!_mountUtil)
            {
                return "";
            }
            return _mountUtil.description;
        }// end function

        override public function get description() : String
        {
            if (!_mountUtil)
            {
                return "";
            }
            var _loc_1:* = I18n.getUiText("ui.mount.description", [_mountUtil.name, _mountUtil.level, _mountUtil.xpRatio]);
            return _loc_1;
        }// end function

        override public function get isWeapon() : Boolean
        {
            return false;
        }// end function

        override public function get type() : Object
        {
            return {name:I18n.getUiText("ui.common.ride")};
        }// end function

        override public function get iconUri() : Uri
        {
            return this.getIconUri(true);
        }// end function

        override public function get fullSizeIconUri() : Uri
        {
            return this.getIconUri(false);
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
            if (param1)
            {
                this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".png"));
                return this._uriPngMode;
            }
            if (this._uri)
            {
                return this._uri;
            }
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".swf"));
            if (!_uriLoaderContext)
            {
                _uriLoaderContext = new LoaderContext();
                if (AirScanner.hasAir())
                {
                    _uriLoaderContext["allowLoadBytesCodeExecution"] = true;
                }
            }
            this._uri.loaderContext = _uriLoaderContext;
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

        override public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:Vector.<ObjectEffect>) : void
        {
            var _loc_6:EffectInstance = null;
            _mountUtil = PlayedCharacterManager.getInstance().mount;
            if (_mountUtil)
            {
                this.mountId = _mountUtil.model;
                effects = new Vector.<EffectInstance>;
                for each (_loc_6 in _mountUtil.effectList)
                {
                    
                    effects.push(_loc_6);
                }
                level = _mountUtil.level;
            }
            else
            {
                this.mountId = 0;
                effects = new Vector.<EffectInstance>;
                level = 0;
            }
            return;
        }// end function

        override public function toString() : String
        {
            return "[MountWrapper#" + this.mountId + "]";
        }// end function

        public static function create() : MountWrapper
        {
            var _loc_2:EffectInstance = null;
            var _loc_1:* = new MountWrapper;
            _mountUtil = PlayedCharacterManager.getInstance().mount;
            if (_mountUtil)
            {
                _loc_1.mountId = _mountUtil.model;
                _loc_1.effects = new Vector.<EffectInstance>;
                for each (_loc_2 in _mountUtil.effectList)
                {
                    
                    _loc_1.effects.push(_loc_2);
                }
                _loc_1.level = _mountUtil.level;
            }
            else
            {
                _loc_1.mountId = 0;
                _loc_1.effects = new Vector.<EffectInstance>;
                _loc_1.level = 0;
            }
            _loc_1.itemSetId = -1;
            return _loc_1;
        }// end function

    }
}
