package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
    import com.ankamagames.berilia.types.data.UiModule;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
    import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
    import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
    import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
    import com.ankamagames.jerakine.utils.files.FileUtils;
    import com.ankamagames.berilia.utils.errors.ApiError;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.modules.utils.ModuleFilestream;
    import flash.filesystem.File;
    import com.ankamagames.berilia.utils.ModuleFileManager;

    [InstanciedApi]
    public class FileApi implements IApi 
    {

        private var _loader:IResourceLoader;
        private var _module:UiModule;
        private var _openedFiles:Dictionary;

        public function FileApi()
        {
            this._openedFiles = new Dictionary();
            super();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onError);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded);
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        [HideInFakeClass]
        public function destroy():void
        {
            var mfs:*;
            this._module = null;
            for (mfs in this._openedFiles)
            {
                if (mfs)
                {
                    try
                    {
                        mfs.close();
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            this._openedFiles = null;
        }

        [Untrusted]
        [NoBoxing]
        public function loadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function=null):void
        {
            if (FileUtils.getExtension(url).toUpperCase() != "XML")
            {
                throw (new ApiError("loadXmlFile can only load file with XML extension"));
            };
            if (!(url))
            {
                throw (new ApiError("loadXmlFile need a non-null url"));
            };
            if (loadSuccessCallBack == null)
            {
                throw (new ApiError("loadXmlFile need a non-null success callback function"));
            };
            url = (this._module.rootPath + url.replace("..", ""));
            var uri:Uri = new Uri(url);
            uri.tag = {
                "loadSuccessCallBack":loadSuccessCallBack,
                "loadErrorCallBack":loadErrorCallBack
            };
            this._loader.load(uri);
        }

        [Trusted]
        public function trustedLoadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function=null):void
        {
            if (FileUtils.getExtension(url).toUpperCase() != "XML")
            {
                throw (new ApiError("loadXmlFile can only load file with XML extension"));
            };
            if (!(url))
            {
                throw (new ApiError("loadXmlFile need a non-null url"));
            };
            if (loadSuccessCallBack == null)
            {
                throw (new ApiError("loadXmlFile need a non-null success callback function"));
            };
            var uri:Uri = new Uri(url);
            uri.tag = {
                "loadSuccessCallBack":loadSuccessCallBack,
                "loadErrorCallBack":loadErrorCallBack
            };
            this._loader.load(uri);
        }

        [Untrusted]
        public function openFile(url:String, openMode:String="update"):ModuleFilestream
        {
            var mf:ModuleFilestream = new ModuleFilestream(url, openMode, this._module);
            this._openedFiles[mf] = url;
            return (mf);
        }

        [Untrusted]
        public function deleteFile(url:String):void
        {
            url = ModuleFilestream.cleanUrl(url);
            var file:File = new File(((this._module.storagePath + url) + ".dmf"));
            if (((file.exists) && (!(file.isDirectory))))
            {
                file.deleteFile();
            };
        }

        [Untrusted]
        public function deleteDir(url:String, recursive:Boolean=true):void
        {
            url = ModuleFilestream.cleanUrl(url);
            var file:File = new File((this._module.storagePath + url));
            if (((file.exists) && (file.isDirectory)))
            {
                file.deleteDirectory(recursive);
            };
        }

        [NoBoxing]
        [Untrusted]
        public function getDirectoryContent(url:String=null, hideFiles:Boolean=false, hideDirectories:Boolean=false):Array
        {
            var files:Array;
            var file:File;
            url = ((url) ? ModuleFilestream.cleanUrl(url) : "");
            var result:Array = [];
            var dir:File = new File((this._module.storagePath + url));
            if (((dir.exists) && (dir.isDirectory)))
            {
                files = dir.getDirectoryListing();
                for each (file in files)
                {
                    if (((!(file.isDirectory)) && (!(hideFiles))))
                    {
                        result.push(file.name.substr(file.name.lastIndexOf(".dm")));
                    };
                    if (((file.isDirectory) && (!(hideDirectories))))
                    {
                        result.push(file.name);
                    };
                };
            };
            return (result);
        }

        [NoBoxing]
        [Untrusted]
        public function isDirectory(url:String):Boolean
        {
            url = ((url) ? ModuleFilestream.cleanUrl(url) : "");
            var dir:File = new File((this._module.storagePath + url));
            return (((dir.exists) && (dir.isDirectory)));
        }

        [NoBoxing]
        [Untrusted]
        public function createDirectory(url:String):void
        {
            url = ((url) ? ModuleFilestream.cleanUrl(url) : "");
            var dir:File = new File((this._module.storagePath + url));
            ModuleFilestream.checkCreation(url, this._module);
            dir.createDirectory();
        }

        [Untrusted]
        public function getAvaibleSpace():uint
        {
            return (ModuleFileManager.getInstance().getAvaibleSpace(this._module.id));
        }

        [Untrusted]
        public function getUsedSpace():uint
        {
            return (ModuleFileManager.getInstance().getUsedSpace(this._module.id));
        }

        [Untrusted]
        public function getMaxSpace():uint
        {
            return (ModuleFileManager.getInstance().getMaxSpace(this._module.id));
        }

        [Untrusted]
        public function getUsedFileCount():uint
        {
            return (ModuleFileManager.getInstance().getUsedFileCount(this._module.id));
        }

        [Untrusted]
        public function getMaxFileCount():uint
        {
            return (ModuleFileManager.getInstance().getMaxFileCount(this._module.id));
        }

        private function onLoaded(e:ResourceLoadedEvent):void
        {
            e.uri.tag.loadSuccessCallBack(e.resource);
        }

        private function onError(e:ResourceErrorEvent):void
        {
            if (e.uri.tag.loadErrorCallBack)
            {
                try
                {
                    e.uri.tag.loadErrorCallBack(e.errorCode, e.errorMsg);
                }
                catch(e:ArgumentError)
                {
                    throw (new ApiError("loadErrorCallBack on loadXmlFile function need two args : onError(errorCode : uint, errorMsg : String)"));
                };
            };
        }


    }
}//package com.ankamagames.dofus.uiApi

