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
         var file:File = null;
         var s:Bind = null;
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
         var path:String = LangManager.getInstance().getEntry("config.binds.path.root").split("file://")[1];
         if(!path)
         {
            path = LangManager.getInstance().getEntry("config.binds.path.root");
         }
         var bindFilesPath:File = new File(File.applicationDirectory.nativePath + File.separator + path);
         bindFilesPath.createDirectory();
         var bindFiles:Array = bindFilesPath.getDirectoryListing();
         var uris:Array = new Array();
         for each (file in bindFiles)
         {
            if((!file.isDirectory) && (file.extension == "xml"))
            {
               uris.push(new Uri(file.nativePath));
            }
         }
         this._loaderKeyboard.load(uris);
         if(this._aRegisterKey.length == 0)
         {
            s = new Bind("ALL","ALL",true,true,true);
            this._aRegisterKey.push(s);
         }
      }
      
      public function get binds() : Array {
         return this._aRegisterKey;
      }
      
      public function getShortcutString(nKeyCode:uint, nCharCode:uint) : String {
         if(ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[nKeyCode] != null)
         {
            return ShortcutsEnum.BASIC_SHORTCUT_KEYCODE[nKeyCode];
         }
         if(nCharCode == 0)
         {
            return null;
         }
         return String.fromCharCode(nCharCode);
      }
      
      public function getBind(s:Bind, returnDisabled:Boolean=false) : Bind {
         var b:Bind = null;
         if(this._aRegisterKey == null)
         {
            return null;
         }
         var i:int = -1;
         var num:int = this._aRegisterKey.length;
         while(++i < num)
         {
            b = this._aRegisterKey[i] as Bind;
            if((b) && (b.equals(s)) && ((returnDisabled) || (!b.disabled)))
            {
               return b;
            }
         }
         return null;
      }
      
      public function isRegister(s:Bind) : Boolean {
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(s)))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function isPermanent(s:Bind) : Boolean {
         var shortcut:Shortcut = null;
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(s)))
            {
               shortcut = Shortcut.getShortcutByName(this._aRegisterKey[i].targetedShortcut);
               if((!(shortcut == null)) && (!shortcut.bindable))
               {
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      public function isDisabled(s:Bind) : Boolean {
         var b:Bind = null;
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(s)))
            {
               b = this._aRegisterKey[i] as Bind;
               return b.disabled;
            }
            i++;
         }
         return false;
      }
      
      public function setDisabled(s:Bind, disabled:Boolean) : void {
         var b:Bind = null;
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(s)))
            {
               b = this._aRegisterKey[i] as Bind;
               b.disabled = disabled;
               return;
            }
            i++;
         }
      }
      
      public function isRegisteredName(s:String) : Boolean {
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].targetedShortcut == s))
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function canBind(s:Bind) : Boolean {
         var i:uint = 0;
         while(i < ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN.length)
         {
            if(ShortcutsEnum.BASIC_SHORTCUT_FORBIDDEN[i].equals(s))
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function removeBind(b:Bind) : void {
         var target:String = null;
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(b)))
            {
               target = Bind(this._aRegisterKey[i]).targetedShortcut;
               Bind(this._aRegisterKey[i]).reset();
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,target,null);
               break;
            }
            i++;
         }
      }
      
      public function addBind(bind:Bind) : void {
         if(!this.canBind(bind))
         {
            _log.warn(bind.toString() + " cannot be bind.");
            return;
         }
         this.removeBind(bind);
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (Bind(this._aRegisterKey[i]).targetedShortcut == bind.targetedShortcut))
            {
               this._aRegisterKey.splice(i,1,bind);
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
               KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,bind.targetedShortcut,bind);
               return;
            }
            i++;
         }
         this._aRegisterKey.push(bind);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.ShortcutUpdate,bind.targetedShortcut,bind);
      }
      
      public function isRegisteredShortcut(s:Bind, disableGenericBind:Boolean=false) : Boolean {
         return (!(_aEvent[s.targetedShortcut] == null)) || (!disableGenericBind) && (_aEvent["ALL"]);
      }
      
      public function getBindFromShortcut(shorcutName:String, returnDisabled:Boolean=false) : Bind {
         var b:Bind = null;
         for each (b in this._aRegisterKey)
         {
            if((b) && (b.targetedShortcut == shorcutName) && ((returnDisabled) || (!b.disabled)))
            {
               return b;
            }
         }
         return null;
      }
      
      public function processCallback(o:*, ... args) : void {
         var e:GenericListener = null;
         var aGe:Array = null;
         var currentFocus:TextField = null;
         var inputUi:UiRootContainer = null;
         var modalUi:* = false;
         var i:uint = 0;
         var urc:UiRootContainer = null;
         var result:* = undefined;
         var s:Bind = Bind(o);
         if(!this.isRegisteredShortcut(s))
         {
            return;
         }
         var bContinue:Boolean = true;
         if(_aEvent[s.targetedShortcut])
         {
            aGe = _aEvent[s.targetedShortcut].concat(_aEvent["ALL"]);
            aGe.sortOn("sortIndex",Array.DESCENDING | Array.NUMERIC);
            currentFocus = FocusHandler.getInstance().getFocus() as TextField;
            if((currentFocus) && (currentFocus.parent is Input) && (Input(currentFocus.parent).focusEventHandlerPriority))
            {
               inputUi = Input(currentFocus.parent).getUi();
               modalUi = false;
               i = 0;
               while(i < aGe.length)
               {
                  e = aGe[i];
                  if(((e) && (e.listenerType == GenericListener.LISTENER_TYPE_UI)) && (e.listenerContext) && (e.listenerContext.object))
                  {
                     urc = UiRootContainer(e.listenerContext.object);
                     if(urc)
                     {
                        if(urc.modal)
                        {
                           modalUi = true;
                        }
                        if((inputUi == urc) && (!modalUi) || (urc.modal == true))
                        {
                           aGe = aGe.splice(i,1);
                           aGe.unshift(e);
                        }
                     }
                  }
                  i++;
               }
            }
            for each (e in aGe)
            {
               if(!bContinue)
               {
                  break;
               }
               if(e)
               {
                  if((Berilia.getInstance().getUi(e.listener)) && (Berilia.getInstance().getUi(e.listener).depth < Berilia.getInstance().highestModalDepth))
                  {
                     return;
                  }
                  _log.info("Dispatch " + args + " to " + e.listener);
                  ModuleLogger.log(s,e.listener);
                  result = e.getCallback().apply(null,args);
                  if((result === null) || (!(result is Boolean)))
                  {
                     throw new ApiError(e.getCallback() + " does not return a Boolean value");
                  }
                  else
                  {
                     bContinue = !result;
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
         var bind:Bind = null;
         var shortcut:Shortcut = null;
         var nameIndexed:Array = new Array();
         for each (bind in this._aRegisterKey)
         {
            if(bind)
            {
               nameIndexed[bind.targetedShortcut] = bind;
            }
         }
         for each (shortcut in Shortcut.getShortcuts())
         {
            if((nameIndexed[shortcut.name] == null) || (nameIndexed[shortcut.name].key == null) || (!(shortcut.defaultBind == nameIndexed[shortcut.name])))
            {
               if(shortcut.defaultBind)
               {
                  this.addBind(shortcut.defaultBind.copy());
               }
               else
               {
                  this.removeBind(nameIndexed[shortcut.name]);
               }
            }
         }
      }
      
      public function changeKeyboard(locale:String, removeOldBind:Boolean=false) : void {
         var k:LocalizedKeyboard = null;
         for each (k in this._avaibleKeyboard)
         {
            if(k.locale == locale)
            {
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"locale",locale);
               k.uri.tag = removeOldBind;
               this._loader.load(k.uri);
               break;
            }
         }
      }
      
      public function getRegisteredBind(s:Bind) : Bind {
         var i:uint = 0;
         while(i < this._aRegisterKey.length)
         {
            if((this._aRegisterKey[i]) && (this._aRegisterKey[i].equals(s)))
            {
               return this._aRegisterKey[i];
            }
            i++;
         }
         return null;
      }
      
      public function newShortcut(shortcut:Shortcut) : void {
         var bind:Bind = null;
         var b:Bind = null;
         var i:int = 0;
         while(i < this._waitingBinds.length)
         {
            if(this._waitingBinds[i].targetedShortcut == shortcut.name)
            {
               bind = this._waitingBinds[i];
               break;
            }
            i++;
         }
         if(!bind)
         {
            return;
         }
         this._waitingBinds.splice(i,1);
         if(!this.canBind(bind))
         {
            _log.warn(bind.toString() + " cannot be bind.");
            return;
         }
         shortcut.defaultBind = bind.copy();
         if(this.isRegister(bind))
         {
            return;
         }
         for each (b in this._aRegisterKey)
         {
            if((b) && (b.targetedShortcut == bind.targetedShortcut))
            {
               return;
            }
         }
         this._aRegisterKey.push(bind);
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
      }
      
      public function checkBinds() : void {
         var updateData:* = false;
         var o:Object = null;
         this._shortcutsLoaded = true;
         if((this._shortcutsLoaded && this._bindsLoaded) && (this._bindsToCheck) && (this._bindsToCheck.length > 0))
         {
            updateData = false;
            for each (o in this._bindsToCheck)
            {
               if(!Shortcut.getShortcutByName(o.bind.targetedShortcut))
               {
                  this._aRegisterKey.splice(o.index,1,null);
                  updateData = true;
               }
            }
            if(updateData)
            {
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
            }
            this._bindsToCheck.length = 0;
         }
      }
      
      private function fillShortcutsEnum() : void {
         var i:String = null;
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
      
      private function parseBindsXml(sXml:String, removeOldbinds:Boolean) : void {
         var s:Bind = null;
         var shortcut:Shortcut = null;
         var bind:Bind = null;
         var init:* = false;
         var registeredKeys:Array = null;
         var elementsToRemove:Vector.<uint> = null;
         var xBind:XML = null;
         var o:Object = null;
         var i:uint = 0;
         var nbElementsToRemove:* = 0;
         var binds:XML = XML(sXml);
         var nameIndexed:Array = new Array();
         for each (bind in this._aRegisterKey)
         {
            if(bind)
            {
               nameIndexed[bind.targetedShortcut] = bind;
            }
         }
         init = this._aRegisterKey.length > 1;
         registeredKeys = new Array();
         if(init)
         {
            i = 0;
            while(i < this._aRegisterKey.length)
            {
               if((!this._aRegisterKey[i]) || (this._aRegisterKey[i].targetedShortcut == "ALL") && (!(i == this._aRegisterKey.length - 1)))
               {
                  if(!elementsToRemove)
                  {
                     elementsToRemove = new Vector.<uint>(0);
                  }
                  elementsToRemove.push(i);
               }
               i++;
            }
            nbElementsToRemove = elementsToRemove?elementsToRemove.length:0;
            i = 0;
            while(i < nbElementsToRemove)
            {
               this._aRegisterKey.splice(elementsToRemove[i],1);
               i++;
            }
            i = 0;
            while(i < this._aRegisterKey.length)
            {
               if(this._aRegisterKey[i])
               {
                  registeredKeys[this._aRegisterKey[i].targetedShortcut] = 
                     {
                        "exist":(Shortcut.getShortcutByName(this._aRegisterKey[i].targetedShortcut)?true:false),
                        "bind":this._aRegisterKey[i],
                        "index":i
                     };
               }
               i++;
            }
         }
         for each (xBind in binds..bind)
         {
            shortcut = Shortcut.getShortcutByName(xBind..@shortcut);
            s = new Bind(xBind,xBind..@shortcut,xBind..@alt == true,xBind..@ctrl == true,xBind..@shift == true);
            if(registeredKeys[s.targetedShortcut])
            {
               registeredKeys[s.targetedShortcut].exist = true;
            }
            if(!shortcut)
            {
               this._waitingBinds.push(s);
            }
            else
            {
               if(!this.canBind(s))
               {
                  _log.warn(s.toString() + " cannot be bind.");
               }
               else
               {
                  shortcut.defaultBind = s.copy();
                  if(!this.isRegister(s))
                  {
                     if(nameIndexed[s.targetedShortcut])
                     {
                        if(removeOldbinds)
                        {
                           this.addBind(s);
                        }
                     }
                     else
                     {
                        if(!init)
                        {
                           this._aRegisterKey.push(s);
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
         for each (o in registeredKeys)
         {
            if((!o.exist) || (this._shortcutsLoaded) && (!Shortcut.getShortcutByName(o.bind.targetedShortcut)))
            {
               if(!this._shortcutsLoaded)
               {
                  this._bindsToCheck.push(o);
               }
               else
               {
                  this._aRegisterKey.splice(o.index,1,null);
               }
            }
         }
         this._bindsLoaded = true;
         if(this._shortcutsLoaded)
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_BINDS,"registeredKeys",this._aRegisterKey,true);
         }
      }
      
      public function objectLoaded(e:ResourceLoadedEvent) : void {
         this.parseBindsXml(e.resource,e.uri.tag);
      }
      
      public function keyboardFileLoaded(e:ResourceLoadedEvent) : void {
         var xml:XML = XML(e.resource);
         this._avaibleKeyboard.push(new LocalizedKeyboard(e.uri,xml.@locale,xml.@description));
      }
      
      public function keyboardFileAllLoaded(e:ResourceLoaderProgressEvent) : void {
         var locale:String = null;
         try
         {
            locale = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_BINDS,"locale",LangManager.getInstance().getEntry("config.binds.current"));
            this.changeKeyboard(locale);
         }
         catch(e:Error)
         {
         }
      }
      
      public function objectLoadedFailed(e:ResourceErrorEvent) : void {
         _log.debug("objectLoadedFailed : " + e.uri + ", " + e.errorMsg);
      }
   }
}
