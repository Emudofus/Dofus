package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import __AS3__.vec.Vector;
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   import com.ankamagames.berilia.utils.ModuleScriptAnalyzer;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.managers.UiGroupManager;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   
   public class UiModule extends Object implements IModuleUtil
   {
      
      public function UiModule(param1:String=null, param2:String=null, param3:String=null, param4:String=null, param5:String=null, param6:String=null, param7:String=null, param8:String=null, param9:String=null, param10:String=null, param11:Array=null, param12:Array=null, param13:Boolean=false) {
         var _loc14_:UiData = null;
         this._instanceId = ++ID_COUNT;
         this._apiScriptAnalyserCallback = new Dictionary();
         this._hookScriptAnalyserCallback = new Dictionary();
         this._actionScriptAnalyserCallback = new Dictionary();
         super();
         MEMORY_LOG[this] = 1;
         this._name = param2;
         this._version = param3;
         this._gameVersion = param4;
         this._author = param5;
         this._shortDescription = param6;
         this._description = param7;
         this._iconUri = new Uri(param8);
         this._script = param9;
         this._shortcuts = param10;
         this._id = param1;
         this._uis = new Array();
         this._cachedFiles = param12?param12:new Array();
         for each (this._uis[_loc14_.name] in param11)
         {
         }
         this._apiList = new Vector.<Object>();
      }
      
      private static var ID_COUNT:uint = 0;
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModule));
      
      public static function createFromXml(param1:XML, param2:String, param3:String) : UiModule {
         var _loc4_:UiModule = new UiModule();
         _loc4_.fillFromXml(param1,param2,param3);
         return _loc4_;
      }
      
      private var _instanceId:uint;
      
      private var _id:String;
      
      private var _name:String;
      
      private var _version:String;
      
      private var _gameVersion:String;
      
      private var _author:String;
      
      private var _shortDescription:String;
      
      private var _description:String;
      
      private var _iconUri:Uri;
      
      private var _script:String;
      
      private var _shortcuts:String;
      
      private var _uis:Array;
      
      private var _trusted:Boolean = false;
      
      private var _trustedInit:Boolean = false;
      
      private var _activated:Boolean = false;
      
      private var _rootPath:String;
      
      private var _storagePath:String;
      
      private var _mainClass:Object;
      
      private var _cachedFiles:Array;
      
      private var _apiList:Vector.<Object>;
      
      private var _groups:Vector.<UiGroup>;
      
      var _loader:Loader;
      
      private var _moduleAppDomain:ApplicationDomain;
      
      private var _enable:Boolean = true;
      
      private var _rawXml:XML;
      
      private var _scriptAnalyser:ModuleScriptAnalyzer;
      
      private var _apiScriptAnalyserCallback:Dictionary;
      
      private var _hookScriptAnalyserCallback:Dictionary;
      
      private var _actionScriptAnalyserCallback:Dictionary;
      
      public function set loader(param1:Loader) : void {
         if(!this._loader)
         {
            this._loader = param1;
         }
      }
      
      public function get instanceId() : uint {
         return this._instanceId;
      }
      
      public function get id() : String {
         return this._id;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get version() : String {
         return this._version;
      }
      
      public function get gameVersion() : String {
         return this._gameVersion;
      }
      
      public function get author() : String {
         return this._author;
      }
      
      public function get shortDescription() : String {
         return this._shortDescription;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function get iconUri() : Uri {
         return this._iconUri;
      }
      
      public function get script() : String {
         return this._script;
      }
      
      public function get shortcuts() : String {
         return this._shortcuts;
      }
      
      public function get uis() : Array {
         return this._uis;
      }
      
      public function get trusted() : Boolean {
         return this._trusted;
      }
      
      public function set trusted(param1:Boolean) : void {
         var _loc2_:* = undefined;
         if(!this._trustedInit)
         {
            this._trusted = param1;
            this._trustedInit = true;
            _loc2_ = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_MOD,this.id);
            if(_loc2_ == null)
            {
               this._enable = this._trusted;
            }
            else
            {
               this._enable = (_loc2_) || (this._trusted);
            }
            if(!this._enable)
            {
               this.enable = false;
            }
         }
      }
      
      public function get enable() : Boolean {
         return this._enable;
      }
      
      public function set enable(param1:Boolean) : void {
         var _loc2_:UiGroup = null;
         StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_MOD,this.id,param1);
         if(!this._enable && (param1))
         {
            this._enable = true;
            UiModuleManager.getInstance().loadModule(this.id);
         }
         else
         {
            this._enable = false;
            for each (_loc2_ in this._groups)
            {
               UiGroupManager.getInstance().removeGroup(_loc2_.name);
            }
            UiModuleManager.getInstance().unloadModule(this.id);
         }
      }
      
      public function get rootPath() : String {
         return this._rootPath;
      }
      
      public function get storagePath() : String {
         return this._storagePath;
      }
      
      public function get cachedFiles() : Array {
         return this._cachedFiles;
      }
      
      public function get apiList() : Vector.<Object> {
         return this._apiList;
      }
      
      public function set applicationDomain(param1:ApplicationDomain) : void {
         var _loc2_:UiData = null;
         if(this._moduleAppDomain)
         {
            throw new BeriliaError("ApplicationDomain cannot be set twice.");
         }
         else
         {
            for each (_loc2_ in this.uis)
            {
               if((param1) && (param1.hasDefinition(_loc2_.uiClassName)))
               {
                  _loc2_.uiClass = param1.getDefinition(_loc2_.uiClassName) as Class;
               }
               else
               {
                  _log.error(_loc2_.uiClassName + " cannot be found");
               }
            }
            this._moduleAppDomain = param1;
            return;
         }
      }
      
      public function get applicationDomain() : ApplicationDomain {
         return this._moduleAppDomain;
      }
      
      public function get mainClass() : Object {
         return this._mainClass;
      }
      
      public function set mainClass(param1:Object) : void {
         if(this._mainClass)
         {
            throw new BeriliaError("mainClass cannot be set twice.");
         }
         else
         {
            this._mainClass = param1;
            return;
         }
      }
      
      public function get groups() : Vector.<UiGroup> {
         return this._groups;
      }
      
      public function get rawXml() : XML {
         return this._rawXml;
      }
      
      public function addUiGroup(param1:String, param2:Boolean, param3:Boolean) : void {
         if(!this._groups)
         {
            this._groups = new Vector.<UiGroup>();
         }
         this._groups.push(new UiGroup(param1,param2,param3));
      }
      
      public function getUi(param1:String) : UiData {
         return this._uis[param1];
      }
      
      public function toString() : String {
         var _loc1_:String = "ID:" + this._id;
         if(this._name)
         {
            _loc1_ = _loc1_ + ("\nName:" + this._name);
         }
         if(this._trusted)
         {
            _loc1_ = _loc1_ + ("\nTrusted:" + this._trusted);
         }
         if(this._author)
         {
            _loc1_ = _loc1_ + ("\nAuthor:" + this._author);
         }
         if(this._description)
         {
            _loc1_ = _loc1_ + ("\nDescription:" + this._description);
         }
         return _loc1_;
      }
      
      public function destroy() : void {
         if(this._loader)
         {
            this._loader.unloadAndStop(true);
         }
      }
      
      public function usedApiList(param1:Function) : void {
         if(this._apiScriptAnalyserCallback)
         {
            if(!this._scriptAnalyser)
            {
               this._scriptAnalyser = new ModuleScriptAnalyzer(this,this.onScriptAnalyserReady,null);
            }
            this._apiScriptAnalyserCallback[param1] = param1;
         }
         else
         {
            param1(this._scriptAnalyser.apis);
         }
      }
      
      public function usedHookList(param1:Function) : void {
         if(this._hookScriptAnalyserCallback)
         {
            if(!this._scriptAnalyser)
            {
               this._scriptAnalyser = new ModuleScriptAnalyzer(this,this.onScriptAnalyserReady,null);
            }
            this._hookScriptAnalyserCallback[param1] = param1;
         }
         else
         {
            param1(this._scriptAnalyser.hooks);
         }
      }
      
      public function usedActionList(param1:Function) : void {
         if(this._actionScriptAnalyserCallback)
         {
            if(!this._scriptAnalyser)
            {
               this._scriptAnalyser = new ModuleScriptAnalyzer(this,this.onScriptAnalyserReady,null);
            }
            this._actionScriptAnalyserCallback[param1] = param1;
         }
         else
         {
            param1(this._scriptAnalyser.actions);
         }
      }
      
      private function initScriptAnalyser() : void {
         if(!this._scriptAnalyser)
         {
            this._scriptAnalyser = new ModuleScriptAnalyzer(this,this.onScriptAnalyserReady,this._moduleAppDomain);
         }
      }
      
      private function onScriptAnalyserReady() : void {
         var _loc1_:Function = null;
         for each (_loc1_ in this._actionScriptAnalyserCallback)
         {
            _loc1_(this._scriptAnalyser.actions);
         }
         for each (_loc1_ in this._hookScriptAnalyserCallback)
         {
            _loc1_(this._scriptAnalyser.hooks);
         }
         for each (_loc1_ in this._apiScriptAnalyserCallback)
         {
            _loc1_(this._scriptAnalyser.apis);
         }
         this._actionScriptAnalyserCallback = null;
         this._hookScriptAnalyserCallback = null;
         this._apiScriptAnalyserCallback = null;
      }
      
      protected function fillFromXml(param1:XML, param2:String, param3:String) : void {
         var uiGroup:UiGroup = null;
         var group:XML = null;
         var uiData:UiData = null;
         var uis:XML = null;
         var path:XML = null;
         var uiNames:Array = null;
         var groupName:String = null;
         var uisXML:XMLList = null;
         var uiName:XML = null;
         var uisGroup:String = null;
         var ui:XML = null;
         var file:String = null;
         var mod:String = null;
         var fileuri:String = null;
         var xml:XML = param1;
         var nativePath:String = param2;
         var id:String = param3;
         this.setProperty("name",xml..header..name);
         this.setProperty("version",xml..header..version);
         this.setProperty("gameVersion",xml..header..gameVersion);
         this.setProperty("author",xml..header..author);
         this.setProperty("description",xml..header..description);
         this.setProperty("shortDescription",xml..header..shortDescription);
         this.setProperty("script",xml..script);
         this.setProperty("shortcuts",xml..shortcuts);
         this._rawXml = xml;
         nativePath = nativePath.split("app:/").join("");
         if(nativePath.indexOf("file://") == -1 && !(nativePath.substr(0,2) == "\\\\"))
         {
            nativePath = "file://" + nativePath;
         }
         this._id = id;
         if(this.script)
         {
            this._script = nativePath + "/" + this.script;
         }
         if(this.shortcuts)
         {
            this._shortcuts = nativePath + "/" + this.shortcuts;
         }
         this._rootPath = nativePath + "/";
         this._storagePath = unescape(this._rootPath + "storage/").replace("file://","");
         var iconPath:String = xml..header..icon;
         if((iconPath) && (iconPath.length))
         {
            this._iconUri = new Uri(this._rootPath + iconPath);
         }
         this._groups = new Vector.<UiGroup>();
         for(;xml.uiGroup hasNext _loc5_;uiGroup = new UiGroup(group.@name,group.@exclusive.toString() == "true",group.@permanent.toString() == "true",uiNames),UiGroupManager.getInstance().registerGroup(uiGroup),this._groups.push(uiGroup))
         {
            group = nextValue(_loc5_,_loc6_);
            uiNames = new Array();
            groupName = group..@name;
            try
            {
               uisXML = xml.uis.(@group == groupName);
               for each (uiName in uisXML..@name)
               {
                  uiNames.push(uiName.toString());
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
         for each (uis in xml.uis)
         {
            uisGroup = uis.@group.toString();
            for each (ui in uis..ui)
            {
               if(ui.@group.toString().length)
               {
                  uisGroup = ui.@group.toString();
               }
               file = null;
               if(ui.@file.toString().length)
               {
                  if(ui.@file.indexOf("::") != -1)
                  {
                     mod = nativePath.split("Ankama")[0];
                     fileuri = ui.@file;
                     fileuri = fileuri.replace("::","/");
                     file = mod + fileuri;
                  }
                  else
                  {
                     file = nativePath + "/" + ui.@file;
                  }
               }
               uiData = new UiData(this,ui.@name,file,ui["class"],uisGroup);
               this._uis[uiData.name] = uiData;
            }
         }
         for each (path in xml.cachedFiles..path)
         {
            this.cachedFiles.push(path.children().toString());
         }
      }
      
      private function setProperty(param1:String, param2:String) : void {
         if((param2) && (param2.length))
         {
            this["_" + param1] = param2;
         }
         else
         {
            this["_" + param1] = null;
         }
      }
   }
}
