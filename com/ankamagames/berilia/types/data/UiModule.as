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
    import __AS3__.vec.*;

    public class UiModule implements IModuleUtil 
    {

        private static var ID_COUNT:uint = 0;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiModule));

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

        public function UiModule(id:String=null, name:String=null, version:String=null, gameVersion:String=null, author:String=null, shortDescription:String=null, description:String=null, iconUri:String=null, script:String=null, shortcuts:String=null, uis:Array=null, cachedFiles:Array=null, activated:Boolean=false)
        {
            var ui:UiData;
            this._instanceId = ++ID_COUNT;
            this._apiScriptAnalyserCallback = new Dictionary();
            this._hookScriptAnalyserCallback = new Dictionary();
            this._actionScriptAnalyserCallback = new Dictionary();
            super();
            MEMORY_LOG[this] = 1;
            this._name = name;
            this._version = version;
            this._gameVersion = gameVersion;
            this._author = author;
            this._shortDescription = shortDescription;
            this._description = description;
            this._iconUri = new Uri(iconUri);
            this._script = script;
            this._shortcuts = shortcuts;
            this._id = id;
            this._uis = new Array();
            this._cachedFiles = ((cachedFiles) ? cachedFiles : new Array());
            for each (ui in uis)
            {
                this._uis[ui.name] = ui;
            };
            this._apiList = new Vector.<Object>();
        }

        public static function createFromXml(xml:XML, nativePath:String, id:String):UiModule
        {
            var um:UiModule = new (UiModule)();
            um.fillFromXml(xml, nativePath, id);
            return (um);
        }


        public function set loader(l:Loader):void
        {
            if (!(this._loader))
            {
                this._loader = l;
            };
        }

        public function get instanceId():uint
        {
            return (this._instanceId);
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get version():String
        {
            return (this._version);
        }

        public function get gameVersion():String
        {
            return (this._gameVersion);
        }

        public function get author():String
        {
            return (this._author);
        }

        public function get shortDescription():String
        {
            return (this._shortDescription);
        }

        public function get description():String
        {
            return (this._description);
        }

        public function get iconUri():Uri
        {
            return (this._iconUri);
        }

        public function get script():String
        {
            return (this._script);
        }

        public function get shortcuts():String
        {
            return (this._shortcuts);
        }

        public function get uis():Array
        {
            return (this._uis);
        }

        public function get trusted():Boolean
        {
            return (this._trusted);
        }

        public function set trusted(v:Boolean):void
        {
            var state:*;
            if (!(this._trustedInit))
            {
                this._trusted = v;
                this._trustedInit = true;
                state = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_MOD, this.id);
                if (state == null)
                {
                    this._enable = this._trusted;
                }
                else
                {
                    this._enable = ((state) || (this._trusted));
                };
                if (!(this._enable))
                {
                    this.enable = false;
                };
            };
        }

        public function get enable():Boolean
        {
            return (this._enable);
        }

        public function set enable(v:Boolean):void
        {
            var _local_2:UiGroup;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_MOD, this.id, v);
            if (((!(this._enable)) && (v)))
            {
                this._enable = true;
                UiModuleManager.getInstance().loadModule(this.id);
            }
            else
            {
                this._enable = false;
                for each (_local_2 in this._groups)
                {
                    UiGroupManager.getInstance().removeGroup(_local_2.name);
                };
                UiModuleManager.getInstance().unloadModule(this.id);
            };
        }

        public function get rootPath():String
        {
            return (this._rootPath);
        }

        public function get storagePath():String
        {
            return (this._storagePath);
        }

        public function get cachedFiles():Array
        {
            return (this._cachedFiles);
        }

        public function get apiList():Vector.<Object>
        {
            return (this._apiList);
        }

        public function set applicationDomain(appDomain:ApplicationDomain):void
        {
            var ui:UiData;
            if (this._moduleAppDomain)
            {
                throw (new BeriliaError("ApplicationDomain cannot be set twice."));
            };
            for each (ui in this.uis)
            {
                if (((appDomain) && (appDomain.hasDefinition(ui.uiClassName))))
                {
                    ui.uiClass = (appDomain.getDefinition(ui.uiClassName) as Class);
                }
                else
                {
                    _log.error((ui.uiClassName + " cannot be found"));
                };
            };
            this._moduleAppDomain = appDomain;
        }

        public function get applicationDomain():ApplicationDomain
        {
            return (this._moduleAppDomain);
        }

        public function get mainClass():Object
        {
            return (this._mainClass);
        }

        public function set mainClass(instance:Object):void
        {
            if (this._mainClass)
            {
                throw (new BeriliaError("mainClass cannot be set twice."));
            };
            this._mainClass = instance;
        }

        public function get groups():Vector.<UiGroup>
        {
            return (this._groups);
        }

        public function get rawXml():XML
        {
            return (this._rawXml);
        }

        public function addUiGroup(groupName:String, exclusive:Boolean, permanent:Boolean):void
        {
            if (!(this._groups))
            {
                this._groups = new Vector.<UiGroup>();
            };
            this._groups.push(new UiGroup(groupName, exclusive, permanent));
        }

        public function getUi(name:String):UiData
        {
            return (this._uis[name]);
        }

        public function toString():String
        {
            var result:String = ("ID:" + this._id);
            if (this._name)
            {
                result = (result + ("\nName:" + this._name));
            };
            if (this._trusted)
            {
                result = (result + ("\nTrusted:" + this._trusted));
            };
            if (this._author)
            {
                result = (result + ("\nAuthor:" + this._author));
            };
            if (this._description)
            {
                result = (result + ("\nDescription:" + this._description));
            };
            return (result);
        }

        public function destroy():void
        {
            if (this._loader)
            {
                this._loader.unloadAndStop(true);
            };
        }

        public function usedApiList(callBack:Function):void
        {
            if (this._apiScriptAnalyserCallback)
            {
                if (!(this._scriptAnalyser))
                {
                    this._scriptAnalyser = new ModuleScriptAnalyzer(this, this.onScriptAnalyserReady, null);
                };
                this._apiScriptAnalyserCallback[callBack] = callBack;
            }
            else
            {
                (callBack(this._scriptAnalyser.apis));
            };
        }

        public function usedHookList(callBack:Function):void
        {
            if (this._hookScriptAnalyserCallback)
            {
                if (!(this._scriptAnalyser))
                {
                    this._scriptAnalyser = new ModuleScriptAnalyzer(this, this.onScriptAnalyserReady, null);
                };
                this._hookScriptAnalyserCallback[callBack] = callBack;
            }
            else
            {
                (callBack(this._scriptAnalyser.hooks));
            };
        }

        public function usedActionList(callBack:Function):void
        {
            if (this._actionScriptAnalyserCallback)
            {
                if (!(this._scriptAnalyser))
                {
                    this._scriptAnalyser = new ModuleScriptAnalyzer(this, this.onScriptAnalyserReady, null);
                };
                this._actionScriptAnalyserCallback[callBack] = callBack;
            }
            else
            {
                (callBack(this._scriptAnalyser.actions));
            };
        }

        private function initScriptAnalyser():void
        {
            if (!(this._scriptAnalyser))
            {
                this._scriptAnalyser = new ModuleScriptAnalyzer(this, this.onScriptAnalyserReady, this._moduleAppDomain);
            };
        }

        private function onScriptAnalyserReady():void
        {
            var f:Function;
            for each (f in this._actionScriptAnalyserCallback)
            {
                (f(this._scriptAnalyser.actions));
            };
            for each (f in this._hookScriptAnalyserCallback)
            {
                (f(this._scriptAnalyser.hooks));
            };
            for each (f in this._apiScriptAnalyserCallback)
            {
                (f(this._scriptAnalyser.apis));
            };
            this._actionScriptAnalyserCallback = null;
            this._hookScriptAnalyserCallback = null;
            this._apiScriptAnalyserCallback = null;
        }

        protected function fillFromXml(xml:XML, nativePath:String, id:String):void
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
            this.setProperty("name", xml..header..name);
            this.setProperty("version", xml..header..version);
            this.setProperty("gameVersion", xml..header..gameVersion);
            this.setProperty("author", xml..header..author);
            this.setProperty("description", xml..header..description);
            this.setProperty("shortDescription", xml..header..shortDescription);
            this.setProperty("script", xml..script);
            this.setProperty("shortcuts", xml..shortcuts);
            this._rawXml = xml;
            nativePath = nativePath.split("app:/").join("");
            if ((((nativePath.indexOf("file://") == -1)) && (!((nativePath.substr(0, 2) == "\\\\")))))
            {
                nativePath = ("file://" + nativePath);
            };
            this._id = id;
            if (this.script)
            {
                this._script = ((nativePath + "/") + this.script);
            };
            if (this.shortcuts)
            {
                this._shortcuts = ((nativePath + "/") + this.shortcuts);
            };
            this._rootPath = (nativePath + "/");
            this._storagePath = unescape((this._rootPath + "storage/")).replace("file://", "");
            var iconPath:String = xml..header..icon;
            if (((iconPath) && (iconPath.length)))
            {
                this._iconUri = new Uri((this._rootPath + iconPath));
            };
            this._groups = new Vector.<UiGroup>();
            for each (group in xml.uiGroup)
            {
                uiNames = new Array();
                groupName = group..@name;
                try
                {
                    uisXML = xml.uis.(@group == groupName);
                    for each (uiName in uisXML..@name)
                    {
                        uiNames.push(uiName.toString());
                    };
                }
                catch(e:Error)
                {
                };
                uiGroup = new UiGroup(group.@name, (group.@exclusive.toString() == "true"), (group.@permanent.toString() == "true"), uiNames);
                UiGroupManager.getInstance().registerGroup(uiGroup);
                this._groups.push(uiGroup);
            };
            for each (uis in xml.uis)
            {
                uisGroup = uis.@group.toString();
                for each (ui in uis..ui)
                {
                    if (ui.@group.toString().length)
                    {
                        uisGroup = ui.@group.toString();
                    };
                    file = null;
                    if (ui.@file.toString().length)
                    {
                        if (ui.@file.indexOf("::") != -1)
                        {
                            mod = nativePath.split("Ankama")[0];
                            fileuri = ui.@file;
                            fileuri = fileuri.replace("::", "/");
                            file = (mod + fileuri);
                        }
                        else
                        {
                            file = ((nativePath + "/") + ui.@file);
                        };
                    };
                    uiData = new UiData(this, ui.@name, file, ui.@["class"], uisGroup);
                    this._uis[uiData.name] = uiData;
                };
            };
            for each (path in xml.cachedFiles..path)
            {
                this.cachedFiles.push(path.children().toString());
            };
        }

        private function setProperty(key:String, value:String):void
        {
            if (((value) && (value.length)))
            {
                this[("_" + key)] = value;
            }
            else
            {
                this[("_" + key)] = null;
            };
        }


    }
}//package com.ankamagames.berilia.types.data

