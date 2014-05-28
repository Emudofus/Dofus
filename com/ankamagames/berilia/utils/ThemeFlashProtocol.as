package com.ankamagames.berilia.utils
{
   import com.ankamagames.jerakine.resources.protocols.impl.FileFlashProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   
   public class ThemeFlashProtocol extends FileFlashProtocol implements IProtocol
   {
      
      public function ThemeFlashProtocol() {
         super();
      }
      
      private static var _themePath:String;
      
      private var _uri:Uri;
      
      private var _observer2:IResourceObserver;
      
      override public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean) : void {
         var path:String = null;
         this._uri = uri;
         this._observer2 = observer;
         if(!_themePath)
         {
            _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
         }
         if(uri.protocol == "theme")
         {
            path = _themePath + uri.path.replace("file://","");
         }
         else
         {
            path = uri.path.replace("file://","");
         }
         var realUri:Uri = new Uri(path);
         super.load(realUri,new ResourceObserverWrapper(this._onLoaded,this._onFailed,this._onProgress),dispatchProgress,cache,forcedAdapter,singleFile);
      }
      
      override protected function loadDirectly(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, forcedAdapter:Class) : void {
         getAdapter(uri,forcedAdapter);
         var path:String = uri.path;
         trace(path);
         _adapter.loadDirectly(uri,extractPath(path),observer,dispatchProgress);
      }
      
      private function _onLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         this._observer2.onLoaded(this._uri,resourceType,resource);
      }
      
      private function _onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         this._observer2.onFailed(this._uri,errorMsg,errorCode);
      }
      
      private function _onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void {
         this._observer2.onProgress(this._uri,bytesLoaded,bytesTotal);
      }
   }
}
