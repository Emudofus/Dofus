package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.messages.ThemeLoadErrorMessage;
   import com.ankamagames.berilia.types.data.Theme;
   import com.ankamagames.berilia.types.messages.NoThemeErrorMessage;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.berilia.types.messages.ThemeLoadedMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.berilia.utils.ThemeFlashProtocol;
   import com.ankamagames.berilia.utils.ThemeProtocol;
   
   public class ThemeManager extends Object
   {
      
      public function ThemeManager() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError,false,0,true);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoad,false,0,true);
            if(AirScanner.isStreamingVersion())
            {
               ProtocolFactory.addProtocol("theme",ThemeFlashProtocol);
            }
            else
            {
               ProtocolFactory.addProtocol("theme",ThemeProtocol);
            }
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ThemeManager));
      
      private static var _self:ThemeManager;
      
      public static function getInstance() : ThemeManager {
         if(!_self)
         {
            _self = new ThemeManager();
         }
         return _self;
      }
      
      private var _loader:IResourceLoader;
      
      private var _themes:Array;
      
      private var _themeNames:Array;
      
      private var _dtFileToLoad:uint = 0;
      
      private var _themeCount:uint = 0;
      
      private var _themesRoot:File;
      
      private var _currentTheme:String;
      
      private var _applyWaiting:String = "";
      
      public function get themeCount() : uint {
         return this._themeCount;
      }
      
      public function get currentTheme() : String {
         return this._currentTheme;
      }
      
      public function init() : void {
         var _loc2_:Uri = null;
         var _loc3_:File = null;
         var _loc4_:File = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         this._themes = new Array();
         this._themeNames = new Array();
         this._themeCount = 0;
         this._dtFileToLoad = 0;
         var _loc1_:String = File.applicationDirectory.nativePath + File.separator + LangManager.getInstance().getEntry("config.ui.common.themes").replace("file://","");
         this._themesRoot = new File(_loc1_);
         if(this._themesRoot.exists)
         {
            for each (_loc3_ in this._themesRoot.getDirectoryListing())
            {
               if(!(!_loc3_.isDirectory || _loc3_.name.charAt(0) == "."))
               {
                  _loc4_ = this.searchDtFile(_loc3_);
                  if(_loc4_)
                  {
                     this._dtFileToLoad++;
                     if(_loc4_.url.indexOf("app:/") == 0)
                     {
                        _loc5_ = "app:/".length;
                        _loc6_ = _loc4_.url.substring(_loc5_,_loc4_.url.length);
                        _loc2_ = new Uri(StringUtils.convertLatinToUtf(_loc6_));
                     }
                     else
                     {
                        _loc2_ = new Uri(_loc4_.nativePath);
                     }
                     _loc2_.tag = _loc4_;
                     this._loader.load(_loc2_);
                  }
                  else
                  {
                     ErrorManager.addError("Impossible de trouver le fichier de description de thème dans le dossier " + _loc3_.nativePath);
                     Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(_loc3_.name));
                  }
               }
            }
         }
         else
         {
            ErrorManager.addError("Le dossier des thèmes est introuvable (url:" + LangManager.getInstance().getEntry("config.ui.common.themes") + ")");
         }
      }
      
      public function getThemes() : Array {
         return this._themes;
      }
      
      public function getTheme(param1:String) : Theme {
         return this._themes[param1];
      }
      
      public function applyTheme(param1:String) : void {
         var _loc2_:String = null;
         if(this._dtFileToLoad == this._themeCount)
         {
            if(this._themeNames.length == 0)
            {
               Berilia.getInstance().handler.process(new NoThemeErrorMessage());
            }
            else
            {
               this._applyWaiting = null;
               if(!this._themes[param1])
               {
                  param1 = this._themeNames[0];
                  OptionManager.getOptionManager("dofus")["switchUiSkin"] = param1;
                  UiRenderManager.getInstance().clearCache();
               }
               this._currentTheme = param1;
               _loc2_ = LangManager.getInstance().getEntry("config.ui.common.themes") + param1 + "/";
               LangManager.getInstance().setEntry("config.ui.skin",_loc2_,"string");
               XmlConfig.getInstance().setEntry("config.ui.skin",_loc2_);
               LangManager.getInstance().loadFile(_loc2_ + "colors.xml");
            }
         }
         else
         {
            this._applyWaiting = param1;
         }
      }
      
      private function onLoadError(param1:ResourceErrorEvent) : void {
         var _loc3_:File = null;
         _log.error("Cannot load " + param1.uri + "(" + param1.errorMsg + ")");
         var _loc2_:String = param1.uri.toString();
         try
         {
            _loc3_ = param1.uri.toFile();
            _loc2_ = _loc2_ + ("(" + _loc3_.nativePath + ")");
         }
         catch(e:Error)
         {
         }
         ErrorManager.addError("Cannot load " + _loc2_);
         Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(param1.uri.fileName));
      }
      
      private function onLoad(param1:ResourceLoadedEvent) : void {
         switch(param1.uri.fileType.toLowerCase())
         {
            case "dt":
               this.onDTLoad(param1);
               break;
         }
      }
      
      private function onDTLoad(param1:ResourceLoadedEvent) : void {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Theme = null;
         this._themeCount++;
         var _loc2_:XML = param1.resource as XML;
         var _loc3_:String = param1.uri.fileName.split(".")[0];
         var _loc4_:* = param1.uri.path.split("/");
         var _loc5_:String = _loc4_[_loc4_.length - 2];
         if(_loc3_ == _loc5_)
         {
            _loc6_ = _loc2_.name;
            _loc7_ = _loc2_.description;
            _loc8_ = new Theme(_loc3_,_loc6_,_loc7_,_loc2_.previewUri);
            this._themes[_loc3_] = _loc8_;
            this._themeNames.push(_loc3_);
            Berilia.getInstance().handler.process(new ThemeLoadedMessage(_loc3_));
            if(this._applyWaiting != "")
            {
               this.applyTheme(this._applyWaiting);
            }
         }
         else
         {
            Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(_loc3_));
         }
      }
      
      private function searchDtFile(param1:File) : File {
         var _loc3_:File = null;
         var _loc4_:File = null;
         if(param1.nativePath.indexOf(".svn") != -1)
         {
            return null;
         }
         var _loc2_:Array = param1.getDirectoryListing();
         for each (_loc3_ in _loc2_)
         {
            if(!_loc3_.isDirectory && _loc3_.extension.toLowerCase() == "dt")
            {
               return _loc3_;
            }
         }
         for each (_loc3_ in _loc2_)
         {
            if(_loc3_.isDirectory)
            {
               _loc4_ = this.searchDtFile(_loc3_);
               if(_loc4_)
               {
                  break;
               }
            }
         }
         return _loc4_;
      }
   }
}
