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
      
      override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         if((param6) && (!(param1.fileType == "swf") || !param1.subPath || param1.subPath.length == 0))
         {
            singleLoadingFile[param1] = param2;
            this.loadDirectly(param1,this,param3,param5);
         }
         else
         {
            if(loadingFile[getUrl(param1)])
            {
               loadingFile[getUrl(param1)].push(param2);
            }
            else
            {
               loadingFile[getUrl(param1)] = [param2];
               this.loadDirectly(param1,this,param3,param5);
            }
         }
      }
      
      override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void {
         getAdapter(param1,param4);
         _adapter.loadDirectly(param1,this.extractPath(param1.path),param2,param3);
      }
      
      override protected function extractPath(param1:String) : String {
         var _loc3_:String = null;
         var _loc4_:File = null;
         var _loc2_:String = param1;
         if(param1.indexOf("..") != -1)
         {
            if(param1.indexOf("./") == 0)
            {
               _loc3_ = File.applicationDirectory.nativePath + File.separator + param1;
            }
            else
            {
               if(param1.indexOf("/./") != -1)
               {
                  _loc3_ = File.applicationDirectory.nativePath + File.separator + param1.substr(param1.indexOf("/./") + 3);
               }
               else
               {
                  _loc3_ = param1;
               }
            }
            _loc4_ = new File(_loc3_);
            param1 = _loc4_.url.replace("file:///","");
         }
         if(param1.indexOf("\\\\") != -1)
         {
            param1 = "file://" + param1.substr(param1.indexOf("\\\\"));
         }
         if(!(localDirectory == null) && param1.indexOf("./") == 0)
         {
            param1 = localDirectory + param1.substr(2);
         }
         if(!(SystemManager.getSingleton().os == OperatingSystem.WINDOWS) && param1.charAt(0) == "/" && !(param1.charAt(1) == "/"))
         {
            param1 = "/" + param1;
         }
         return param1;
      }
      
      override public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         var _loc5_:Array = null;
         var _loc4_:IResourceObserver = singleLoadingFile[param1];
         if(_loc4_)
         {
            _loc4_.onLoaded(param1,param2,param3);
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
                  IResourceObserver(_loc4_).onLoaded(param1,param2,param3);
               }
            }
         }
      }
      
      override public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         var _loc5_:Array = null;
         _log.warn("onFailed " + param1);
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
