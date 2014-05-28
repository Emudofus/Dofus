package com.ankamagames.jerakine.script
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.script.runners.IRunner;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ScriptExec extends Object
   {
      
      public function ScriptExec() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static var _prepared:Boolean;
      
      private static var _scriptCache:ICache;
      
      private static var _rld:IResourceLoader;
      
      private static var _runners:Dictionary;
      
      public static function exec(script:*, runner:IRunner, useCache:Boolean = true, successCallback:Callback = null, errorCallback:Callback = null) : void {
         var scriptUri:Uri = null;
         var ada:IAdapter = null;
         if(script is Uri)
         {
            scriptUri = script;
         }
         else if(script is BinaryScript)
         {
            scriptUri = new Uri("file://fake_script_url/" + BinaryScript(script).path);
         }
         
         if(!_prepared)
         {
            prepare();
         }
         var obj:Object = new Object();
         obj.runner = runner;
         obj.success = successCallback;
         obj.error = errorCallback;
         var uriSum:String = scriptUri.toSum();
         if(!scriptUri.loaderContext)
         {
            scriptUri.loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         if(_runners[uriSum])
         {
            (_runners[uriSum] as Array).push(obj);
         }
         else
         {
            _runners[uriSum] = [obj];
         }
         if(script is Uri)
         {
            _rld.load(scriptUri,useCache?_scriptCache:null);
         }
         else
         {
            ada = AdapterFactory.getAdapter(scriptUri);
            ada.loadFromData(scriptUri,BinaryScript(script).data,new ResourceObserverWrapper(onLoadedWrapper,onFailedWrapper),false);
         }
      }
      
      private static function prepare() : void {
         _rld = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         _rld.addEventListener(ResourceLoadedEvent.LOADED,onLoaded);
         _rld.addEventListener(ResourceErrorEvent.ERROR,onError);
         _scriptCache = new InfiniteCache();
         _runners = new Dictionary(true);
         _prepared = true;
      }
      
      private static function onLoaded(rle:ResourceLoadedEvent) : void {
         var obj:Object = null;
         var returnCode:uint = 0;
         var uriSum:String = rle.uri.toSum();
         var isFailed:Boolean = false;
         if(rle.resourceType != ResourceType.RESOURCE_DX)
         {
            _log.error("Cannot execute " + rle.uri + "; not a script.");
            isFailed = true;
         }
         for each(obj in _runners[uriSum])
         {
            if(isFailed)
            {
               if(obj.error)
               {
                  Callback(obj.error).exec();
               }
            }
            else
            {
               returnCode = (obj.runner as IRunner).run(rle.resource as Class);
               if(returnCode)
               {
                  if(obj.error)
                  {
                     Callback(obj.error).exec();
                  }
               }
               else if(obj.success)
               {
                  Callback(obj.success).exec();
               }
               
            }
         }
         delete _runners[uriSum];
      }
      
      private static function onError(ree:ResourceErrorEvent) : void {
         var obj:Object = null;
         _log.error("Cannot execute " + ree.uri + "; script not found (" + ree.errorMsg + ").");
         var uriSum:String = ree.uri.toSum();
         for each(obj in _runners[uriSum])
         {
            if(obj.error)
            {
               Callback(obj.error).exec();
            }
         }
         delete _runners[uriSum];
      }
      
      private static function onLoadedWrapper(uri:Uri, resourceType:uint, resource:*) : void {
         var rle:ResourceLoadedEvent = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
         rle.uri = uri;
         rle.resource = resource;
         rle.resourceType = resourceType;
         onLoaded(rle);
      }
      
      private static function onFailedWrapper(uri:Uri, errorMsg:String, errorCode:uint) : void {
         var ree:ResourceErrorEvent = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
         ree.uri = uri;
         ree.errorMsg = errorMsg;
         ree.errorCode = errorCode;
         onError(ree);
      }
   }
}
