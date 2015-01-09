package com.ankamagames.dofus.modules.utils
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import flash.system.LoaderContext;
    import flash.filesystem.File;
    import nochump.util.zip.ZipFile;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.managers.LangManager;
    import com.ankamagames.jerakine.types.Uri;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import com.ankamagames.dofus.modules.utils.actions.ModuleListRequestAction;
    import com.ankamagames.dofus.modules.utils.actions.ModuleInstallRequestAction;
    import com.ankamagames.dofus.modules.utils.actions.ModuleDeleteRequestAction;
    import com.ankamagames.dofus.modules.utils.actions.InstalledModuleListRequestAction;
    import com.ankamagames.dofus.modules.utils.actions.InstalledModuleInfoRequestAction;
    import com.ankamagames.berilia.utils.ModuleInspector;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import flash.filesystem.FileMode;
    import com.ankamagames.dofus.modules.utils.actions.ModuleInstallConfirmAction;
    import com.ankamagames.dofus.modules.utils.actions.ModuleInstallCancelAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.json.JSON;
    import nochump.util.zip.ZipEntry;
    import com.ankamagames.jerakine.utils.crypto.CRC32;

    public class ModuleInstallerFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthentificationFrame));
        private static const _priority:int = Priority.NORMAL;//0

        private var _loader:IResourceLoader;
        private var _contextLoader:LoaderContext;
        private var _modulesDirectory:File;
        private var _pendingZipToInstall:ZipFile;
        private var _pendingZipDm:XML;
        private var _installedModuleDm:Dictionary;

        public function ModuleInstallerFrame()
        {
            this._installedModuleDm = new Dictionary();
            super();
        }

        public function pushed():Boolean
        {
            this._contextLoader = new LoaderContext();
            this._contextLoader.checkPolicyFile = true;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            var uiRoot:String = LangManager.getInstance().getEntry("config.mod.path");
            if (((!((uiRoot.substr(0, 2) == "\\\\"))) && (!((uiRoot.substr(1, 2) == ":/")))))
            {
                this._modulesDirectory = new File(((File.applicationDirectory.nativePath + File.separator) + uiRoot));
            }
            else
            {
                this._modulesDirectory = new File(uiRoot);
            };
            return (true);
        }

        public function pulled():Boolean
        {
            this._loader.removeEventListener(ResourceErrorEvent.ERROR, this.onLoadError);
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onLoad);
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:Uri;
            var _local_3:Uri;
            var _local_4:String;
            var _local_5:XML;
            var _local_6:File;
            var _local_7:FileStream;
            var _local_8:ByteArray;
            var _local_9:*;
            switch (true)
            {
                case (msg is ModuleListRequestAction):
                    _local_2 = new Uri(ModuleListRequestAction(msg).moduleListUrl);
                    _local_2.loaderContext = this._contextLoader;
                    this._loader.load(_local_2);
                    return (true);
                case (msg is ModuleInstallRequestAction):
                    _local_3 = new Uri(ModuleInstallRequestAction(msg).moduleUrl);
                    _local_3.loaderContext = this._contextLoader;
                    this._loader.load(_local_3);
                    return (true);
                case (msg is ModuleDeleteRequestAction):
                    this.deleteModule(ModuleDeleteRequestAction(msg).moduleDirectory);
                    return (true);
                case (msg is InstalledModuleListRequestAction):
                    this.searchInstalledModule();
                    return (true);
                case (msg is InstalledModuleInfoRequestAction):
                    _local_4 = InstalledModuleInfoRequestAction(msg).moduleId;
                    _local_5 = this._installedModuleDm[_local_4];
                    if (!(_local_5))
                    {
                        _local_5 = ModuleInspector.getDmFile(new File(((this._modulesDirectory.nativePath + File.separator) + _local_4)));
                        this._installedModuleDm[_local_4] = _local_5;
                        if (!(_local_5))
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 7);
                            break;
                        };
                    };
                    _local_6 = new File(((((this._modulesDirectory.nativePath + File.separator) + _local_4) + File.separator) + _local_5.script));
                    _local_7 = new FileStream();
                    _local_8 = new ByteArray();
                    _local_7.open(_local_6, FileMode.READ);
                    _local_7.readBytes(_local_8);
                    _local_7.close();
                    _local_9 = ModuleInspector.getScriptHookAndAction(_local_8);
                    KernelEventsManager.getInstance().processCallback(HookList.ApisHooksActionsList, _local_9);
                    return (true);
                case (msg is ModuleInstallConfirmAction):
                    if (ModuleInstallConfirmAction(msg).isUpdate)
                    {
                        this.updateModule();
                    }
                    else
                    {
                        this.installModule();
                    };
                    this._pendingZipToInstall = null;
                    this._pendingZipDm = null;
                    return (true);
                case (msg is ModuleInstallCancelAction):
                    this._pendingZipToInstall = null;
                    this._pendingZipDm = null;
                    KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress, -1);
                    return (true);
            };
            return (false);
        }

        public function get priority():int
        {
            return (_priority);
        }

        private function onLoad(e:ResourceLoadedEvent):void
        {
            var _local_2:*;
            switch (e.uri.fileType.toLowerCase())
            {
                case "json":
                    _local_2 = JSON.decode(e.resource, true);
                    if ((_local_2 is Array))
                    {
                        this.processJsonList(_local_2);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.ModuleList, []);
                    };
                    return;
                case "zip":
                    this._pendingZipToInstall = e.resource;
                    this.getZippedModuleInformations(e.resource);
                    return;
                default:
                    KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 2);
            };
        }

        private function processJsonList(jsonArray:*):void
        {
            var moduleEntry:*;
            var dmVersionArray:Array;
            var entryVersionArray:Array;
            var i:int;
            var moduleDm:XML;
            for each (moduleEntry in jsonArray)
            {
                moduleDm = this._installedModuleDm[((moduleEntry.author + "_") + moduleEntry.name)];
                if (moduleDm)
                {
                    moduleEntry.exist = true;
                    moduleEntry.upToDate = true;
                    dmVersionArray = String(moduleDm.header.version).split(".");
                    entryVersionArray = String(moduleEntry.version).split(".");
                    while (dmVersionArray.length < entryVersionArray.length)
                    {
                        dmVersionArray.push(0);
                    };
                    while (dmVersionArray.length > entryVersionArray.length)
                    {
                        entryVersionArray.push(0);
                    };
                    i = 0;
                    while (i < dmVersionArray.length)
                    {
                        if (dmVersionArray[i] < entryVersionArray[i])
                        {
                            moduleEntry.upToDate = false;
                        };
                        i++;
                    };
                    moduleEntry.isEnabled = moduleDm.header.isEnabled;
                }
                else
                {
                    moduleEntry.exist = false;
                };
            };
            KernelEventsManager.getInstance().processCallback(HookList.ModuleList, jsonArray);
        }

        private function getZippedModuleInformations(zipFile:ZipFile):void
        {
            var entry:ZipEntry;
            var rawData:ByteArray;
            var hooksActionsApis:*;
            var dmData:XML = ModuleInspector.getZipDmFile(zipFile);
            if (((!(dmData)) || (!(ModuleInspector.checkArchiveValidity(zipFile)))))
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 3);
                return;
            };
            this._pendingZipDm = dmData;
            var scriptName:String = dmData.script;
            for each (entry in zipFile.entries)
            {
                if (entry.name == scriptName)
                {
                    rawData = zipFile.getInput(entry);
                    break;
                };
            };
            if (rawData)
            {
                hooksActionsApis = ModuleInspector.getScriptHookAndAction(rawData);
                KernelEventsManager.getInstance().processCallback(HookList.ApisHooksActionsList, hooksActionsApis);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 3);
            };
        }

        private function installModule():void
        {
            var entry:ZipEntry;
            var writeStream:FileStream;
            var unzipedFile:File;
            var unzipedData:ByteArray;
            if (((!(this._pendingZipDm)) || (!(this._pendingZipToInstall))))
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 6);
                return;
            };
            var instalModuleDirectory:File = new File(((((this._modulesDirectory.nativePath + File.separator) + this._pendingZipDm.header.author) + "_") + this._pendingZipDm.header.name));
            instalModuleDirectory.createDirectory();
            var fileNumber:int = this._pendingZipToInstall.entries.length;
            var totalTreatedFile:int;
            for each (entry in this._pendingZipToInstall.entries)
            {
                totalTreatedFile++;
                unzipedFile = new File(((instalModuleDirectory.nativePath + File.separator) + entry.name));
                if (!(unzipedFile.exists))
                {
                    if (entry.isDirectory())
                    {
                        unzipedFile.createDirectory();
                    }
                    else
                    {
                        this.writeZipEntry(unzipedData, entry, writeStream, unzipedFile, this._pendingZipToInstall);
                    };
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 6);
                    return;
                };
            };
            if (totalTreatedFile == fileNumber)
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress, 1);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 6);
            };
            this._installedModuleDm[((this._pendingZipDm.header.author + "_") + this._pendingZipDm.header.name)] = this._pendingZipDm;
        }

        private function updateModule():void
        {
            var entry:ZipEntry;
            var writeStream:FileStream;
            var readStream:FileStream;
            var unzipedFile:File;
            var unzipedData:ByteArray;
            var buffer:ByteArray;
            var fileCrcValue:uint;
            var fileCrc:CRC32 = new CRC32();
            if (((!(this._pendingZipDm)) || (!(this._pendingZipToInstall))))
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 3);
                return;
            };
            var updateModuleDirectory:File = new File(((((this._modulesDirectory.nativePath + File.separator) + this._pendingZipDm.header.author) + "_") + this._pendingZipDm.header.name));
            if (!(updateModuleDirectory.exists))
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress, 4);
            };
            var fileNumber:int = this._pendingZipToInstall.entries.length;
            var totalTreatedFile:int;
            for each (entry in this._pendingZipToInstall.entries)
            {
                totalTreatedFile++;
                unzipedFile = new File(((updateModuleDirectory.nativePath + File.separator) + entry.name));
                if (!(unzipedFile.exists))
                {
                    if (entry.isDirectory())
                    {
                        unzipedFile.createDirectory();
                    }
                    else
                    {
                        this.writeZipEntry(unzipedData, entry, writeStream, unzipedFile, this._pendingZipToInstall);
                    };
                }
                else
                {
                    if (!(entry.isDirectory()))
                    {
                        buffer = new ByteArray();
                        readStream = new FileStream();
                        readStream.open(unzipedFile, FileMode.READ);
                        readStream.readBytes(buffer, 0, readStream.bytesAvailable);
                        readStream.close();
                        fileCrc.update(buffer, 0, buffer.bytesAvailable);
                        fileCrcValue = fileCrc.getValue();
                        if (fileCrcValue != entry.crc)
                        {
                            unzipedFile.deleteFile();
                            this.writeZipEntry(unzipedData, entry, writeStream, unzipedFile, this._pendingZipToInstall);
                        };
                    };
                };
            };
            if (totalTreatedFile == fileNumber)
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress, 1);
            }
            else
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 3);
            };
        }

        private function writeZipEntry(unzipedData:ByteArray, entry:ZipEntry, writeStream:FileStream, unzipedFile:File, zipFile:ZipFile):void
        {
            unzipedData = zipFile.getInput(entry);
            writeStream = new FileStream();
            writeStream.open(unzipedFile, FileMode.WRITE);
            writeStream.writeBytes(unzipedData, 0, unzipedData.bytesAvailable);
            writeStream.close();
        }

        private function deleteModule(directoryName:String):void
        {
            var toDelete:File = new File(((this._modulesDirectory.nativePath + File.separator) + directoryName));
            if (!(toDelete.exists))
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 5);
            }
            else
            {
                toDelete.deleteDirectory(true);
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationProgress, -1);
            };
            this._installedModuleDm[directoryName] = null;
        }

        private function searchInstalledModule():void
        {
            var subDir:File;
            var dmContent:XML;
            var isTrusted:Boolean;
            var rootFile:File = this._modulesDirectory;
            var allModulesDm:XML = new XML("<Root></Root>");
            for each (subDir in rootFile.getDirectoryListing())
            {
                if (subDir.isDirectory)
                {
                    dmContent = ModuleInspector.getDmFile(subDir);
                    if (dmContent)
                    {
                        isTrusted = ModuleInspector.checkIfModuleTrusted(((subDir.nativePath + File.separator) + dmContent.script));
                        dmContent.header.isTrusted = isTrusted;
                        dmContent.header.isEnabled = ModuleInspector.isModuleEnabled(subDir.name, isTrusted);
                        this._installedModuleDm[subDir.name] = dmContent;
                        allModulesDm.appendChild(dmContent.header);
                    };
                };
            };
            KernelEventsManager.getInstance().processCallback(HookList.InstalledModuleList, allModulesDm.toXMLString());
        }

        private function onLoadError(e:ResourceErrorEvent):void
        {
            _log.error((((("Cannot load file " + e.uri) + "(") + e.errorMsg) + ")"));
            if (e.uri.fileType.toLowerCase() == "json")
            {
                KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 1);
            }
            else
            {
                if (e.uri.fileType.toLowerCase() == "zip")
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 8);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ModuleInstallationError, 0);
                };
            };
        }


    }
}//package com.ankamagames.dofus.modules.utils

