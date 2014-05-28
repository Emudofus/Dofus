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
      
      protected static const _log:Logger;
      
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
         var uri:Uri = null;
         var file:File = null;
         var dtFile:File = null;
         var len:* = 0;
         var substr:String = null;
         this._themes = new Array();
         this._themeNames = new Array();
         this._themeCount = 0;
         this._dtFileToLoad = 0;
         var themePath:String = File.applicationDirectory.nativePath + File.separator + LangManager.getInstance().getEntry("config.ui.common.themes").replace("file://","");
         this._themesRoot = new File(themePath);
         if(this._themesRoot.exists)
         {
            for each (file in this._themesRoot.getDirectoryListing())
            {
               if(!((!file.isDirectory) || (file.name.charAt(0) == ".")))
               {
                  dtFile = this.searchDtFile(file);
                  if(dtFile)
                  {
                     this._dtFileToLoad++;
                     if(dtFile.url.indexOf("app:/") == 0)
                     {
                        len = "app:/".length;
                        substr = dtFile.url.substring(len,dtFile.url.length);
                        uri = new Uri(StringUtils.convertLatinToUtf(substr));
                     }
                     else
                     {
                        uri = new Uri(dtFile.nativePath);
                     }
                     uri.tag = dtFile;
                     this._loader.load(uri);
                  }
                  else
                  {
                     ErrorManager.addError("Impossible de trouver le fichier de description de thème dans le dossier " + file.nativePath);
                     Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(file.name));
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
      
      public function getTheme(name:String) : Theme {
         return this._themes[name];
      }
      
      public function applyTheme(name:String) : void {
         var uiSkinEntry:String = null;
         if(this._dtFileToLoad == this._themeCount)
         {
            if(this._themeNames.length == 0)
            {
               Berilia.getInstance().handler.process(new NoThemeErrorMessage());
            }
            else
            {
               this._applyWaiting = null;
               if(!this._themes[name])
               {
                  name = this._themeNames[0];
                  OptionManager.getOptionManager("dofus")["switchUiSkin"] = name;
                  UiRenderManager.getInstance().clearCache();
               }
               this._currentTheme = name;
               uiSkinEntry = LangManager.getInstance().getEntry("config.ui.common.themes") + name + "/";
               LangManager.getInstance().setEntry("config.ui.skin",uiSkinEntry,"string");
               XmlConfig.getInstance().setEntry("config.ui.skin",uiSkinEntry);
               LangManager.getInstance().loadFile(uiSkinEntry + "colors.xml");
            }
         }
         else
         {
            this._applyWaiting = name;
         }
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void {
         var f:File = null;
         _log.error("Cannot load " + e.uri + "(" + e.errorMsg + ")");
         var path:String = e.uri.toString();
         try
         {
            f = e.uri.toFile();
            path = path + ("(" + f.nativePath + ")");
         }
         catch(e:Error)
         {
         }
         ErrorManager.addError("Cannot load " + path);
         Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(e.uri.fileName));
      }
      
      private function onLoad(e:ResourceLoadedEvent) : void {
         switch(e.uri.fileType.toLowerCase())
         {
            case "dt":
               this.onDTLoad(e);
               break;
         }
      }
      
      private function onDTLoad(e:ResourceLoadedEvent) : void {
         var thName:String = null;
         var thDesc:String = null;
         var th:Theme = null;
         this._themeCount++;
         var dt:XML = e.resource as XML;
         var dtFileName:String = e.uri.fileName.split(".")[0];
         var folder:Array = e.uri.path.split("/");
         var folderName:String = folder[folder.length - 2];
         if(dtFileName == folderName)
         {
            thName = dt.name;
            thDesc = dt.description;
            th = new Theme(dtFileName,thName,thDesc,dt.previewUri);
            this._themes[dtFileName] = th;
            this._themeNames.push(dtFileName);
            Berilia.getInstance().handler.process(new ThemeLoadedMessage(dtFileName));
            if(this._applyWaiting != "")
            {
               this.applyTheme(this._applyWaiting);
            }
         }
         else
         {
            Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(dtFileName));
         }
      }
      
      private function searchDtFile(rootPath:File) : File {
         var file:File = null;
         var dt:File = null;
         if(rootPath.nativePath.indexOf(".svn") != -1)
         {
            return null;
         }
         var files:Array = rootPath.getDirectoryListing();
         for each(file in files)
         {
            if((!file.isDirectory) && (file.extension.toLowerCase() == "dt"))
            {
               return file;
            }
         }
         for each(file in files)
         {
            if(file.isDirectory)
            {
               dt = this.searchDtFile(file);
               if(dt)
               {
                  break;
               }
            }
         }
         return dt;
      }
   }
}
