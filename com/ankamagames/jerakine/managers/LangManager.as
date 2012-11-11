package com.ankamagames.jerakine.managers
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.task.*;
    import com.ankamagames.jerakine.tasking.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;
    import nochump.util.zip.*;

    public class LangManager extends Object
    {
        private var _aLang:Array;
        private var _aCategory:Array;
        private var _handler:MessageHandler;
        private var _sLang:String;
        private var _aVersion:Array;
        private var _loader:IResourceLoader;
        private var _parseReference:Dictionary;
        private var _fontManager:FontManager;
        private var _replaceErrorCallback:Function;
        private static var _self:LangManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LangManager));
        static const KEY_LANG_INDEX:String = "langIndex";
        static const KEY_LANG_CATEGORY:String = "langCategory";
        static const KEY_LANG_VERSION:String = "langVersion";

        public function LangManager()
        {
            this._parseReference = new Dictionary();
            if (_self != null)
            {
                throw new SingletonError("LangManager is a singleton and should not be instanciated directly.");
            }
            this._aLang = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG, KEY_LANG_INDEX, new Array());
            this._aCategory = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG, KEY_LANG_CATEGORY, new Array());
            this._aVersion = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG_VERSIONS, KEY_LANG_VERSION);
            this._aCategory = new Array();
            this._aVersion = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG_VERSIONS, KEY_LANG_VERSION, new Array());
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onFileLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onFileError);
            return;
        }// end function

        public function get handler() : MessageHandler
        {
            return this._handler;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function get lang() : String
        {
            return this._sLang;
        }// end function

        public function set lang(param1:String) : void
        {
            this._sLang = param1;
            return;
        }// end function

        public function get category() : Array
        {
            return this._aCategory;
        }// end function

        public function set replaceErrorCallback(param1:Function) : void
        {
            this._replaceErrorCallback = param1;
            return;
        }// end function

        public function loadFile(param1:String, param2:Boolean = true) : void
        {
            if (param2)
            {
                this._parseReference[new Uri(param1).uri] = param2;
            }
            this.loadMetaDataFile(param1);
            return;
        }// end function

        public function getUntypedEntry(param1:String)
        {
            var _loc_2:* = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG, KEY_LANG_INDEX)[param1];
            if (_loc_2 == null)
            {
                _log.warn("[Warning] LangManager : " + param1 + " is unknow");
                _loc_2 = "!" + param1;
            }
            if (_loc_2 != null && _loc_2 is String && String(_loc_2).indexOf("[") != -1)
            {
                _loc_2 = this.replaceKey(_loc_2, true);
            }
            return _loc_2;
        }// end function

        public function getEntry(param1:String) : String
        {
            return this.getUntypedEntry(param1);
        }// end function

        public function getStringEntry(param1:String) : String
        {
            return this.getUntypedEntry(param1);
        }// end function

        public function getBooleanEntry(param1:String) : Boolean
        {
            return this.getUntypedEntry(param1);
        }// end function

        public function getIntEntry(param1:String) : int
        {
            return this.getUntypedEntry(param1);
        }// end function

        public function getFloatEntry(param1:String) : Number
        {
            return this.getUntypedEntry(param1);
        }// end function

        public function setEntry(param1:String, param2:String, param3:String = null) : void
        {
            var _loc_4:* = null;
            if (!param3)
            {
                this._aLang[param1] = param2;
            }
            else
            {
                switch(param3.toUpperCase())
                {
                    case "STRING":
                    {
                        this._aLang[param1] = param2;
                        break;
                    }
                    case "NUMBER":
                    {
                        this._aLang[param1] = parseFloat(param2);
                        break;
                    }
                    case "UINT":
                    case "INT":
                    {
                        this._aLang[param1] = parseInt(param2, 10);
                        break;
                    }
                    case "BOOLEAN":
                    {
                        this._aLang[param1] = param2.toLowerCase() == "true";
                        break;
                    }
                    case "ARRAY":
                    {
                        this._aLang[param1] = param2.split(",");
                        break;
                    }
                    case "BOOLEAN":
                    {
                        this._aLang[param1] = param2.toLowerCase() == "true";
                        break;
                    }
                    default:
                    {
                        _loc_4 = getDefinitionByName(param3) as Class;
                        this._aLang[param1] = new _loc_4(param2);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function deleteEntry(param1:String) : void
        {
            delete this._aLang[param1];
            return;
        }// end function

        public function replaceKey(param1:String, param2:Boolean = false) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 != null && param1.indexOf("[") != -1)
            {
                _loc_4 = /\[([^\]]*)\]""\[([^\]]*)\]/g;
                _loc_3 = param1.match(_loc_4);
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    _loc_8 = _loc_3[_loc_5].substr(1, _loc_3[_loc_5].length - 2);
                    if (_loc_8.charAt(0) == "#")
                    {
                        if (!param2)
                        {
                        }
                        _loc_8 = _loc_8.substr(1);
                    }
                    _loc_6 = this._aLang[_loc_8];
                    if (_loc_6 == null)
                    {
                        if (!isNaN(parseInt(_loc_8, 10)))
                        {
                            _loc_6 = I18n.getText(parseInt(_loc_8, 10));
                        }
                        if (I18n.hasUiText(_loc_8))
                        {
                            _loc_6 = I18n.getUiText(_loc_8);
                        }
                        else
                        {
                            if (_loc_8.charAt(0) == "~")
                            {
                            }
                            if (this._replaceErrorCallback != null)
                            {
                                _loc_6 = this._replaceErrorCallback(_loc_8);
                            }
                            if (_loc_6 == null)
                            {
                                _loc_6 = "!" + _loc_8;
                                _loc_7 = this.findCategory(_loc_8);
                                if (_loc_7.length)
                                {
                                    _log.warn("Référence incorrect vers la clef [" + _loc_8 + "] dans : " + param1 + " (pourrait être " + _loc_7.join(" ou ") + ")");
                                }
                                else
                                {
                                    _log.warn("Référence inconue vers la clef [" + _loc_8 + "] dans : " + param1);
                                }
                            }
                        }
                    }
                    param1 = param1.split(_loc_3[_loc_5]).join(_loc_6);
                    _loc_5 = _loc_5 + 1;
                }
            }
            return param1;
        }// end function

        public function getCategory(param1:String, param2:Boolean = true) : Array
        {
            var _loc_4:* = null;
            var _loc_3:* = new Array();
            for (_loc_4 in this._aLang)
            {
                
                if (param2)
                {
                    if (_loc_4 == param1)
                    {
                        _loc_3[_loc_4] = this._aLang[_loc_4];
                        continue;
                    }
                    if (_loc_4.indexOf(param1) == 0)
                    {
                        _loc_3[_loc_4] = this._aLang[_loc_4];
                    }
                }
            }
            return _loc_3;
        }// end function

        public function findCategory(param1:String) : Array
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.split(".")[0];
            var _loc_3:* = new Array();
            for (_loc_4 in this._aCategory)
            {
                
                if (this._aLang[_loc_4 + "." + _loc_2] != null)
                {
                    _loc_3.push(_loc_4 + "." + _loc_2);
                }
            }
            for (_loc_4 in this._aCategory)
            {
                
                if (this._aLang[_loc_4 + "." + param1] != null)
                {
                    _loc_3.push(_loc_4 + "." + param1);
                }
            }
            return _loc_3;
        }// end function

        public function setFileVersion(param1:String, param2:String) : void
        {
            this._aVersion[param1] = param2;
            StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG_VERSIONS, KEY_LANG_VERSION, this._aVersion);
            return;
        }// end function

        public function checkFileVersion(param1:String, param2:String) : Boolean
        {
            return this._aVersion[param1] == param2;
        }// end function

        public function clear(param1:String = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                _loc_2 = param1 + ".";
                for (_loc_3 in this._aLang)
                {
                    
                    if (_loc_3.indexOf(_loc_2) == 0)
                    {
                        delete this._aLang[_loc_3];
                    }
                }
            }
            else
            {
                this._aLang = new Array();
            }
            StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG, KEY_LANG_INDEX, this._aLang);
            return;
        }// end function

        private function loadMetaDataFile(param1:String) : void
        {
            var sMetDataUrl:String;
            var uri:Uri;
            var sUrl:* = param1;
            try
            {
                sMetDataUrl = FileUtils.getFilePathStartName(sUrl) + ".meta";
                uri = new Uri(sMetDataUrl);
                uri.tag = sUrl;
                this._loader.load(uri);
            }
            catch (e:Error)
            {
                _log.error(e.message);
                if (e.getStackTrace())
                {
                    _log.error(e.getStackTrace());
                }
                else
                {
                    _log.error("no stack trace available");
                }
            }
            return;
        }// end function

        private function loadLangFile(param1:String, param2:LangMetaData) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = FileUtils.getExtension(param1);
            if (_loc_3 == null)
            {
                throw new FileTypeError(param1 + " have no type (no extension found).");
            }
            if (!param2.clearAllFile && !param2.clearFileCount && !param2.loadAllFile)
            {
                this._handler.process(new LangAllFilesLoadedMessage(param1, true));
                return;
            }
            _loc_4 = new Uri(param1);
            _loc_4.tag = param2;
            switch(_loc_3.toUpperCase())
            {
                case "ZIP":
                {
                    Chrono.start("Chargement zip");
                }
                case "XML":
                {
                    this._loader.load(_loc_4);
                    break;
                }
                default:
                {
                    throw new FileTypeError(param1 + " is not expected type (bad extension found (" + _loc_3 + "), support only .zip and .xml).");
                    break;
                }
            }
            return;
        }// end function

        private function startParsing(param1:Array, param2:String) : void
        {
            StoreDataManager.getInstance().startStoreSequence();
            var _loc_3:* = this._parseReference[param2];
            var _loc_4:* = new LangXmlParsingTask(param1, param2, _loc_3);
            if (StageShareManager.rootContainer == null)
            {
                _loc_4.parseForReg();
            }
            else
            {
                _loc_4.addEventListener(LangFileEvent.ALL_COMPLETE, this.onTaskEnd);
                _loc_4.addEventListener(LangFileEvent.COMPLETE, this.onTaskStep);
                TaskingManager.getInstance().addTask(_loc_4);
            }
            return;
        }// end function

        private function onFileLoaded(event:ResourceLoadedEvent) : void
        {
            switch(event.uri.fileType.toUpperCase())
            {
                case "XML":
                {
                    this.onXmlLoadComplete(event);
                    break;
                }
                case "META":
                {
                    this.onMetaLoad(event);
                    break;
                }
                case "ZIP":
                {
                    Chrono.stop();
                    this.onZipFileComplete(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onFileError(event:ResourceErrorEvent) : void
        {
            switch(event.uri.fileType.toUpperCase())
            {
                case "XML":
                {
                    this.onXmlLoadError(event);
                    break;
                }
                case "META":
                {
                    this.onMetaLoadError(event);
                    break;
                }
                case "ZIP":
                {
                    this.onZipFileLoadError(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onXmlLoadComplete(event:ResourceLoadedEvent) : void
        {
            var _loc_2:* = LangMetaData(event.uri.tag);
            var _loc_3:* = FileUtils.getFileStartName(event.uri.uri);
            if (_loc_2.clearFile[event.uri.fileName] || _loc_2.clearAllFile || _loc_2.loadAllFile)
            {
                if (_loc_2.clearFile[event.uri.fileName] || _loc_2.clearAllFile)
                {
                    this.clear(_loc_3);
                }
                this.startParsing(new Array(new LangFile(event.resource, FileUtils.getFileStartName(event.uri.uri), event.uri.uri)), event.uri.uri);
            }
            return;
        }// end function

        private function onZipFileComplete(event:ResourceLoadedEvent) : void
        {
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_2:* = event.resource;
            var _loc_3:* = new Array();
            var _loc_4:* = new Array();
            var _loc_6:* = LangMetaData(event.uri.tag);
            var _loc_7:* = 0;
            while (_loc_7 < _loc_2.entries.length)
            {
                
                _loc_3.push(_loc_2.getEntry(_loc_2.entries[_loc_7]));
                _loc_7 = _loc_7 + 1;
            }
            for (_loc_8 in _loc_6.clearFile)
            {
                
                if (!_loc_2.getEntry(_loc_8))
                {
                    _log.warn("File \'" + _loc_8 + "\' was not found in " + event.uri.uri + " (specified by metadata file)");
                }
            }
            _loc_10 = 0;
            while (_loc_10 < _loc_3.length)
            {
                
                _loc_9 = _loc_3[_loc_10];
                _loc_5 = FileUtils.getFileStartName(_loc_9.name);
                if (_loc_6.clearFile[_loc_9.name] || _loc_6.clearAllFile || _loc_6.loadAllFile)
                {
                    if (_loc_6.clearFile[_loc_9.name] || _loc_6.clearAllFile)
                    {
                        this.clear(_loc_5);
                    }
                    if (_loc_6.clearFile[_loc_9.name] || _loc_6.loadAllFile)
                    {
                        _loc_4.push(new LangFile(_loc_2.getInput(_loc_3[_loc_10]).toString(), _loc_5, _loc_9.name, _loc_6));
                    }
                }
                _loc_10 = _loc_10 + 1;
            }
            this.startParsing(_loc_4, event.uri.uri);
            return;
        }// end function

        private function onMetaLoad(event:ResourceLoadedEvent) : void
        {
            this.loadLangFile(event.uri.tag as String, LangMetaData.fromXml(event.resource, event.uri.tag as String, this.checkFileVersion));
            return;
        }// end function

        private function onXmlLoadError(event:ResourceErrorEvent) : void
        {
            _log.warn("[Warning] can\'t load " + event.uri.uri);
            this._handler.process(new LangFileLoadedMessage(event.uri.uri, false, event.uri.uri));
            return;
        }// end function

        private function onZipFileLoadError(event:ResourceErrorEvent) : void
        {
            _log.warn("Can\'t load " + event.uri.uri);
            this._handler.process(new LangFileLoadedMessage(event.uri.uri, false, event.uri.uri));
            return;
        }// end function

        private function onTaskStep(event:LangFileEvent) : void
        {
            if (this._handler)
            {
                this._handler.process(new LangFileLoadedMessage(event.url, true, event.urlProvider));
            }
            return;
        }// end function

        private function onTaskEnd(event:LangFileEvent) : void
        {
            StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG, KEY_LANG_INDEX, this._aLang);
            StoreDataManager.getInstance().stopStoreSequence();
            if (this._handler)
            {
                this._handler.process(new LangAllFilesLoadedMessage(event.urlProvider, true));
            }
            return;
        }// end function

        private function onMetaLoadError(event:ResourceErrorEvent) : void
        {
            var _loc_2:* = new LangMetaData();
            _loc_2.loadAllFile = true;
            this.loadLangFile(event.uri.tag as String, _loc_2);
            return;
        }// end function

        public static function getInstance() : LangManager
        {
            if (_self == null)
            {
                _self = new LangManager;
            }
            return _self;
        }// end function

    }
}
