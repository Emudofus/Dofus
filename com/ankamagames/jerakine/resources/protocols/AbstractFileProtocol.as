package com.ankamagames.jerakine.resources.protocols
{
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   
   public class AbstractFileProtocol extends AbstractProtocol implements IProtocol, IResourceObserver
   {
      
      public function AbstractFileProtocol() {
         super();
      }
      
      private static var _loadingFile:Dictionary = new Dictionary(true);
      
      private static var _singleLoadingFile:Dictionary = new Dictionary(true);
      
      public function initAdapter(uri:Uri, forcedAdapter:Class) : void {
         getAdapter(uri,forcedAdapter);
      }
      
      public function getUrl(uri:Uri) : String {
         if((!(uri.fileType == "swf")) || (!uri.subPath) || (uri.subPath.length == 0))
         {
            return uri.normalizedUri;
         }
         return uri.normalizedUriWithoutSubPath;
      }
      
      override protected function release() : void {
         if(_adapter)
         {
            _adapter.free();
         }
         _loadingFile = new Dictionary(true);
         _singleLoadingFile = new Dictionary(true);
      }
      
      public function get adapter() : IAdapter {
         return _adapter;
      }
      
      public function get loadingFile() : Dictionary {
         return _loadingFile;
      }
      
      public function set loadingFile(value:Dictionary) : void {
         _loadingFile = value;
      }
      
      public function get singleLoadingFile() : Dictionary {
         return _singleLoadingFile;
      }
      
      public function set singleLoadingFile(value:Dictionary) : void {
         _singleLoadingFile = value;
      }
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, singleFile:Boolean) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      protected function extractPath(path:String) : String {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
   }
}
