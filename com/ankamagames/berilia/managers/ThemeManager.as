package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.messages.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class ThemeManager extends Object
    {
        private var _loader:IResourceLoader;
        private var _themes:Array;
        private var _themeNames:Array;
        private var _dtFileToLoad:uint = 0;
        private var _themeCount:uint = 0;
        private var _themesRoot:File;
        private var _currentTheme:String;
        private var _applyWaiting:String = "";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ThemeManager));
        private static var _self:ThemeManager;

        public function ThemeManager()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError, false, 0, true);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad, false, 0, true);
            return;
        }// end function

        public function get themeCount() : uint
        {
            return this._themeCount;
        }// end function

        public function get currentTheme() : String
        {
            return this._currentTheme;
        }// end function

        public function init() : void
        {
            var _loc_2:Uri = null;
            var _loc_3:File = null;
            var _loc_4:File = null;
            var _loc_5:int = 0;
            var _loc_6:String = null;
            this._themes = new Array();
            this._themeNames = new Array();
            this._themeCount = 0;
            this._dtFileToLoad = 0;
            var _loc_1:* = File.applicationDirectory.nativePath + File.separator + LangManager.getInstance().getEntry("config.ui.common.themes").replace("file://", "");
            this._themesRoot = new File(_loc_1);
            if (this._themesRoot.exists)
            {
                for each (_loc_3 in this._themesRoot.getDirectoryListing())
                {
                    
                    if (!_loc_3.isDirectory || _loc_3.name.charAt(0) == ".")
                    {
                        continue;
                    }
                    _loc_4 = this.searchDtFile(_loc_3);
                    if (_loc_4)
                    {
                        var _loc_9:String = this;
                        var _loc_10:* = this._dtFileToLoad + 1;
                        _loc_9._dtFileToLoad = _loc_10;
                        if (_loc_4.url.indexOf("app:/") == 0)
                        {
                            _loc_5 = "app:/".length;
                            _loc_6 = _loc_4.url.substring(_loc_5, _loc_4.url.length);
                            _loc_2 = new Uri(_loc_6);
                        }
                        else
                        {
                            _loc_2 = new Uri(_loc_4.url);
                        }
                        _loc_2.tag = _loc_4;
                        this._loader.load(_loc_2);
                        continue;
                    }
                    ErrorManager.addError("Impossible de trouver le fichier de description de thème dans le dossier " + _loc_3.nativePath);
                    Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(_loc_3.name));
                }
            }
            else
            {
                ErrorManager.addError("Le dossier des thèmes est introuvable (url:" + LangManager.getInstance().getEntry("config.ui.common.themes") + ")");
            }
            return;
        }// end function

        public function getThemes() : Array
        {
            return this._themes;
        }// end function

        public function getTheme(param1:String) : Theme
        {
            return this._themes[param1];
        }// end function

        public function applyTheme(param1:String) : void
        {
            if (this._dtFileToLoad == this._themeCount)
            {
                if (this._themeNames.length == 0)
                {
                    Berilia.getInstance().handler.process(new NoThemeErrorMessage());
                }
                else
                {
                    this._applyWaiting = null;
                    if (!this._themes[param1])
                    {
                        param1 = this._themeNames[0];
                        OptionManager.getOptionManager("dofus")["switchUiSkin"] = param1;
                        UiRenderManager.getInstance().clearCache();
                    }
                    this._currentTheme = param1;
                    LangManager.getInstance().setEntry("config.ui.skin", LangManager.getInstance().getEntry("config.ui.common.themes") + param1 + "/", "string");
                    XmlConfig.getInstance().setEntry("config.ui.skin", LangManager.getInstance().getEntry("config.ui.common.themes") + param1 + "/");
                    LangManager.getInstance().loadFile(LangManager.getInstance().getEntry("config.ui.skin") + "colors.xml");
                }
            }
            else
            {
                this._applyWaiting = param1;
            }
            return;
        }// end function

        private function onLoadError(event:ResourceErrorEvent) : void
        {
            _log.error("Cannot load " + event.uri + "(" + event.errorMsg + ")");
            Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(event.uri.fileName));
            return;
        }// end function

        private function onLoad(event:ResourceLoadedEvent) : void
        {
            switch(event.uri.fileType.toLowerCase())
            {
                case "dt":
                {
                    this.onDTLoad(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onDTLoad(event:ResourceLoadedEvent) : void
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:Theme = null;
            var _loc_9:String = this;
            var _loc_10:* = this._themeCount + 1;
            _loc_9._themeCount = _loc_10;
            var _loc_2:* = event.resource as XML;
            var _loc_3:* = event.uri.fileName.split(".")[0];
            var _loc_4:* = event.uri.path.split("/");
            var _loc_5:* = event.uri.path.split("/")[event.uri.path.split("/").length - 2];
            if (_loc_3 == _loc_5)
            {
                _loc_6 = _loc_2.name;
                _loc_7 = _loc_2.description;
                _loc_8 = new Theme(_loc_3, _loc_6, _loc_7, _loc_2.previewUri);
                this._themes[_loc_3] = _loc_8;
                this._themeNames.push(_loc_3);
                Berilia.getInstance().handler.process(new ThemeLoadedMessage(_loc_3));
                if (this._applyWaiting != "")
                {
                    this.applyTheme(this._applyWaiting);
                }
            }
            else
            {
                Berilia.getInstance().handler.process(new ThemeLoadErrorMessage(_loc_3));
            }
            return;
        }// end function

        private function searchDtFile(param1:File) : File
        {
            var _loc_3:File = null;
            var _loc_4:File = null;
            if (param1.nativePath.indexOf(".svn") != -1)
            {
                return null;
            }
            var _loc_2:* = param1.getDirectoryListing();
            for each (_loc_3 in _loc_2)
            {
                
                if (!_loc_3.isDirectory && _loc_3.extension.toLowerCase() == "dt")
                {
                    return _loc_3;
                }
            }
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.isDirectory)
                {
                    _loc_4 = this.searchDtFile(_loc_3);
                    if (_loc_4)
                    {
                        break;
                    }
                }
            }
            return _loc_4;
        }// end function

        public static function getInstance() : ThemeManager
        {
            if (!_self)
            {
                _self = new ThemeManager;
            }
            return _self;
        }// end function

    }
}
