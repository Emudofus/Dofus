package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractFileProtocol;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   
   public class FileProtocol extends AbstractFileProtocol
   {
      
      public function FileProtocol() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FileProtocol));
      
      public static var localDirectory:String;
      
      override public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean) : void {
         if((singleFile) && ((!(uri.fileType == "swf")) || (!uri.subPath) || (uri.subPath.length == 0)))
         {
            singleLoadingFile[uri] = observer;
            this.loadDirectly(uri,this,dispatchProgress,forcedAdapter);
         }
         else
         {
            if(loadingFile[getUrl(uri)])
            {
               loadingFile[getUrl(uri)].push(observer);
            }
            else
            {
               loadingFile[getUrl(uri)] = [observer];
               this.loadDirectly(uri,this,dispatchProgress,forcedAdapter);
            }
         }
      }
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void {
         getAdapter(uri,forcedAdapter);
         _adapter.loadDirectly(uri,this.extractPath(uri.path),observer,dispatchProgress);
      }
      
      override protected function extractPath(path:String) : String {
         var absolutePath:String = null;
         var absoluteFile:File = null;
         var originalPath:String = path;
         if(path.indexOf("..") != -1)
         {
            if(path.indexOf("./") == 0)
            {
               absolutePath = File.applicationDirectory.nativePath + File.separator + path;
            }
            else
            {
               if(path.indexOf("/./") != -1)
               {
                  absolutePath = File.applicationDirectory.nativePath + File.separator + path.substr(path.indexOf("/./") + 3);
               }
               else
               {
                  absolutePath = path;
               }
            }
            absoluteFile = new File(absolutePath);
            path = absoluteFile.url.replace("file:///","");
         }
         if(path.indexOf("\\\\") != -1)
         {
            path = "file://" + path.substr(path.indexOf("\\\\"));
         }
         if((!(localDirectory == null)) && (path.indexOf("./") == 0))
         {
            path = localDirectory + path.substr(2);
         }
         if((!(SystemManager.getSingleton().os == OperatingSystem.WINDOWS)) && (path.charAt(0) == "/") && (!(path.charAt(1) == "/")))
         {
            path = "/" + path;
         }
         return path;
      }
      
      override public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         var waiting:Array = null;
         var observer:IResourceObserver = singleLoadingFile[uri];
         if(observer)
         {
            observer.onLoaded(uri,resourceType,resource);
            delete singleLoadingFile[[uri]];
         }
         else
         {
            if((loadingFile[getUrl(uri)]) && (loadingFile[getUrl(uri)].length))
            {
               waiting = loadingFile[getUrl(uri)];
               delete loadingFile[[getUrl(uri)]];
               for each (observer in waiting)
               {
                  IResourceObserver(observer).onLoaded(uri,resourceType,resource);
               }
            }
         }
      }
      
      override public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         var waiting:Array = null;
         _log.warn("onFailed " + uri);
         var observer:IResourceObserver = singleLoadingFile[uri];
         if(observer)
         {
            observer.onFailed(uri,errorMsg,errorCode);
            delete singleLoadingFile[[uri]];
         }
         else
         {
            if((loadingFile[getUrl(uri)]) && (loadingFile[getUrl(uri)].length))
            {
               waiting = loadingFile[getUrl(uri)];
               delete loadingFile[[getUrl(uri)]];
               for each (observer in waiting)
               {
                  IResourceObserver(observer).onFailed(uri,errorMsg,errorCode);
               }
            }
         }
      }
      
      override public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void {
         var waiting:Array = null;
         var observer:IResourceObserver = singleLoadingFile[uri];
         if(observer)
         {
            observer.onProgress(uri,bytesLoaded,bytesTotal);
            delete singleLoadingFile[[uri]];
         }
         else
         {
            if((loadingFile[getUrl(uri)]) && (loadingFile[getUrl(uri)]) && (loadingFile[getUrl(uri)].length))
            {
               waiting = loadingFile[getUrl(uri)];
               delete loadingFile[[getUrl(uri)]];
               for each (observer in waiting)
               {
                  IResourceObserver(observer).onProgress(uri,bytesLoaded,bytesTotal);
               }
            }
         }
      }
   }
}
