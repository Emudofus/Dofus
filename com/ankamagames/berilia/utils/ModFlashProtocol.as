package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.resources.protocols.impl.FileFlashProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   
   public class ModFlashProtocol extends FileFlashProtocol implements IProtocol
   {
      
      public function ModFlashProtocol() {
         super();
      }
      
      private var _uri:Uri;
      
      private var _observer2:IResourceObserver;
      
      override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         var _loc7_:String = param1.path.substr(0,param1.path.indexOf("/"));
         var _loc8_:String = UiModuleManager.getInstance().getModulePath(_loc7_) + param1.path.substr(param1.path.indexOf("/"));
         var _loc9_:Uri = new Uri(_loc8_);
         this._uri = param1;
         this._observer2 = param2;
         super.load(_loc9_,new ResourceObserverWrapper(this._onLoaded,this._onFailed,this._onProgress),param3,param4,param5,param6);
      }
      
      override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void {
         getAdapter(param1,param4);
         var _loc5_:String = param1.path.substr(0,param1.path.indexOf("/"));
         var _loc6_:String = UiModuleManager.getInstance().getModulePath(_loc5_) + param1.path.substr(param1.path.indexOf("/"));
         _adapter.loadDirectly(param1,extractPath(_loc6_),param2,param3);
      }
      
      private function _onLoaded(param1:Uri, param2:uint, param3:*) : void {
         this._observer2.onLoaded(this._uri,param2,param3);
      }
      
      private function _onFailed(param1:Uri, param2:String, param3:uint) : void {
         this._observer2.onFailed(this._uri,param2,param3);
      }
      
      private function _onProgress(param1:Uri, param2:uint, param3:uint) : void {
         this._observer2.onProgress(this._uri,param2,param3);
      }
   }
}
