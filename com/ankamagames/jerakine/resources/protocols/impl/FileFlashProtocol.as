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
      
      override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         var file:File = null;
         var fs:FileStream = null;
         var uri:Uri = param1;
         var observer:IResourceObserver = param2;
         var dispatchProgress:Boolean = param3;
         var cache:ICache = param4;
         var forcedAdapter:Class = param5;
         var singleFile:Boolean = param6;
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
      
      private function onOpenAsyncComplete(param1:Event) : void {
         var _loc2_:FileStream = param1.target as FileStream;
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.position = 0;
         _loc2_.readBytes(_loc3_);
         _loc2_.close();
         _loc2_.removeEventListener(Event.COMPLETE,this.onOpenAsyncComplete);
         var _loc4_:Object = this._openDict[_loc2_];
         getAdapter(_loc4_.uri,_loc4_.adapter);
         _adapter.loadFromData(_loc4_.uri,_loc3_,new ResourceObserverWrapper(this.onLoaded,this.onFailed,this.onProgress),_loc4_.dispatchProgress);
         delete this._openDict[[_loc2_]];
      }
      
      override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void {
         var uri:Uri = param1;
         var observer:IResourceObserver = param2;
         var dispatchProgress:Boolean = param3;
         var forcedAdapter:Class = param4;
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
      
      override protected function extractPath(param1:String) : String {
         var _loc2_:String = null;
         var _loc3_:File = null;
         if(param1.indexOf("..") != -1)
         {
            if(param1.indexOf("./") == 0)
            {
               _loc2_ = File.applicationDirectory.nativePath + File.separator + param1;
            }
            else
            {
               if(param1.indexOf("/./") != -1)
               {
                  _loc2_ = File.applicationDirectory.nativePath + File.separator + param1.substr(param1.indexOf("/./") + 3);
               }
               else
               {
                  _loc2_ = param1;
               }
            }
            _loc3_ = new File(_loc2_);
            param1 = _loc3_.url.replace("file:///","");
         }
         if(param1.indexOf("\\\\") != -1)
         {
            param1 = "file://" + param1.substr(param1.indexOf("\\\\"));
         }
         return param1;
      }
      
      override public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         var _loc4_:Uri = null;
         var _loc6_:Array = null;
         if(param1.fileType == "swf" && !(param1.tag == null) && param1.tag is Uri)
         {
            _loc4_ = param1.tag;
         }
         else
         {
            if(param1.fileType == "swl" && !(param1.tag == null) && !(param1.tag.oldUri == null) && param1.tag.oldUri is Uri)
            {
               _loc4_ = param1.tag.oldUri;
            }
            else
            {
               if(!(param1.tag == null) && param1.tag is Uri)
               {
                  _loc4_ = param1.tag;
               }
               else
               {
                  _loc4_ = param1;
               }
            }
         }
         var _loc5_:IResourceObserver = singleLoadingFile[param1];
         if(_loc5_)
         {
            _loc5_.onLoaded(_loc4_,param2,param3);
            delete singleLoadingFile[[param1]];
         }
         else
         {
            if((loadingFile[getUrl(param1)]) && (loadingFile[getUrl(param1)].length))
            {
               _loc6_ = loadingFile[getUrl(param1)];
               delete loadingFile[[getUrl(param1)]];
               for each (_loc5_ in _loc6_)
               {
                  IResourceObserver(_loc5_).onLoaded(_loc4_,param2,param3);
               }
            }
         }
      }
      
      override public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         var _loc5_:Array = null;
         trace("Fail to load: " + param1);
         var _loc4_:IResourceObserver = singleLoadingFile[param1];
         if(_loc4_)
         {
            _loc4_.onFailed(param1,param2,param3);
            delete singleLoadingFile[[param1]];
         }
         else
         {
            if((loadingFile[getUrl(param1)]) && (loadingFile[getUrl(param1)].length))
            {
               _loc5_ = loadingFile[getUrl(param1)];
               delete loadingFile[[getUrl(param1)]];
               for each (_loc4_ in _loc5_)
               {
                  IResourceObserver(_loc4_).onFailed(param1,param2,param3);
               }
            }
         }
      }
      
      override public function onProgress(param1:Uri, param2:uint, param3:uint) : void {
         var _loc5_:Array = null;
         var _loc4_:IResourceObserver = singleLoadingFile[param1];
         if(_loc4_)
         {
            _loc4_.onProgress(param1,param2,param3);
            delete singleLoadingFile[[param1]];
         }
         else
         {
            if((loadingFile[getUrl(param1)]) && (loadingFile[getUrl(param1)]) && (loadingFile[getUrl(param1)].length))
            {
               _loc5_ = loadingFile[getUrl(param1)];
               delete loadingFile[[getUrl(param1)]];
               for each (_loc4_ in _loc5_)
               {
                  IResourceObserver(_loc4_).onProgress(param1,param2,param3);
               }
            }
         }
      }
   }
}
