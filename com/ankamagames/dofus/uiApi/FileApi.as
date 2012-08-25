package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.modules.utils.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class FileApi extends Object implements IApi
    {
        private var _loader:IResourceLoader;
        private var _module:UiModule;
        private var _openedFiles:Dictionary;

        public function FileApi()
        {
            this._openedFiles = new Dictionary();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            var mfs:ModuleFilestream;
            this._module = null;
            var _loc_2:int = 0;
            var _loc_3:* = this._openedFiles;
            do
            {
                
                mfs = _loc_3[_loc_2];
                if (mfs)
                {
                    try
                    {
                        mfs.close();
                    }
                    catch (e:Error)
                    {
                    }
                }
            }while (_loc_3 in _loc_2)
            this._openedFiles = null;
            return;
        }// end function

        public function loadXmlFile(param1:String, param2:Function, param3:Function = null) : void
        {
            if (FileUtils.getExtension(param1).toUpperCase() != "XML")
            {
                throw new ApiError("loadXmlFile can only load file with XML extension");
            }
            if (!param1)
            {
                throw new ApiError("loadXmlFile need a non-null url");
            }
            if (param2 == null)
            {
                throw new ApiError("loadXmlFile need a non-null success callback function");
            }
            param1 = this._module.rootPath + param1.replace("..", "");
            var _loc_4:* = new Uri(param1);
            new Uri(param1).tag = {loadSuccessCallBack:param2, loadErrorCallBack:param3};
            this._loader.load(_loc_4);
            return;
        }// end function

        public function trustedLoadXmlFile(param1:String, param2:Function, param3:Function = null) : void
        {
            if (FileUtils.getExtension(param1).toUpperCase() != "XML")
            {
                throw new ApiError("loadXmlFile can only load file with XML extension");
            }
            if (!param1)
            {
                throw new ApiError("loadXmlFile need a non-null url");
            }
            if (param2 == null)
            {
                throw new ApiError("loadXmlFile need a non-null success callback function");
            }
            var _loc_4:* = new Uri(param1);
            new Uri(param1).tag = {loadSuccessCallBack:param2, loadErrorCallBack:param3};
            this._loader.load(_loc_4);
            return;
        }// end function

        public function openFile(param1:String, param2:String = "update") : ModuleFilestream
        {
            var _loc_3:* = new ModuleFilestream(param1, param2, this._module);
            this._openedFiles[_loc_3] = param1;
            return _loc_3;
        }// end function

        public function deleteFile(param1:String) : void
        {
            param1 = param1.replace(".", "");
            var _loc_2:* = new File(this._module.storagePath + param1 + ".dmf");
            if (_loc_2.exists && !_loc_2.isDirectory)
            {
                _loc_2.deleteFile();
            }
            return;
        }// end function

        public function deleteDir(param1:String, param2:Boolean = true) : void
        {
            param1 = param1.replace(".", "");
            var _loc_3:* = new File(this._module.storagePath + param1 + ".dmf");
            if (_loc_3.exists && _loc_3.isDirectory)
            {
                _loc_3.deleteDirectory(param2);
            }
            return;
        }// end function

        public function getDirectoryContent(param1:String = null, param2:Boolean = false, param3:Boolean = false) : Array
        {
            var _loc_6:Array = null;
            var _loc_7:File = null;
            param1 = param1 ? (param1.replace(".", "")) : ("");
            var _loc_4:Array = [];
            var _loc_5:* = new File(this._module.storagePath + param1);
            if (new File(this._module.storagePath + param1).exists && _loc_5.isDirectory)
            {
                _loc_6 = _loc_5.getDirectoryListing();
                for each (_loc_7 in _loc_6)
                {
                    
                    if (!_loc_7.isDirectory && !param2)
                    {
                        _loc_4.push(_loc_7.name.substr(_loc_7.name.lastIndexOf(".dm")));
                    }
                    if (_loc_7.isDirectory && !param3)
                    {
                        _loc_4.push(_loc_7.name);
                    }
                }
            }
            return _loc_4;
        }// end function

        public function isDirectory(param1:String) : Boolean
        {
            param1 = param1 ? (param1.replace(".", "")) : ("");
            var _loc_2:* = new File(this._module.storagePath + param1);
            return _loc_2.exists && _loc_2.isDirectory;
        }// end function

        public function createDirectory(param1:String) : void
        {
            param1 = param1 ? (param1.replace(".", "")) : ("");
            var _loc_2:* = new File(this._module.storagePath + param1);
            ModuleFilestream.checkCreation(param1, this._module);
            _loc_2.createDirectory();
            return;
        }// end function

        public function getAvaibleSpace() : uint
        {
            return ModuleFileManager.getInstance().getAvaibleSpace(this._module.id);
        }// end function

        public function getUsedSpace() : uint
        {
            return ModuleFileManager.getInstance().getUsedSpace(this._module.id);
        }// end function

        public function getMaxSpace() : uint
        {
            return ModuleFileManager.getInstance().getMaxSpace(this._module.id);
        }// end function

        public function getUsedFileCount() : uint
        {
            return ModuleFileManager.getInstance().getUsedFileCount(this._module.id);
        }// end function

        public function getMaxFileCount() : uint
        {
            return ModuleFileManager.getInstance().getMaxFileCount(this._module.id);
        }// end function

        private function onLoaded(event:ResourceLoadedEvent) : void
        {
            event.uri.tag.loadSuccessCallBack(event.resource);
            return;
        }// end function

        private function onError(event:ResourceErrorEvent) : void
        {
            var e:* = event;
            if (e.uri.tag.loadErrorCallBack)
            {
                try
                {
                    e.uri.tag.loadErrorCallBack(e.errorCode, e.errorMsg);
                }
                catch (e:ArgumentError)
                {
                    throw new ApiError("loadErrorCallBack on loadXmlFile function need two args : onError(errorCode : uint, errorMsg : String)");
                }
            }
            return;
        }// end function

    }
}
