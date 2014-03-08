package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.FileStream;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   
   public class PakProtocol extends AbstractProtocol implements IProtocol
   {
      
      public function PakProtocol() {
         super();
      }
      
      private static var _streams:Dictionary = new Dictionary();
      
      private static var _indexes:Dictionary = new Dictionary();
      
      public function getFilesIndex(param1:Uri) : Dictionary {
         var _loc2_:FileStream = _streams[param1.path];
         if(!_loc2_)
         {
            _loc2_ = this.initStream(param1);
            if(!_loc2_)
            {
               return null;
            }
         }
         return _indexes[param1.path];
      }
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         var uri:Uri = param1;
         var observer:IResourceObserver = param2;
         var dispatchProgress:Boolean = param3;
         var cache:ICache = param4;
         var forcedAdapter:Class = param5;
         var uniqueFile:Boolean = param6;
         var fileStream:FileStream = _streams[uri.path];
         if(!fileStream)
         {
            fileStream = this.initStream(uri);
            if(!fileStream)
            {
               if(observer)
               {
                  observer.onFailed(uri,"Unable to find container.",ResourceErrorCode.PAK_NOT_FOUND);
               }
               return;
            }
         }
         var index:Object = _indexes[uri.path][uri.subPath];
         if(!index)
         {
            if(observer)
            {
               observer.onFailed(uri,"Unable to find the file in the container.",ResourceErrorCode.FILE_NOT_FOUND_IN_PAK);
            }
            return;
         }
         var data:ByteArray = new ByteArray();
         fileStream.position = index.o;
         fileStream.readBytes(data,0,index.l);
         getAdapter(uri,forcedAdapter);
         try
         {
            _adapter.loadFromData(uri,data,observer,dispatchProgress);
         }
         catch(e:Object)
         {
            observer.onFailed(uri,"Can\'t load byte array from this adapter.",ResourceErrorCode.INCOMPATIBLE_ADAPTER);
            return;
         }
      }
      
      override protected function release() : void {
      }
      
      override public function cancel() : void {
         if(_adapter)
         {
            _adapter.free();
         }
      }
      
      private function initStream(param1:Uri) : FileStream {
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc2_:File = param1.toFile();
         if(!_loc2_.exists)
         {
            return null;
         }
         var _loc3_:FileStream = new FileStream();
         _loc3_.open(_loc2_,FileMode.READ);
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:int = _loc3_.readInt();
         _loc3_.position = _loc5_;
         while(_loc3_.bytesAvailable > 0)
         {
            _loc6_ = _loc3_.readUTF();
            _loc7_ = _loc3_.readInt();
            _loc8_ = _loc3_.readInt();
            _loc4_[_loc6_] = 
               {
                  "o":_loc7_,
                  "l":_loc8_
               };
         }
         _indexes[param1.path] = _loc4_;
         _streams[param1.path] = _loc3_;
         return _loc3_;
      }
   }
}
