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
      
      override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         var _loc7_:String = null;
         this._uri = param1;
         this._observer2 = param2;
         if(!_themePath)
         {
            _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
         }
         if(param1.protocol == "theme")
         {
            _loc7_ = _themePath + param1.path.replace("file://","");
         }
         else
         {
            _loc7_ = param1.path.replace("file://","");
         }
         var _loc8_:Uri = new Uri(_loc7_);
         super.load(_loc8_,new ResourceObserverWrapper(this._onLoaded,this._onFailed,this._onProgress),param3,param4,param5,param6);
      }
      
      override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void {
         getAdapter(param1,param4);
         var _loc5_:String = param1.path;
         trace(_loc5_);
         _adapter.loadDirectly(param1,extractPath(_loc5_),param2,param3);
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
