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
      
      public function initAdapter(param1:Uri, param2:Class) : void {
         getAdapter(param1,param2);
      }
      
      public function getUrl(param1:Uri) : String {
         if(!(param1.fileType == "swf") || !param1.subPath || param1.subPath.length == 0)
         {
            return param1.normalizedUri;
         }
         return param1.normalizedUriWithoutSubPath;
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
      
      public function set loadingFile(param1:Dictionary) : void {
         _loadingFile = param1;
      }
      
      public function get singleLoadingFile() : Dictionary {
         return _singleLoadingFile;
      }
      
      public function set singleLoadingFile(param1:Dictionary) : void {
         _singleLoadingFile = param1;
      }
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      public function onProgress(param1:Uri, param2:uint, param3:uint) : void {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
      
      protected function extractPath(param1:String) : String {
         throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
      }
   }
}
