package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.LangFile;
   import com.ankamagames.jerakine.JerakineConstants;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.types.LangMetaData;
   import com.ankamagames.jerakine.utils.errors.FileTypeError;
   import com.ankamagames.jerakine.messages.LangAllFilesLoadedMessage;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import com.ankamagames.jerakine.task.LangXmlParsingTask;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.types.events.LangFileEvent;
   import com.ankamagames.jerakine.tasking.TaskingManager;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   import com.ankamagames.jerakine.messages.LangFileLoadedMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class LangManager extends Object
   {
      
      public function LangManager() {
         this._parseReference = new Dictionary();
         super();
         if(_self != null)
         {
            throw new SingletonError("LangManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._aLang = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,new Array());
            this._aCategory = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG,KEY_LANG_CATEGORY,new Array());
            this._aVersion = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION);
            this._aCategory = new Array();
            this._aVersion = StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION,new Array());
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFileError);
            return;
         }
      }
      
      private static var _self:LangManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LangManager));
      
      protected static const KEY_LANG_INDEX:String = "langIndex";
      
      protected static const KEY_LANG_CATEGORY:String = "langCategory";
      
      protected static const KEY_LANG_VERSION:String = "langVersion";
      
      public static function getInstance() : LangManager {
         if(_self == null)
         {
            _self = new LangManager();
         }
         return _self;
      }
      
      private var _aLang:Array;
      
      private var _aCategory:Array;
      
      private var _handler:MessageHandler;
      
      private var _sLang:String;
      
      private var _aVersion:Array;
      
      private var _loader:IResourceLoader;
      
      private var _parseReference:Dictionary;
      
      private var _fontManager:FontManager;
      
      private var _replaceErrorCallback:Function;
      
      public function get handler() : MessageHandler {
         return this._handler;
      }
      
      public function set handler(param1:MessageHandler) : void {
         this._handler = param1;
      }
      
      public function get lang() : String {
         return this._sLang;
      }
      
      public function set lang(param1:String) : void {
         this._sLang = param1;
      }
      
      public function get category() : Array {
         return this._aCategory;
      }
      
      public function set replaceErrorCallback(param1:Function) : void {
         this._replaceErrorCallback = param1;
      }
      
      public function loadFile(param1:String, param2:Boolean=true) : void {
         if(param2)
         {
            this._parseReference[new Uri(param1).uri] = param2;
         }
         this.loadMetaDataFile(param1);
      }
      
      public function loadFromXml(param1:String, param2:String, param3:String, param4:Boolean=true) : void {
         var _loc5_:Uri = new Uri(param3);
         if(param4)
         {
            this._parseReference[_loc5_.uri] = param4;
         }
         var _loc6_:LangFile = new LangFile(param1,param2,_loc5_.uri);
         this.startParsing([_loc6_],_loc5_.uri);
      }
      
      public function getUntypedEntry(param1:String) : * {
         var _loc2_:* = StoreDataManager.getInstance().getData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX)[param1];
         if(_loc2_ == null)
         {
            _log.warn("[Warning] LangManager : " + param1 + " is unknow");
            _loc2_ = "!" + param1;
         }
         if(!(_loc2_ == null) && _loc2_ is String && !(String(_loc2_).indexOf("[") == -1))
         {
            _loc2_ = this.replaceKey(_loc2_,true);
         }
         return _loc2_;
      }
      
      public function getEntry(param1:String) : String {
         return this.getUntypedEntry(param1);
      }
      
      public function getStringEntry(param1:String) : String {
         return this.getUntypedEntry(param1);
      }
      
      public function getBooleanEntry(param1:String) : Boolean {
         return this.getUntypedEntry(param1);
      }
      
      public function getIntEntry(param1:String) : int {
         return this.getUntypedEntry(param1);
      }
      
      public function getFloatEntry(param1:String) : Number {
         return this.getUntypedEntry(param1);
      }
      
      public function setEntry(param1:String, param2:String, param3:String=null) : void {
         var _loc4_:Class = null;
         if(!param3)
         {
            this._aLang[param1] = param2;
         }
         else
         {
            switch(param3.toUpperCase())
            {
               case "STRING":
                  this._aLang[param1] = param2;
                  break;
               case "NUMBER":
                  this._aLang[param1] = parseFloat(param2);
                  break;
               case "UINT":
               case "INT":
                  this._aLang[param1] = parseInt(param2,10);
                  break;
               case "BOOLEAN":
                  this._aLang[param1] = param2.toLowerCase() == "true";
                  break;
               case "ARRAY":
                  this._aLang[param1] = param2.split(",");
                  break;
               case "BOOLEAN":
                  this._aLang[param1] = param2.toLowerCase() == "true";
                  break;
               default:
                  _loc4_ = getDefinitionByName(param3) as Class;
                  this._aLang[param1] = new _loc4_(param2);
            }
         }
      }
      
      public function deleteEntry(param1:String) : void {
         delete this._aLang[[param1]];
      }
      
      public function replaceKey(param1:String, param2:Boolean=false) : String {
         var _loc3_:Array = null;
         var _loc4_:RegExp = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         if(!(param1 == null) && !(param1.indexOf("[") == -1))
         {
            _loc4_ = new RegExp("(?<!\\\\)\\[([^\\]]*)\\]","g");
            _loc3_ = param1.match(_loc4_);
            if(param1.indexOf("\\["))
            {
               param1 = param1.split("\\[").join("[");
            }
            _loc5_ = 0;
            for(;_loc5_ < _loc3_.length;_loc5_++)
            {
               _loc8_ = _loc3_[_loc5_].substr(1,_loc3_[_loc5_].length - 2);
               if(_loc8_.charAt(0) == "#")
               {
                  if(!param2)
                  {
                     continue;
                  }
                  _loc8_ = _loc8_.substr(1);
               }
               _loc6_ = this._aLang[_loc8_];
               if(_loc6_ == null)
               {
                  if(!isNaN(parseInt(_loc8_,10)))
                  {
                     _loc6_ = I18n.getText(parseInt(_loc8_,10));
                  }
                  if(I18n.hasUiText(_loc8_))
                  {
                     _loc6_ = I18n.getUiText(_loc8_);
                  }
                  else
                  {
                     if(_loc8_.charAt(0) == "~")
                     {
                        continue;
                     }
                     if(this._replaceErrorCallback != null)
                     {
                        _loc6_ = this._replaceErrorCallback(_loc8_);
                     }
                     if(_loc6_ == null)
                     {
                        _loc6_ = "!" + _loc8_;
                        _loc7_ = this.findCategory(_loc8_);
                        if(_loc7_.length)
                        {
                           _log.warn("Référence incorrect vers la clef [" + _loc8_ + "] dans : " + param1 + " (pourrait être " + _loc7_.join(" ou ") + ")");
                        }
                        else
                        {
                           _log.warn("Référence inconue vers la clef [" + _loc8_ + "] dans : " + param1);
                        }
                     }
                  }
               }
               param1 = param1.split(_loc3_[_loc5_]).join(_loc6_);
            }
         }
         return param1;
      }
      
      public function getCategory(param1:String, param2:Boolean=true) : Array {
         var _loc4_:String = null;
         var _loc3_:Array = new Array();
         for (_loc4_ in this._aLang)
         {
            if(param2)
            {
               if(_loc4_ == param1)
               {
                  _loc3_[_loc4_] = this._aLang[_loc4_];
               }
               else
               {
                  if(_loc4_.indexOf(param1) == 0)
                  {
                     _loc3_[_loc4_] = this._aLang[_loc4_];
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function findCategory(param1:String) : Array {
         var _loc4_:String = null;
         var _loc2_:String = param1.split(".")[0];
         var _loc3_:Array = new Array();
         for (_loc4_ in this._aCategory)
         {
            if(this._aLang[_loc4_ + "." + _loc2_] != null)
            {
               _loc3_.push(_loc4_ + "." + _loc2_);
            }
         }
         for (_loc4_ in this._aCategory)
         {
            if(this._aLang[_loc4_ + "." + param1] != null)
            {
               _loc3_.push(_loc4_ + "." + param1);
            }
         }
         return _loc3_;
      }
      
      public function setFileVersion(param1:String, param2:String) : void {
         this._aVersion[param1] = param2;
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG_VERSIONS,KEY_LANG_VERSION,this._aVersion);
      }
      
      public function checkFileVersion(param1:String, param2:String) : Boolean {
         return this._aVersion[param1] == param2;
      }
      
      public function clear(param1:String=null) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1)
         {
            _loc2_ = param1 + ".";
            for (_loc3_ in this._aLang)
            {
               if(_loc3_.indexOf(_loc2_) == 0)
               {
                  delete this._aLang[[_loc3_]];
               }
            }
         }
         else
         {
            this._aLang = new Array();
         }
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,this._aLang);
      }
      
      public function resolve(param1:String) : void {
         StoreDataManager.getInstance().startStoreSequence();
         this.resolveImp("[" + param1 + "]",param1);
         this.resolveImp("[#" + param1 + "]",param1);
         StoreDataManager.getInstance().stopStoreSequence();
      }
      
      private function resolveImp(param1:String, param2:String) : void {
         var _loc4_:String = null;
         var _loc3_:* = this.getUntypedEntry(param2);
         for (_loc4_ in this._aLang)
         {
            if(String(this._aLang[_loc4_]).indexOf(param1) != -1)
            {
               this._aLang[_loc4_] = String(this._aLang[_loc4_]).replace(param1,_loc3_);
            }
         }
      }
      
      private function loadMetaDataFile(param1:String) : void {
         var sMetDataUrl:String = null;
         var uri:Uri = null;
         var sUrl:String = param1;
         try
         {
            sMetDataUrl = FileUtils.getFilePathStartName(sUrl) + ".meta";
            uri = new Uri(sMetDataUrl);
            uri.tag = sUrl;
            this._loader.load(uri);
         }
         catch(e:Error)
         {
            _log.error(e.message);
            if(e.getStackTrace())
            {
               _log.error(e.getStackTrace());
            }
            else
            {
               _log.error("no stack trace available");
            }
         }
      }
      
      private function loadLangFile(param1:String, param2:LangMetaData) : void {
         var _loc4_:Uri = null;
         var _loc3_:String = FileUtils.getExtension(param1);
         if(_loc3_ == null)
         {
            throw new FileTypeError(param1 + " have no type (no extension found).");
         }
         else
         {
            if(!param2.clearAllFile && !param2.clearFileCount && !param2.loadAllFile)
            {
               this._handler.process(new LangAllFilesLoadedMessage(param1,true));
               return;
            }
            _loc4_ = new Uri(param1);
            _loc4_.tag = param2;
            switch(_loc3_.toUpperCase())
            {
               case "ZIP":
                  Chrono.start("Chargement zip");
               case "XML":
                  this._loader.load(_loc4_);
                  return;
               default:
                  throw new FileTypeError(param1 + " is not expected type (bad extension found (" + _loc3_ + "), support only .zip and .xml).");
            }
         }
      }
      
      private function startParsing(param1:Array, param2:String) : void {
         StoreDataManager.getInstance().startStoreSequence();
         var _loc3_:Boolean = this._parseReference[param2];
         var _loc4_:LangXmlParsingTask = new LangXmlParsingTask(param1,param2,_loc3_);
         if(StageShareManager.rootContainer == null)
         {
            _loc4_.parseForReg();
         }
         else
         {
            _loc4_.addEventListener(LangFileEvent.ALL_COMPLETE,this.onTaskEnd);
            _loc4_.addEventListener(LangFileEvent.COMPLETE,this.onTaskStep);
            TaskingManager.getInstance().addTask(_loc4_);
         }
      }
      
      private function onFileLoaded(param1:ResourceLoadedEvent) : void {
         switch(param1.uri.fileType.toUpperCase())
         {
            case "XML":
               this.onXmlLoadComplete(param1);
               break;
            case "META":
               this.onMetaLoad(param1);
               break;
            case "ZIP":
               Chrono.stop();
               this.onZipFileComplete(param1);
               break;
         }
      }
      
      private function onFileError(param1:ResourceErrorEvent) : void {
         switch(param1.uri.fileType.toUpperCase())
         {
            case "XML":
               this.onXmlLoadError(param1);
               break;
            case "META":
               this.onMetaLoadError(param1);
               break;
            case "ZIP":
               this.onZipFileLoadError(param1);
               break;
         }
      }
      
      private function onXmlLoadComplete(param1:ResourceLoadedEvent) : void {
         var _loc2_:LangMetaData = LangMetaData(param1.uri.tag);
         var _loc3_:String = FileUtils.getFileStartName(param1.uri.uri);
         if((_loc2_.clearFile[param1.uri.fileName]) || (_loc2_.clearAllFile) || (_loc2_.loadAllFile))
         {
            if((_loc2_.clearFile[param1.uri.fileName]) || (_loc2_.clearAllFile))
            {
               this.clear(_loc3_);
            }
            this.startParsing(new Array(new LangFile(param1.resource,FileUtils.getFileStartName(param1.uri.uri),param1.uri.uri)),param1.uri.uri);
         }
      }
      
      private function onZipFileComplete(param1:ResourceLoadedEvent) : void {
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc9_:ZipEntry = null;
         var _loc10_:uint = 0;
         var _loc2_:ZipFile = param1.resource;
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         var _loc6_:LangMetaData = LangMetaData(param1.uri.tag);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc2_.entries.length)
         {
            _loc3_.push(_loc2_.getEntry(_loc2_.entries[_loc7_]));
            _loc7_++;
         }
         for (_loc8_ in _loc6_.clearFile)
         {
            if(!_loc2_.getEntry(_loc8_))
            {
               _log.warn("File \'" + _loc8_ + "\' was not found in " + param1.uri.uri + " (specified by metadata file)");
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _loc3_.length)
         {
            _loc9_ = _loc3_[_loc10_];
            _loc5_ = FileUtils.getFileStartName(_loc9_.name);
            if((_loc6_.clearFile[_loc9_.name]) || (_loc6_.clearAllFile) || (_loc6_.loadAllFile))
            {
               if((_loc6_.clearFile[_loc9_.name]) || (_loc6_.clearAllFile))
               {
                  this.clear(_loc5_);
               }
               if((_loc6_.clearFile[_loc9_.name]) || (_loc6_.loadAllFile))
               {
                  _loc4_.push(new LangFile(_loc2_.getInput(_loc3_[_loc10_]).toString(),_loc5_,_loc9_.name,_loc6_));
               }
            }
            _loc10_++;
         }
         this.startParsing(_loc4_,param1.uri.uri);
      }
      
      private function onMetaLoad(param1:ResourceLoadedEvent) : void {
         this.loadLangFile(param1.uri.tag as String,LangMetaData.fromXml(param1.resource,param1.uri.tag as String,this.checkFileVersion));
      }
      
      private function onXmlLoadError(param1:ResourceErrorEvent) : void {
         _log.warn("[Warning] can\'t load " + param1.uri.uri);
         this._handler.process(new LangFileLoadedMessage(param1.uri.uri,false,param1.uri.uri));
      }
      
      private function onZipFileLoadError(param1:ResourceErrorEvent) : void {
         _log.warn("Can\'t load " + param1.uri.uri);
         this._handler.process(new LangFileLoadedMessage(param1.uri.uri,false,param1.uri.uri));
      }
      
      private function onTaskStep(param1:LangFileEvent) : void {
         if(this._handler)
         {
            this._handler.process(new LangFileLoadedMessage(param1.url,true,param1.urlProvider));
         }
      }
      
      private function onTaskEnd(param1:LangFileEvent) : void {
         StoreDataManager.getInstance().setData(JerakineConstants.DATASTORE_LANG,KEY_LANG_INDEX,this._aLang);
         StoreDataManager.getInstance().stopStoreSequence();
         if(this._handler)
         {
            this._handler.process(new LangAllFilesLoadedMessage(param1.urlProvider,true));
         }
      }
      
      private function onMetaLoadError(param1:ResourceErrorEvent) : void {
         var _loc2_:LangMetaData = new LangMetaData();
         _loc2_.loadAllFile = true;
         this.loadLangFile(param1.uri.tag as String,_loc2_);
      }
   }
}
