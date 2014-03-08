package com.ankamagames.berilia.utils
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import flash.system.ApplicationDomain;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import flash.filesystem.File;
   import com.ankamagames.berilia.utils.web.HttpServer;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import flash.utils.setTimeout;
   
   public class ModuleScriptAnalyzer extends Object
   {
      
      public function ModuleScriptAnalyzer(param1:UiModule, param2:Function, param3:ApplicationDomain=null) {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Uri = null;
         var _loc10_:String = null;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         this._actions = [];
         this._hooks = [];
         this._apis = [];
         super();
         if(!_actionList)
         {
            _actionList = new Dictionary();
            _loc4_ = UiModuleManager.getInstance().sharedDefinitionInstance.getActionList();
            for each (_actionList[_loc5_] in _loc4_)
            {
            }
            _apiList = new Dictionary();
            _loc4_ = UiModuleManager.getInstance().sharedDefinitionInstance.getApiList();
            for each (_apiList[_loc6_] in _loc4_)
            {
            }
            _hookList = new Dictionary();
            _loc4_ = UiModuleManager.getInstance().sharedDefinitionInstance.getHookList();
            for each (_hookList[_loc7_] in _loc4_)
            {
            }
         }
         this._readyFct = param2;
         if(!param3)
         {
            _loc8_ = param1.script;
            if(ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket"))
            {
               _loc10_ = File.applicationDirectory.nativePath.split("\\").join("/");
               if(_loc8_.indexOf(_loc10_) != -1)
               {
                  _loc8_ = _loc8_.substr(_loc8_.indexOf(_loc10_) + _loc10_.length);
               }
               _loc8_ = HttpServer.getInstance().getUrlTo(_loc8_);
               _loc9_ = new Uri(_loc8_);
               this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onSwfLoaded);
               this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onSwfFailed);
               this._loader.load(_loc9_,null,AdvancedSwfAdapter,true);
            }
            else
            {
               throw new Error("Need Air 2 to analyze module script");
            }
         }
         else
         {
            this.process(param3);
            setTimeout(param2,1);
         }
      }
      
      private static var _actionList:Dictionary;
      
      private static var _apiList:Dictionary;
      
      private static var _hookList:Dictionary;
      
      private var _loader:IResourceLoader;
      
      private var _actions:Array;
      
      private var _hooks:Array;
      
      private var _apis:Array;
      
      private var _readyFct:Function;
      
      public function get actions() : Array {
         return this._actions;
      }
      
      public function get hooks() : Array {
         return this._hooks;
      }
      
      public function get apis() : Array {
         return this._apis;
      }
      
      private function onSwfLoaded(param1:ResourceLoadedEvent) : void {
         var _loc2_:ASwf = param1.resource;
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onSwfLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onSwfFailed);
         this.process(_loc2_.applicationDomain);
         this._readyFct();
      }
      
      private function process(param1:ApplicationDomain) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         for each (_loc2_ in _actionList)
         {
            if(param1.hasDefinition("d2actions::" + _loc2_))
            {
               this._actions.push(_loc2_);
            }
         }
         for each (_loc3_ in _hookList)
         {
            if(param1.hasDefinition("d2hooks::" + _loc3_))
            {
               this._hooks.push(_loc3_);
            }
         }
         for each (_loc4_ in _apiList)
         {
            if(param1.hasDefinition("d2api::" + _loc4_))
            {
               this._apis.push(_loc4_);
            }
         }
      }
      
      private function onSwfFailed(param1:ResourceErrorEvent) : void {
         this._readyFct();
      }
   }
}
