package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractFileProtocol;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.filesystem.FileMode;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   
   public class FileFlashProtocol extends AbstractFileProtocol
   {
      
      public function FileFlashProtocol() {
         this._openDict = new Dictionary();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FileFlashProtocol));
      
      private var _openDict:Dictionary;
      
      override public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean) : void {
         var file:File = null;
         var fs:FileStream = null;
         if(singleFile)
         {
            singleLoadingFile[uri] = observer;
            file = new File(uri.path);
            fs = new FileStream();
            fs.addEventListener(Event.COMPLETE,this.onOpenAsyncComplete);
            this._openDict[fs] = 
               {
                  "uri":uri,
                  "observer":observer,
                  "adapter":forcedAdapter,
                  "dispatchProgress":dispatchProgress
               };
            try
            {
               fs.openAsync(file,FileMode.READ);
            }
            catch(e:IOError)
            {
               onFailed(uri,e.toString(),e.errorID);
            }
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
               file = new File(uri.path);
               fs = new FileStream();
               fs.addEventListener(Event.COMPLETE,this.onOpenAsyncComplete);
               this._openDict[fs] = 
                  {
                     "uri":uri,
                     "observer":observer,
                     "adapter":forcedAdapter,
                     "dispatchProgress":dispatchProgress
                  };
               try
               {
                  fs.openAsync(file,FileMode.READ);
               }
               catch(e:IOError)
               {
                  trace(e.message);
                  onFailed(uri,e.toString(),e.errorID);
               }
            }
         }
      }
      
      private function onOpenAsyncComplete(e:Event) : void {
         var fs:FileStream = e.target as FileStream;
         var ba:ByteArray = new ByteArray();
         fs.position = 0;
         fs.readBytes(ba);
         fs.close();
         fs.removeEventListener(Event.COMPLETE,this.onOpenAsyncComplete);
         var args:Object = this._openDict[fs];
         getAdapter(args.uri,args.adapter);
         _adapter.loadFromData(args.uri,ba,new ResourceObserverWrapper(this.onLoaded,this.onFailed,this.onProgress),args.dispatchProgress);
         delete this._openDict[[fs]];
      }
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void {
         var file:File = new File(uri.path);
         var fs:FileStream = new FileStream();
         try
         {
            fs.open(file,FileMode.READ);
         }
         catch(e:IOError)
         {
            onFailed(uri,e.toString(),e.errorID);
            return;
         }
         var ba:ByteArray = new ByteArray();
         fs.readBytes(ba);
         fs.close();
         getAdapter(uri,forcedAdapter);
         _adapter.loadFromData(uri,ba,observer,dispatchProgress);
      }
      
      override protected function extractPath(path:String) : String {
         var absolutePath:String = null;
         var absoluteFile:File = null;
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
         return path;
      }
      
      override public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         var currentUri:Uri = null;
         var waiting:Array = null;
         if((uri.fileType == "swf") && (!(uri.tag == null)) && (uri.tag is Uri))
         {
            currentUri = uri.tag;
         }
         else
         {
            if((uri.fileType == "swl") && (!(uri.tag == null)) && (!(uri.tag.oldUri == null)) && (uri.tag.oldUri is Uri))
            {
               currentUri = uri.tag.oldUri;
            }
            else
            {
               if((!(uri.tag == null)) && (uri.tag is Uri))
               {
                  currentUri = uri.tag;
               }
               else
               {
                  currentUri = uri;
               }
            }
         }
         var observer:IResourceObserver = singleLoadingFile[uri];
         if(observer)
         {
            observer.onLoaded(currentUri,resourceType,resource);
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
                  IResourceObserver(observer).onLoaded(currentUri,resourceType,resource);
               }
            }
         }
      }
      
      override public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         var waiting:Array = null;
         trace("Fail to load: " + uri);
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
