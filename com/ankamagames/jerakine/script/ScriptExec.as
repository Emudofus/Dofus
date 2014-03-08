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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ScriptExec));
      
      private static var _prepared:Boolean;
      
      private static var _scriptCache:ICache;
      
      private static var _rld:IResourceLoader;
      
      private static var _runners:Dictionary;
      
      public static function exec(param1:*, param2:IRunner, param3:Boolean=true, param4:Callback=null, param5:Callback=null) : void {
         var _loc6_:Uri = null;
         var _loc9_:IAdapter = null;
         if(param1 is Uri)
         {
            _loc6_ = param1;
         }
         else
         {
            if(param1 is BinaryScript)
            {
               _loc6_ = new Uri("file://fake_script_url/" + BinaryScript(param1).path);
            }
         }
         if(!_prepared)
         {
            prepare();
         }
         var _loc7_:Object = new Object();
         _loc7_.runner = param2;
         _loc7_.success = param4;
         _loc7_.error = param5;
         var _loc8_:String = _loc6_.toSum();
         if(!_loc6_.loaderContext)
         {
            _loc6_.loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         }
         if(_runners[_loc8_])
         {
            (_runners[_loc8_] as Array).push(_loc7_);
         }
         else
         {
            _runners[_loc8_] = [_loc7_];
         }
         if(param1 is Uri)
         {
            _rld.load(_loc6_,param3?_scriptCache:null);
         }
         else
         {
            _loc9_ = AdapterFactory.getAdapter(_loc6_);
            _loc9_.loadFromData(_loc6_,BinaryScript(param1).data,new ResourceObserverWrapper(onLoadedWrapper,onFailedWrapper),false);
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
      
      private static function onLoaded(param1:ResourceLoadedEvent) : void {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc2_:String = param1.uri.toSum();
         var _loc3_:* = false;
         if(param1.resourceType != ResourceType.RESOURCE_DX)
         {
            _log.error("Cannot execute " + param1.uri + "; not a script.");
            _loc3_ = true;
         }
         for each (_loc4_ in _runners[_loc2_])
         {
            if(_loc3_)
            {
               if(_loc4_.error)
               {
                  Callback(_loc4_.error).exec();
               }
            }
            else
            {
               _loc5_ = (_loc4_.runner as IRunner).run(param1.resource as Class);
               if(_loc5_)
               {
                  if(_loc4_.error)
                  {
                     Callback(_loc4_.error).exec();
                  }
               }
               else
               {
                  if(_loc4_.success)
                  {
                     Callback(_loc4_.success).exec();
                  }
               }
            }
         }
         delete _runners[[_loc2_]];
      }
      
      private static function onError(param1:ResourceErrorEvent) : void {
         var _loc3_:Object = null;
         _log.error("Cannot execute " + param1.uri + "; script not found (" + param1.errorMsg + ").");
         var _loc2_:String = param1.uri.toSum();
         for each (_loc3_ in _runners[_loc2_])
         {
            if(_loc3_.error)
            {
               Callback(_loc3_.error).exec();
            }
         }
         delete _runners[[_loc2_]];
      }
      
      private static function onLoadedWrapper(param1:Uri, param2:uint, param3:*) : void {
         var _loc4_:ResourceLoadedEvent = new ResourceLoadedEvent(ResourceLoadedEvent.LOADED);
         _loc4_.uri = param1;
         _loc4_.resource = param3;
         _loc4_.resourceType = param2;
         onLoaded(_loc4_);
      }
      
      private static function onFailedWrapper(param1:Uri, param2:String, param3:uint) : void {
         var _loc4_:ResourceErrorEvent = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
         _loc4_.uri = param1;
         _loc4_.errorMsg = param2;
         _loc4_.errorCode = param3;
         onError(_loc4_);
      }
   }
}
