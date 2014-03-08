package com.ankamagames.jerakine.lua
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.interfaces.IScriptsPlayer;
   import luaAlchemy.LuaAlchemy;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.utils.ByteArray;
   
   public class LuaPlayer extends EventDispatcher implements IScriptsPlayer
   {
      
      public function LuaPlayer(param1:Boolean=true) {
         super();
         this._luaAlchemy = new LuaAlchemy();
         this._dispatchMessages = param1;
         this._resetOnComplete = false;
      }
      
      private var _luaAlchemy:LuaAlchemy;
      
      private var _dispatchMessages:Boolean;
      
      private var _resetOnComplete:Boolean;
      
      private var _seqApi:Object;
      
      private var _entityApi:Object;
      
      private var _cameraApi:Object;
      
      private var _alwaysShowAuraOnFront:Boolean;
      
      public function get resetOnComplete() : Boolean {
         return this._resetOnComplete;
      }
      
      public function set resetOnComplete(param1:Boolean) : void {
         this._resetOnComplete = param1;
      }
      
      public function addApi(param1:String, param2:*) : void {
         this._luaAlchemy.setGlobal(param1,param2);
         switch(param1)
         {
            case "EntityApi":
               this._entityApi = param2;
               break;
            case "SeqApi":
               this._seqApi = param2;
               break;
            case "CameraApi":
               this._cameraApi = param2;
               break;
         }
      }
      
      public function playScript(param1:String) : void {
         this.init();
         this._luaAlchemy.doStringAsync(param1,this.resultCallback);
      }
      
      public function setGlobal(param1:String, param2:*) : void {
         this._luaAlchemy.setGlobal(param1,param2);
      }
      
      public function playFile(param1:String) : void {
         var _loc2_:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         _loc2_.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         _loc2_.addEventListener(ResourceErrorEvent.ERROR,this.onFileLoadError);
         _loc2_.load(new Uri(param1));
      }
      
      public function reset() : void {
         if(this._seqApi)
         {
            this._seqApi.clear();
         }
         if(this._entityApi)
         {
            this._entityApi.reset();
         }
         if(this._cameraApi)
         {
            this._cameraApi.reset();
         }
      }
      
      private function init() : void {
         if(this._seqApi)
         {
            this._seqApi.clear();
         }
         if(this._entityApi)
         {
            this._entityApi.init();
         }
         this._alwaysShowAuraOnFront = OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront;
         OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront = false;
      }
      
      private function onFileLoaded(param1:ResourceLoadedEvent) : void {
         param1.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         this.init();
         var _loc2_:ByteArray = param1.resource as ByteArray;
         this._luaAlchemy.doStringAsync(_loc2_.readUTFBytes(_loc2_.bytesAvailable),this.resultCallback);
      }
      
      private function onFileLoadError(param1:ResourceErrorEvent) : void {
         var _loc2_:LuaPlayerEvent = new LuaPlayerEvent(LuaPlayerEvent.PLAY_ERROR);
         _loc2_.stackTrace = param1.errorMsg;
         dispatchEvent(_loc2_);
      }
      
      private function resultCallback(param1:Array) : void {
         var _loc3_:LuaPlayerEvent = null;
         var _loc2_:Boolean = param1.shift();
         if(this._dispatchMessages)
         {
            if(_loc2_)
            {
               dispatchEvent(new LuaPlayerEvent(LuaPlayerEvent.PLAY_SUCCESS));
               if(!this._seqApi || !this._seqApi.hasSequences())
               {
                  this.onScriptComplete();
               }
               else
               {
                  if(this._seqApi)
                  {
                     this._seqApi.addCompleteCallback(this.onScriptComplete);
                  }
               }
            }
            else
            {
               this.reset();
               _loc3_ = new LuaPlayerEvent(LuaPlayerEvent.PLAY_ERROR);
               _loc3_.stackTrace = param1[0];
               dispatchEvent(_loc3_);
            }
         }
      }
      
      private function onScriptComplete() : void {
         dispatchEvent(new LuaPlayerEvent(LuaPlayerEvent.PLAY_COMPLETE));
         if(this._resetOnComplete)
         {
            this.reset();
         }
         OptionManager.getOptionManager("tiphon").alwaysShowAuraOnFront = this._alwaysShowAuraOnFront;
      }
   }
}
