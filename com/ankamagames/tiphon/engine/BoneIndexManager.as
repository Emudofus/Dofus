package com.ankamagames.tiphon.engine
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class BoneIndexManager extends EventDispatcher
   {
      
      public function BoneIndexManager() {
         this._index = new Dictionary();
         this._transitions = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(BoneIndexManager));
      
      private static var _self:BoneIndexManager;
      
      public static function getInstance() : BoneIndexManager {
         if(!_self)
         {
            _self = new BoneIndexManager();
         }
         return _self;
      }
      
      private var _loader:IResourceLoader;
      
      private var _index:Dictionary;
      
      private var _transitions:Dictionary;
      
      private var _animNameModifier:Function;
      
      public function init(param1:String) : void {
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onXmlLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onXmlFailed);
         this._loader.load(new Uri(param1));
      }
      
      public function setAnimNameModifier(param1:Function) : void {
         this._animNameModifier = param1;
      }
      
      public function addTransition(param1:uint, param2:String, param3:String, param4:uint, param5:String) : void {
         if(!this._transitions[param1])
         {
            this._transitions[param1] = new Dictionary();
         }
         this._transitions[param1][param2 + "_" + param3 + "_" + param4] = param5;
      }
      
      public function hasTransition(param1:uint, param2:String, param3:String, param4:uint) : Boolean {
         if(this._animNameModifier != null)
         {
            param2 = this._animNameModifier(param1,param2);
            param3 = this._animNameModifier(param1,param3);
         }
         return (this._transitions[param1]) && (!(this._transitions[param1][param2 + "_" + param3 + "_" + param4] == null) || !(this._transitions[param1][param2 + "_" + param3 + "_" + TiphonUtility.getFlipDirection(param4)] == null));
      }
      
      public function getTransition(param1:uint, param2:String, param3:String, param4:uint) : String {
         if(this._animNameModifier != null)
         {
            param2 = this._animNameModifier(param1,param2);
            param3 = this._animNameModifier(param1,param3);
         }
         if(!this._transitions[param1])
         {
            return null;
         }
         if(this._transitions[param1][param2 + "_" + param3 + "_" + param4])
         {
            return this._transitions[param1][param2 + "_" + param3 + "_" + param4];
         }
         return this._transitions[param1][param2 + "_" + param3 + "_" + TiphonUtility.getFlipDirection(param4)];
      }
      
      public function getBoneFile(param1:uint, param2:String) : Uri {
         if(!this._index[param1] || !this._index[param1][param2])
         {
            return new Uri(TiphonConstants.SWF_SKULL_PATH + param1 + ".swl");
         }
         return new Uri(TiphonConstants.SWF_SKULL_PATH + this._index[param1][param2]);
      }
      
      public function hasAnim(param1:uint, param2:String, param3:int) : Boolean {
         return (this._index[param1]) && (this._index[param1][param2]);
      }
      
      public function hasCustomBone(param1:uint) : Boolean {
         return this._index[param1];
      }
      
      public function getAllCustomAnimations(param1:int) : Array {
         var _loc4_:String = null;
         var _loc2_:Dictionary = this._index[param1];
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         for (_loc4_ in _loc2_)
         {
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
      
      private function onXmlLoaded(param1:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onSubXmlLoaded(param1:ResourceLoadedEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onXmlFailed(param1:ResourceErrorEvent) : void {
         _log.error("Impossible de charger ou parser le fichier d\'index d\'animation : " + param1.uri);
      }
      
      private function onAllSubXmlLoaded(param1:ResourceLoaderProgressEvent) : void {
         this._loader = null;
         dispatchEvent(new Event(Event.INIT));
      }
   }
}
