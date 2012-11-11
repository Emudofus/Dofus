package com.ankamagames.berilia.types.data
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import flash.display.*;
    import flash.system.*;
    import flash.utils.*;

    public class UiModule extends Object implements IModuleUtil
    {
        private var _instanceId:uint;
        private var _id:String;
        private var _name:String;
        private var _version:String;
        private var _gameVersion:String;
        private var _author:String;
        private var _shortDescription:String;
        private var _description:String;
        private var _iconUri:String;
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
        private static var ID_COUNT:uint = 0;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModule));

        public function UiModule(param1:String = null, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:String = null, param11:Array = null, param12:Array = null, param13:Boolean = false)
        {
            var _loc_14:* = null;
            this._instanceId = ID_COUNT + 1;
            MEMORY_LOG[this] = 1;
            this._name = param2;
            this._version = param3;
            this._gameVersion = param4;
            this._author = param5;
            this._shortDescription = param6;
            this._description = param7;
            this._iconUri = param8;
            this._script = param9;
            this._shortcuts = param10;
            this._id = param1;
            this._uis = new Array();
            this._cachedFiles = param12 ? (param12) : (new Array());
            for each (_loc_14 in param11)
            {
                
                this._uis[_loc_14.name] = _loc_14;
            }
            this._apiList = new Vector.<Object>;
            return;
        }// end function

        public function set loader(param1:Loader) : void
        {
            if (!this._loader)
            {
                this._loader = param1;
            }
            return;
        }// end function

        public function get instanceId() : uint
        {
            return this._instanceId;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get version() : String
        {
            return this._version;
        }// end function

        public function get gameVersion() : String
        {
            return this._gameVersion;
        }// end function

        public function get author() : String
        {
            return this._author;
        }// end function

        public function get shortDescription() : String
        {
            return this._shortDescription;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function get iconUri() : String
        {
            return this._iconUri;
        }// end function

        public function get script() : String
        {
            return this._script;
        }// end function

        public function get shortcuts() : String
        {
            return this._shortcuts;
        }// end function

        public function get uis() : Array
        {
            return this._uis;
        }// end function

        public function get trusted() : Boolean
        {
            return this._trusted;
        }// end function

        public function set trusted(param1:Boolean) : void
        {
            var _loc_2:* = undefined;
            if (!this._trustedInit)
            {
                this._trusted = param1;
                this._trustedInit = true;
                _loc_2 = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_MOD, this.id);
                if (_loc_2 == null)
                {
                    this._enable = this._trusted;
                }
                else
                {
                    this._enable = _loc_2 || this._trusted;
                }
                if (!this._enable)
                {
                    this.enable = false;
                }
            }
            return;
        }// end function

        public function get enable() : Boolean
        {
            return this._enable;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_MOD, this.id, param1);
            if (!this._enable && param1)
            {
                this._enable = true;
                UiModuleManager.getInstance().loadModule(this.id);
            }
            else
            {
                this._enable = false;
                for each (_loc_2 in this._groups)
                {
                    
                    UiGroupManager.getInstance().removeGroup(_loc_2.name);
                }
                UiModuleManager.getInstance().unloadModule(this.id);
            }
            return;
        }// end function

        public function get rootPath() : String
        {
            return this._rootPath;
        }// end function

        public function get storagePath() : String
        {
            return this._storagePath;
        }// end function

        public function get cachedFiles() : Array
        {
            return this._cachedFiles;
        }// end function

        public function get apiList() : Vector.<Object>
        {
            return this._apiList;
        }// end function

        public function set applicationDomain(param1:ApplicationDomain) : void
        {
            var _loc_2:* = null;
            if (this._moduleAppDomain)
            {
                throw new BeriliaError("ApplicationDomain cannot be set twice.");
            }
            for each (_loc_2 in this.uis)
            {
                
                if (param1 && param1.hasDefinition(_loc_2.uiClassName))
                {
                    _loc_2.uiClass = param1.getDefinition(_loc_2.uiClassName) as Class;
                    continue;
                }
                _log.error(_loc_2.uiClassName + " cannot be found");
            }
            this._moduleAppDomain = param1;
            return;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            return this._moduleAppDomain;
        }// end function

        public function get mainClass() : Object
        {
            return this._mainClass;
        }// end function

        public function set mainClass(param1:Object) : void
        {
            if (this._mainClass)
            {
                throw new BeriliaError("mainClass cannot be set twice.");
            }
            this._mainClass = param1;
            return;
        }// end function

        public function get groups() : Vector.<UiGroup>
        {
            return this._groups;
        }// end function

        public function get rawXml() : XML
        {
            return this._rawXml;
        }// end function

        public function getUi(param1:String) : UiData
        {
            return this._uis[param1];
        }// end function

        public function toString() : String
        {
            var _loc_1:* = "ID:" + this._id;
            if (this._name)
            {
                _loc_1 = _loc_1 + ("\nName:" + this._name);
            }
            if (this._trusted)
            {
                _loc_1 = _loc_1 + ("\nTrusted:" + this._trusted);
            }
            if (this._author)
            {
                _loc_1 = _loc_1 + ("\nAuthor:" + this._author);
            }
            if (this._description)
            {
                _loc_1 = _loc_1 + ("\nDescription:" + this._description);
            }
            return _loc_1;
        }// end function

        public function destroy() : void
        {
            if (this._loader)
            {
                this._loader.unloadAndStop(true);
            }
            return;
        }// end function

        protected function fillFromXml(param1:XML, param2:String, param3:String) : void
        {
            var uiGroup:UiGroup;
            var group:XML;
            var uiData:UiData;
            var uis:XML;
            var path:XML;
            var uiNames:Array;
            var groupName:String;
            var uisXML:XMLList;
            var uiName:XML;
            var uisGroup:String;
            var ui:XML;
            var file:String;
            var mod:String;
            var fileuri:String;
            var xml:* = param1;
            var nativePath:* = param2;
            var id:* = param3;
            this.setProperty("name", xml..header..name);
            this.setProperty("version", xml..header..version);
            this.setProperty("gameVersion", xml..header..gameVersion);
            this.setProperty("author", xml..header..author);
            this.setProperty("description", xml..header..description);
            this.setProperty("iconUri", xml..header..icon);
            this.setProperty("shortDescription", xml..header..shortDescription);
            this.setProperty("script", xml..script);
            this.setProperty("shortcuts", xml..shortcuts);
            this._rawXml = xml;
            nativePath = nativePath.split("app:/").join("");
            if (nativePath.indexOf("file://") == -1 && nativePath.substr(0, 2) != "\\\\")
            {
                nativePath = "file://" + nativePath;
            }
            this._id = id;
            if (this.script)
            {
                this._script = nativePath + "/" + this.script;
            }
            if (this.shortcuts)
            {
                this._shortcuts = nativePath + "/" + this.shortcuts;
            }
            this._rootPath = nativePath + "/";
            this._storagePath = unescape(this._rootPath + "storage/").replace("file://", "");
            this._groups = new Vector.<UiGroup>;
            var _loc_5:* = 0;
            var _loc_6:* = xml.uiGroup;
            while (_loc_6 in _loc_5)
            {
                
                group = _loc_6[_loc_5];
                uiNames = new Array();
                groupName = group..@name;
                try
                {
                    var _loc_8:* = 0;
                    var _loc_9:* = xml.uis;
                    var _loc_7:* = new XMLList("");
                    for each (_loc_10 in _loc_9)
                    {
                        
                        var _loc_11:* = _loc_9[_loc_8];
                        with (_loc_9[_loc_8])
                        {
                            if (@group == groupName)
                            {
                                _loc_7[_loc_8] = _loc_10;
                            }
                        }
                    }
                    uisXML = _loc_7;
                    var _loc_7:* = 0;
                    var _loc_8:* = uisXML..@name;
                    while (_loc_8 in _loc_7)
                    {
                        
                        uiName = _loc_8[_loc_7];
                        uiNames.push(uiName.toString());
                    }
                }
                catch (e:Error)
                {
                }
                uiGroup = new UiGroup(group.@name, group.@exclusive.toString() == "true", group.@permanent.toString() == "true", uiNames);
                UiGroupManager.getInstance().registerGroup(uiGroup);
                this._groups.push(uiGroup);
            }
            var _loc_5:* = 0;
            var _loc_6:* = xml.uis;
            while (_loc_6 in _loc_5)
            {
                
                uis = _loc_6[_loc_5];
                uisGroup = uis.@group.toString();
                var _loc_7:* = 0;
                var _loc_8:* = uis..ui;
                while (_loc_8 in _loc_7)
                {
                    
                    ui = _loc_8[_loc_7];
                    if (ui.@group.toString().length)
                    {
                        uisGroup = ui.@group.toString();
                    }
                    file;
                    if (ui.@file.toString().length)
                    {
                        if (ui.@file.indexOf("::") != -1)
                        {
                            mod = nativePath.split("Ankama")[0];
                            fileuri = ui.@file;
                            fileuri = fileuri.replace("::", "/");
                            file = mod + fileuri;
                        }
                        else
                        {
                            file = nativePath + "/" + ui.@file;
                        }
                    }
                    uiData = new UiData(this, ui.@name, file, ui["class"], uisGroup);
                    this._uis[uiData.name] = uiData;
                }
            }
            var _loc_5:* = 0;
            var _loc_6:* = xml.cachedFiles..path;
            while (_loc_6 in _loc_5)
            {
                
                path = _loc_6[_loc_5];
                this.cachedFiles.push(path.children().toString());
            }
            return;
        }// end function

        private function setProperty(param1:String, param2:String) : void
        {
            if (param2 && param2.length)
            {
                this["_" + param1] = param2;
            }
            else
            {
                this["_" + param1] = null;
            }
            return;
        }// end function

        public static function createFromXml(param1:XML, param2:String, param3:String) : UiModule
        {
            var _loc_4:* = new UiModule;
            new UiModule.fillFromXml(param1, param2, param3);
            return _loc_4;
        }// end function

    }
}
