package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.berilia.types.shortcut.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.filesystem.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;

    public class BindsManager extends GenericEventsManager
    {
        private var _aRegisterKey:Array;
        private var _loader:IResourceLoader;
        private var _loaderKeyboard:IResourceLoader;
        private var _avaibleKeyboard:Array;
        private var _waitingBinds:Array;
        private static var _self:BindsManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BindsManager));

        public function BindsManager()
        {
            this._aRegisterKey = [];
            this._avaibleKeyboard = new Array();
            if (_self != null)
            {
                throw new SingletonError("ShortcutsManager constructor should not be called directly.");
            }
            _self = this;
            return;
        }// end function

        public function get avaibleKeyboard() : Array
        {
            return this._avaibleKeyboard;
        }// end function

        public function get currentLocale() : String
        {
            return StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_BINDS, "locale");
        }// end function

        override public function initialize() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            super.initialize();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.objectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.objectLoadedFailed);
            this._loaderKeyboard = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loaderKeyboard.addEventListener(ResourceLoadedEvent.LOADED, this.keyboardFileLoaded);
            this._loaderKeyboard.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE, this.keyboardFileAllLoaded);
            this._loaderKeyboard.addEventListener(ResourceErrorEvent.ERROR, this.objectLoadedFailed);
            StoreDataManager.getInstance().registerClass(new Bind());
            this._waitingBinds = new Array();
            this._aRegisterKey = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", new Array());
            this.fillShortcutsEnum();
            var _loc_1:* = LangManager.getInstance().getEntry("config.binds.path.root").split("file://")[1];
            if (!_loc_1)
            {
                _loc_1 = LangManager.getInstance().getEntry("config.binds.path.root");
            }
            var _loc_2:* = new File(File.applicationDirectory.nativePath + File.separator + _loc_1);
            _loc_2.createDirectory();
            var _loc_3:* = _loc_2.getDirectoryListing();
            var _loc_4:* = new Array();
            for each (_loc_5 in _loc_3)
            {
                
                if (!_loc_5.isDirectory && _loc_5.extension == "xml")
                {
                    _loc_4.push(new Uri(_loc_5.url));
                }
            }
            this._loaderKeyboard.load(_loc_4);
            _loc_6 = new Bind("ALL", "ALL", true, true, true);
            this._aRegisterKey.push(_loc_6);
            return;
        }// end function

        public function get binds() : Array
        {
            return this._aRegisterKey;
        }// end function

        public function getShortcutString(param1:uint, param2:uint) : String
        {
            if (ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[param1] != null)
            {
                return ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[param1];
            }
            if (param2 == 0)
            {
                return null;
            }
            return String.fromCharCode(param2);
        }// end function

        public function getBind(param1:Bind, param2:Boolean = false) : Bind
        {
            var _loc_5:* = null;
            if (this._aRegisterKey == null)
            {
                return null;
            }
            var _loc_3:* = -1;
            var _loc_4:* = this._aRegisterKey.length;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_5 = this._aRegisterKey[_loc_3] as Bind;
                if (_loc_5.equals(param1) && (param2 || !_loc_5.disabled))
                {
                    return _loc_5;
                }
            }
            return null;
        }// end function

        public function isRegister(param1:Bind) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_2].equals(param1))
                {
                    return true;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

        public function isPermanent(param1:Bind) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_3].equals(param1))
                {
                    _loc_2 = Shortcut.getShortcutByName(this._aRegisterKey[_loc_3].targetedShortcut);
                    if (_loc_2 != null && !_loc_2.bindable)
                    {
                        return true;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function isDisabled(param1:Bind) : Boolean
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_2].equals(param1))
                {
                    _loc_3 = this._aRegisterKey[_loc_2] as Bind;
                    return _loc_3.disabled;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

        public function setDisabled(param1:Bind, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_3].equals(param1))
                {
                    _loc_4 = this._aRegisterKey[_loc_3] as Bind;
                    _loc_4.disabled = param2;
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function isRegisteredName(param1:String) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_2].targetedShortcut == param1)
                {
                    return true;
                }
                _loc_2 = _loc_2 + 1;
            }
            return false;
        }// end function

        public function canBind(param1:Bind) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.length)
            {
                
                if (ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN[_loc_2].equals(param1))
                {
                    return false;
                }
                _loc_2 = _loc_2 + 1;
            }
            return true;
        }// end function

        public function removeBind(param1:Bind) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_2].equals(param1))
                {
                    _loc_3 = Bind(this._aRegisterKey[_loc_2]).targetedShortcut;
                    Bind(this._aRegisterKey[_loc_2]).reset();
                    StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", this._aRegisterKey, true);
                    KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate, _loc_3, null);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function addBind(param1:Bind) : void
        {
            if (!this.canBind(param1))
            {
                _log.error(param1.toString() + " cannot be bind.");
                return;
            }
            this.removeBind(param1);
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (Bind(this._aRegisterKey[_loc_2]).targetedShortcut == param1.targetedShortcut)
                {
                    this._aRegisterKey.splice(_loc_2, 1, param1);
                    StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", this._aRegisterKey, true);
                    KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate, param1.targetedShortcut, param1);
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._aRegisterKey.push(param1);
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", this._aRegisterKey, true);
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate, param1.targetedShortcut, param1);
            return;
        }// end function

        public function isRegisteredShortcut(param1:Bind, param2:Boolean = false) : Boolean
        {
            return _aEvent[param1.targetedShortcut] != null || !param2 && _aEvent["ALL"];
        }// end function

        public function getBindFromShortcut(param1:String, param2:Boolean = false) : Bind
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._aRegisterKey)
            {
                
                if (_loc_3.targetedShortcut == param1 && (param2 || !_loc_3.disabled))
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function processCallback(param1, ... args) : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = undefined;
            args = Bind(param1);
            if (!this.isRegisteredShortcut(args))
            {
                return;
            }
            var _loc_5:* = true;
            if (_aEvent[args.targetedShortcut])
            {
                _loc_6 = _aEvent[args.targetedShortcut].concat(_aEvent["ALL"]);
                _loc_6.sortOn("sortIndex", Array.DESCENDING | Array.NUMERIC);
                _loc_7 = FocusHandler.getInstance().getFocus() as TextField;
                if (_loc_7 && _loc_7.parent is Input && Input(_loc_7.parent).focusEventHandlerPriority)
                {
                    _loc_8 = Input(_loc_7.parent).getUi();
                    _loc_9 = false;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_6.length)
                    {
                        
                        _loc_4 = _loc_6[_loc_10];
                        if (_loc_4 && _loc_4.listenerType == GenericListener.LISTENER_TYPE_UI && _loc_4.listenerContext && _loc_4.listenerContext.object)
                        {
                            _loc_11 = UiRootContainer(_loc_4.listenerContext.object);
                            if (_loc_11)
                            {
                                if (_loc_11.modal)
                                {
                                    _loc_9 = true;
                                }
                                if (_loc_8 == _loc_11 && !_loc_9 || _loc_11.modal == true)
                                {
                                    _loc_6 = _loc_6.splice(_loc_10, 1);
                                    _loc_6.unshift(_loc_4);
                                }
                            }
                        }
                        _loc_10 = _loc_10 + 1;
                    }
                }
                for each (_loc_4 in _loc_6)
                {
                    
                    if (!_loc_5)
                    {
                        break;
                    }
                    if (_loc_4)
                    {
                        if (Berilia.getInstance().getUi(_loc_4.listener) && Berilia.getInstance().getUi(_loc_4.listener).depth < Berilia.getInstance().highestModalDepth)
                        {
                            return;
                        }
                        _log.debug("Dispatch " + args + " to " + _loc_4.listener);
                        ModuleLogger.log(args, _loc_4.listener);
                        _loc_12 = _loc_4.getCallback().apply(null, args);
                        if (_loc_12 === null || !(_loc_12 is Boolean))
                        {
                            throw new ApiError(_loc_4.getCallback() + " does not return a Boolean value");
                        }
                        _loc_5 = !_loc_12;
                    }
                }
            }
            return;
        }// end function

        public function reset() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._aRegisterKey)
            {
                
                _loc_1[_loc_2.targetedShortcut] = _loc_2;
            }
            for each (_loc_3 in Shortcut.getShortcuts())
            {
                
                if (_loc_1[_loc_3.name] == null || _loc_1[_loc_3.name].key == null || _loc_3.defaultBind != _loc_1[_loc_3.name])
                {
                    if (_loc_3.defaultBind)
                    {
                        this.addBind(_loc_3.defaultBind.copy());
                        continue;
                    }
                    this.removeBind(_loc_1[_loc_3.name]);
                }
            }
            return;
        }// end function

        public function changeKeyboard(param1:String, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._avaibleKeyboard)
            {
                
                if (_loc_3.locale == param1)
                {
                    StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "locale", param1);
                    _loc_3.uri.tag = param2;
                    this._loader.load(_loc_3.uri);
                    break;
                }
            }
            return;
        }// end function

        public function getRegisteredBind(param1:Bind) : Bind
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aRegisterKey.length)
            {
                
                if (this._aRegisterKey[_loc_2].equals(param1))
                {
                    return this._aRegisterKey[_loc_2];
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        public function newShortcut(param1:Shortcut) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._waitingBinds.length)
            {
                
                _loc_2 = this._waitingBinds[_loc_3];
                if (_loc_2.targetedShortcut == param1.name)
                {
                    break;
                }
                _loc_3++;
            }
            if (!_loc_2)
            {
                return;
            }
            this._waitingBinds.splice(_loc_3, 1);
            if (!this.canBind(_loc_2))
            {
                _log.error(_loc_2.toString() + " cannot be bind.");
                return;
            }
            param1.defaultBind = _loc_2.copy();
            if (this.isRegister(_loc_2))
            {
                return;
            }
            for each (_loc_4 in this._aRegisterKey)
            {
                
                if (_loc_4.targetedShortcut == _loc_2.targetedShortcut)
                {
                    return;
                }
            }
            this._aRegisterKey.push(_loc_2);
            _log.debug("add " + _loc_2);
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", this._aRegisterKey, true);
            return;
        }// end function

        private function fillShortcutsEnum() : void
        {
            var _loc_1:* = null;
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("C", "", false, true));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("V", "", false, true));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(F4)", "", true, false));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(del)", "", true, true));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(tab)", "", true));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(backspace)"));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(insert)"));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(del)"));
            ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(locknum)"));
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.ESCAPE] = "(escape)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.ENTER] = "(enter)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.TAB] = "(tab)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.BACKSPACE] = "(backspace)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.UP] = "(upArrow)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.RIGHT] = "(rightArrow)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.DOWN] = "(downArrow)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.LEFT] = "(leftArrow)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.SPACE] = "(space)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.PAGE_UP] = "(pageUp)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.PAGE_DOWN] = "(pageDown)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.DELETE] = "(delete)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[144] = "(numLock)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.INSERT] = "(insert)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.END] = "(end)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F1] = "(F1)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F2] = "(F2)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F3] = "(F3)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F4] = "(F4)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F5] = "(F5)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F6] = "(F6)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F7] = "(F7)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F8] = "(F8)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F9] = "(F9)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F10] = "(F10)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F11] = "(F11)";
            ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[Keyboard.F12] = "(F12)";
            for (_loc_1 in ShortcutsEnum.BASIC_SHORTCUT_KEYCODE)
            {
                
                ShortcutsEnum.BASIC_SHORTCUT_NAME[ShortcutsEnum.BASIC_SHORTCUT_KEYCODE] = _loc_1;
            }
            return;
        }// end function

        private function parseBindsXml(param1:String, param2:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_3:* = XML(param1);
            var _loc_6:* = new Array();
            for each (_loc_7 in this._aRegisterKey)
            {
                
                _loc_6[_loc_7.targetedShortcut] = _loc_7;
            }
            _loc_8 = this._aRegisterKey.length > 0;
            for each (_loc_9 in _loc_3..bind)
            {
                
                _loc_5 = Shortcut.getShortcutByName(_loc_9..@shortcut);
                _loc_4 = new Bind(_loc_9, _loc_9..@shortcut, _loc_9..@alt == true, _loc_9..@ctrl == true, _loc_9..@shift == true);
                if (!_loc_5)
                {
                    this._waitingBinds.push(_loc_4);
                    continue;
                }
                if (!this.canBind(_loc_4))
                {
                    _log.error(_loc_4.toString() + " cannot be bind.");
                    continue;
                }
                _loc_5.defaultBind = _loc_4.copy();
                if (this.isRegister(_loc_4))
                {
                    continue;
                }
                if (_loc_6[_loc_4.targetedShortcut])
                {
                    if (param2)
                    {
                        this.addBind(_loc_4);
                    }
                    else
                    {
                        continue;
                    }
                }
                else if (!_loc_8)
                {
                    this._aRegisterKey.push(_loc_4);
                }
                _log.debug("add " + _loc_4);
            }
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS, "registeredKeys", this._aRegisterKey, true);
            return;
        }// end function

        public function objectLoaded(event:ResourceLoadedEvent) : void
        {
            this.parseBindsXml(event.resource, event.uri.tag);
            return;
        }// end function

        public function keyboardFileLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = XML(event.resource);
            this._avaibleKeyboard.push(new LocalizedKeyboard(event.uri, _loc_2.@locale, _loc_2.@description));
            return;
        }// end function

        public function keyboardFileAllLoaded(event:ResourceLoaderProgressEvent) : void
        {
            var locale:String;
            var e:* = event;
            try
            {
                locale = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_BINDS, "locale", LangManager.getInstance().getEntry("config.binds.current"));
                this.changeKeyboard(locale);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function objectLoadedFailed(event:ResourceErrorEvent) : void
        {
            _log.debug("objectLoadedFailed : " + event.uri + ", " + event.errorMsg);
            return;
        }// end function

        public static function getInstance() : BindsManager
        {
            if (_self == null)
            {
                _self = new BindsManager;
            }
            return _self;
        }// end function

        public static function destroy() : void
        {
            if (_self != null)
            {
                _self = null;
            }
            return;
        }// end function

    }
}
