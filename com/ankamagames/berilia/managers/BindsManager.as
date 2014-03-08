package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import flash.filesystem.File;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.enums.ShortcutsEnum;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import flash.text.TextField;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.types.shortcut.LocalizedKeyboard;
   import flash.ui.Keyboard;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class BindsManager extends GenericEventsManager
   {
      
      public function BindsManager() {
         this._aRegisterKey = [];
         this._avaibleKeyboard = new Array();
         super();
         if(_self != null)
         {
            throw new SingletonError("ShortcutsManager constructor should not be called directly.");
         }
         else
         {
            _self = this;
            return;
         }
      }
      
      private static var _self:BindsManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BindsManager));
      
      public static function getInstance() : BindsManager {
         if(_self == null)
         {
            _self = new BindsManager();
         }
         return _self;
      }
      
      public static function destroy() : void {
         if(_self != null)
         {
            _self = null;
         }
      }
      
      private var _aRegisterKey:Array;
      
      private var _loader:IResourceLoader;
      
      private var _loaderKeyboard:IResourceLoader;
      
      private var _avaibleKeyboard:Array;
      
      private var _waitingBinds:Array;
      
      private var _bindsToCheck:Array;
      
      private var _shortcutsLoaded:Boolean;
      
      private var _bindsLoaded:Boolean;
      
      public function get avaibleKeyboard() : Array {
         return this._avaibleKeyboard;
      }
      
      public function get currentLocale() : String {
         return StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_BINDS,"locale");
      }
      
      override public function initialize() : void {
         var _loc5_:File = null;
         var _loc6_:Bind = null;
         super.initialize();
         this._shortcutsLoaded = false;
         this._bindsLoaded = false;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.objectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
         this._loaderKeyboard = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loaderKeyboard.addEventListener(ResourceLoadedEvent.LOADED,this.keyboardFileLoaded);
         this._loaderKeyboard.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.keyboardFileAllLoaded);
         this._loaderKeyboard.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
         StoreDataManager.getInstance().registerClass(new Bind());
         this._waitingBinds = new Array();
         this._aRegisterKey = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",new Array());
         this.fillShortcutsEnum();
         var _loc1_:String = LangManager.getInstance().getEntry("config.binds.path.root").split("file://")[1];
         if(!_loc1_)
         {
            _loc1_ = LangManager.getInstance().getEntry("config.binds.path.root");
         }
         var _loc2_:File = new File(File.applicationDirectory.nativePath + File.separator + _loc1_);
         _loc2_.createDirectory();
         var _loc3_:Array = _loc2_.getDirectoryListing();
         var _loc4_:Array = new Array();
         for each (_loc5_ in _loc3_)
         {
            if(!_loc5_.isDirectory && _loc5_.extension == "xml")
            {
               _loc4_.push(new Uri(_loc5_.nativePath));
            }
         }
         this._loaderKeyboard.load(_loc4_);
         if(this._aRegisterKey.length == 0)
         {
            _loc6_ = new Bind("ALL","ALL",true,true,true);
            this._aRegisterKey.push(_loc6_);
         }
      }
      
      public function get binds() : Array {
         return this._aRegisterKey;
      }
      
      public function getShortcutString(param1:uint, param2:uint) : String {
         if(ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[param1] != null)
         {
            return ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[param1];
         }
         if(param2 == 0)
         {
            return null;
         }
         return String.fromCharCode(param2);
      }
      
      public function getBind(param1:Bind, param2:Boolean=false) : Bind {
         var _loc5_:Bind = null;
         if(this._aRegisterKey == null)
         {
            return null;
         }
         var _loc3_:* = -1;
         var _loc4_:int = this._aRegisterKey.length;
         while(++_loc3_ < _loc4_)
         {
            _loc5_ = this._aRegisterKey[_loc3_] as Bind;
            if((_loc5_) && (_loc5_.equals(param1)) && ((param2) || !_loc5_.disabled))
            {
               return _loc5_;
            }
         }
         return null;
      }
      
      public function isRegister(param1:Bind) : Boolean {
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && (this._aRegisterKey[_loc2_].equals(param1)))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isPermanent(param1:Bind) : Boolean {
         var _loc2_:Shortcut = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc3_]) && (this._aRegisterKey[_loc3_].equals(param1)))
            {
               _loc2_ = Shortcut.getShortcutByName(this._aRegisterKey[_loc3_].targetedShortcut);
               if(!(_loc2_ == null) && !_loc2_.bindable)
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function isDisabled(param1:Bind) : Boolean {
         var _loc3_:Bind = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && (this._aRegisterKey[_loc2_].equals(param1)))
            {
               _loc3_ = this._aRegisterKey[_loc2_] as Bind;
               return _loc3_.disabled;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setDisabled(param1:Bind, param2:Boolean) : void {
         var _loc4_:Bind = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc3_]) && (this._aRegisterKey[_loc3_].equals(param1)))
            {
               _loc4_ = this._aRegisterKey[_loc3_] as Bind;
               _loc4_.disabled = param2;
               return;
            }
            _loc3_++;
         }
      }
      
      public function isRegisteredName(param1:String) : Boolean {
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && this._aRegisterKey[_loc2_].targetedShortcut == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function canBind(param1:Bind) : Boolean {
         var _loc2_:uint = 0;
         while(_loc2_ < ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.length)
         {
            if(ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN[_loc2_].equals(param1))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function removeBind(param1:Bind) : void {
         var _loc3_:String = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && (this._aRegisterKey[_loc2_].equals(param1)))
            {
               _loc3_ = Bind(this._aRegisterKey[_loc2_]).targetedShortcut;
               Bind(this._aRegisterKey[_loc2_]).reset();
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,_loc3_,null);
               break;
            }
            _loc2_++;
         }
      }
      
      public function addBind(param1:Bind) : void {
         if(!this.canBind(param1))
         {
            _log.warn(param1.toString() + " cannot be bind.");
            return;
         }
         this.removeBind(param1);
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && Bind(this._aRegisterKey[_loc2_]).targetedShortcut == param1.targetedShortcut)
            {
               this._aRegisterKey.splice(_loc2_,1,param1);
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,param1.targetedShortcut,param1);
               return;
            }
            _loc2_++;
         }
         this._aRegisterKey.push(param1);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,param1.targetedShortcut,param1);
      }
      
      public function isRegisteredShortcut(param1:Bind, param2:Boolean=false) : Boolean {
         return !(_aEvent[param1.targetedShortcut] == null) || !param2 && (_aEvent["ALL"]);
      }
      
      public function getBindFromShortcut(param1:String, param2:Boolean=false) : Bind {
         var _loc3_:Bind = null;
         for each (_loc3_ in this._aRegisterKey)
         {
            if((_loc3_) && (_loc3_.targetedShortcut == param1) && ((param2) || !_loc3_.disabled))
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function processCallback(param1:*, ... rest) : void {
         var _loc4_:GenericListener = null;
         var _loc6_:Array = null;
         var _loc7_:TextField = null;
         var _loc8_:UiRootContainer = null;
         var _loc9_:* = false;
         var _loc10_:uint = 0;
         var _loc11_:UiRootContainer = null;
         var _loc12_:* = undefined;
         var _loc3_:Bind = Bind(param1);
         if(!this.isRegisteredShortcut(_loc3_))
         {
            return;
         }
         var _loc5_:* = true;
         if(_aEvent[_loc3_.targetedShortcut])
         {
            _loc6_ = _aEvent[_loc3_.targetedShortcut].concat(_aEvent["ALL"]);
            _loc6_.sortOn("sortIndex",Array.DESCENDING | Array.NUMERIC);
            _loc7_ = FocusHandler.getInstance().getFocus() as TextField;
            if((_loc7_) && (_loc7_.parent is Input) && (Input(_loc7_.parent).focusEventHandlerPriority))
            {
               _loc8_ = Input(_loc7_.parent).getUi();
               _loc9_ = false;
               _loc10_ = 0;
               while(_loc10_ < _loc6_.length)
               {
                  _loc4_ = _loc6_[_loc10_];
                  if(((_loc4_) && (_loc4_.listenerType == GenericListener.LISTENER_TYPE_UI)) && (_loc4_.listenerContext) && (_loc4_.listenerContext.object))
                  {
                     _loc11_ = UiRootContainer(_loc4_.listenerContext.object);
                     if(_loc11_)
                     {
                        if(_loc11_.modal)
                        {
                           _loc9_ = true;
                        }
                        if(_loc8_ == _loc11_ && !_loc9_ || _loc11_.modal == true)
                        {
                           _loc6_ = _loc6_.splice(_loc10_,1);
                           _loc6_.unshift(_loc4_);
                        }
                     }
                  }
                  _loc10_++;
               }
            }
            for each (_loc4_ in _loc6_)
            {
               if(!_loc5_)
               {
                  break;
               }
               if(_loc4_)
               {
                  if((Berilia.getInstance().getUi(_loc4_.listener)) && Berilia.getInstance().getUi(_loc4_.listener).depth < Berilia.getInstance().highestModalDepth)
                  {
                     return;
                  }
                  _log.info("Dispatch " + rest + " to " + _loc4_.listener);
                  ModuleLogger.log(_loc3_,_loc4_.listener);
                  _loc12_ = _loc4_.getCallback().apply(null,rest);
                  if(_loc12_ === null || !(_loc12_ is Boolean))
                  {
                     throw new ApiError(_loc4_.getCallback() + " does not return a Boolean value");
                  }
                  else
                  {
                     _loc5_ = !_loc12_;
                     continue;
                  }
               }
               else
               {
                  continue;
               }
               break;
            }
         }
      }
      
      public function reset() : void {
         var _loc2_:Bind = null;
         var _loc3_:Shortcut = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in this._aRegisterKey)
         {
            if(_loc2_)
            {
               _loc1_[_loc2_.targetedShortcut] = _loc2_;
            }
         }
         for each (_loc3_ in Shortcut.getShortcuts())
         {
            if(_loc1_[_loc3_.name] == null || _loc1_[_loc3_.name].key == null || !(_loc3_.defaultBind == _loc1_[_loc3_.name]))
            {
               if(_loc3_.defaultBind)
               {
                  this.addBind(_loc3_.defaultBind.copy());
               }
               else
               {
                  this.removeBind(_loc1_[_loc3_.name]);
               }
            }
         }
      }
      
      public function changeKeyboard(param1:String, param2:Boolean=false) : void {
         var _loc3_:LocalizedKeyboard = null;
         for each (_loc3_ in this._avaibleKeyboard)
         {
            if(_loc3_.locale == param1)
            {
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"locale",param1);
               _loc3_.uri.tag = param2;
               this._loader.load(_loc3_.uri);
               break;
            }
         }
      }
      
      public function getRegisteredBind(param1:Bind) : Bind {
         var _loc2_:uint = 0;
         while(_loc2_ < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[_loc2_]) && (this._aRegisterKey[_loc2_].equals(param1)))
            {
               return this._aRegisterKey[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function newShortcut(param1:Shortcut) : void {
         var _loc2_:Bind = null;
         var _loc4_:Bind = null;
         var _loc3_:* = 0;
         while(_loc3_ < this._waitingBinds.length)
         {
            if(this._waitingBinds[_loc3_].targetedShortcut == param1.name)
            {
               _loc2_ = this._waitingBinds[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            return;
         }
         this._waitingBinds.splice(_loc3_,1);
         if(!this.canBind(_loc2_))
         {
            _log.warn(_loc2_.toString() + " cannot be bind.");
            return;
         }
         param1.defaultBind = _loc2_.copy();
         if(this.isRegister(_loc2_))
         {
            return;
         }
         for each (_loc4_ in this._aRegisterKey)
         {
            if((_loc4_) && _loc4_.targetedShortcut == _loc2_.targetedShortcut)
            {
               return;
            }
         }
         this._aRegisterKey.push(_loc2_);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
      }
      
      public function checkBinds() : void {
         var _loc1_:* = false;
         var _loc2_:Object = null;
         this._shortcutsLoaded = true;
         if((this._shortcutsLoaded && this._bindsLoaded) && (this._bindsToCheck) && this._bindsToCheck.length > 0)
         {
            _loc1_ = false;
            for each (_loc2_ in this._bindsToCheck)
            {
               if(!Shortcut.getShortcutByName(_loc2_.bind.targetedShortcut))
               {
                  this._aRegisterKey.splice(_loc2_.index,1,null);
                  _loc1_ = true;
               }
            }
            if(_loc1_)
            {
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
            }
            this._bindsToCheck.length = 0;
         }
      }
      
      private function fillShortcutsEnum() : void {
         var _loc1_:String = null;
         ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("C","",false,true));
         ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("V","",false,true));
         ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(F4)","",true,false));
         ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(del)","",true,true));
         ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.push(new Bind("(tab)","",true));
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
         for (ShortcutsEnum.BASIC_SHORTCUT_NAME[ShortcutsEnum.BASIC_SHORTCUT_KEYCODE] in ShortcutsEnum.BASIC_SHORTCUT_KEYCODE)
         {
         }
      }
      
      private function parseBindsXml(param1:String, param2:Boolean) : void {
         var _loc4_:Bind = null;
         var _loc5_:Shortcut = null;
         var _loc7_:Bind = null;
         var _loc8_:* = false;
         var _loc9_:Array = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:XML = null;
         var _loc12_:Object = null;
         var _loc13_:uint = 0;
         var _loc14_:* = 0;
         var _loc3_:XML = XML(param1);
         var _loc6_:Array = new Array();
         for each (_loc7_ in this._aRegisterKey)
         {
            if(_loc7_)
            {
               _loc6_[_loc7_.targetedShortcut] = _loc7_;
            }
         }
         _loc8_ = this._aRegisterKey.length > 1;
         _loc9_ = new Array();
         if(_loc8_)
         {
            _loc13_ = 0;
            while(_loc13_ < this._aRegisterKey.length)
            {
               if(!this._aRegisterKey[_loc13_] || this._aRegisterKey[_loc13_].targetedShortcut == "ALL" && !(_loc13_ == this._aRegisterKey.length-1))
               {
                  if(!_loc10_)
                  {
                     _loc10_ = new Vector.<uint>(0);
                  }
                  _loc10_.push(_loc13_);
               }
               _loc13_++;
            }
            _loc14_ = _loc10_?_loc10_.length:0;
            _loc13_ = 0;
            while(_loc13_ < _loc14_)
            {
               this._aRegisterKey.splice(_loc10_[_loc13_],1);
               _loc13_++;
            }
            _loc13_ = 0;
            while(_loc13_ < this._aRegisterKey.length)
            {
               if(this._aRegisterKey[_loc13_])
               {
                  _loc9_[this._aRegisterKey[_loc13_].targetedShortcut] = 
                     {
                        "exist":(Shortcut.getShortcutByName(this._aRegisterKey[_loc13_].targetedShortcut)?true:false),
                        "bind":this._aRegisterKey[_loc13_],
                        "index":_loc13_
                     };
               }
               _loc13_++;
            }
         }
         for each (_loc11_ in _loc3_..bind)
         {
            _loc5_ = Shortcut.getShortcutByName(_loc11_..@shortcut);
            _loc4_ = new Bind(_loc11_,_loc11_..@shortcut,_loc11_..@alt == true,_loc11_..@ctrl == true,_loc11_..@shift == true);
            if(_loc9_[_loc4_.targetedShortcut])
            {
               _loc9_[_loc4_.targetedShortcut].exist = true;
            }
            if(!_loc5_)
            {
               this._waitingBinds.push(_loc4_);
            }
            else
            {
               if(!this.canBind(_loc4_))
               {
                  _log.warn(_loc4_.toString() + " cannot be bind.");
               }
               else
               {
                  _loc5_.defaultBind = _loc4_.copy();
                  if(!this.isRegister(_loc4_))
                  {
                     if(_loc6_[_loc4_.targetedShortcut])
                     {
                        if(param2)
                        {
                           this.addBind(_loc4_);
                        }
                     }
                     else
                     {
                        if(!_loc8_)
                        {
                           this._aRegisterKey.push(_loc4_);
                        }
                     }
                  }
               }
            }
         }
         if(!this._shortcutsLoaded)
         {
            this._bindsToCheck = new Array();
         }
         for each (_loc12_ in _loc9_)
         {
            if(!_loc12_.exist || (this._shortcutsLoaded) && !Shortcut.getShortcutByName(_loc12_.bind.targetedShortcut))
            {
               if(!this._shortcutsLoaded)
               {
                  this._bindsToCheck.push(_loc12_);
               }
               else
               {
                  this._aRegisterKey.splice(_loc12_.index,1,null);
               }
            }
         }
         this._bindsLoaded = true;
         if(this._shortcutsLoaded)
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
         }
      }
      
      public function objectLoaded(param1:ResourceLoadedEvent) : void {
         this.parseBindsXml(param1.resource,param1.uri.tag);
      }
      
      public function keyboardFileLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:XML = XML(param1.resource);
         this._avaibleKeyboard.push(new LocalizedKeyboard(param1.uri,_loc2_.@locale,_loc2_.@description));
      }
      
      public function keyboardFileAllLoaded(param1:ResourceLoaderProgressEvent) : void {
         var _loc2_:String = null;
         try
         {
            _loc2_ = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_BINDS,"locale",LangManager.getInstance().getEntry("config.binds.current"));
            this.changeKeyboard(_loc2_);
         }
         catch(e:Error)
         {
         }
      }
      
      public function objectLoadedFailed(param1:ResourceErrorEvent) : void {
         _log.debug("objectLoadedFailed : " + param1.uri + ", " + param1.errorMsg);
      }
   }
}
