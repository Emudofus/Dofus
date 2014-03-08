package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   
   public class PakProtocol2 extends AbstractProtocol implements IProtocol
   {
      
      public function PakProtocol2() {
         super();
      }
      
      private static var _indexes:Dictionary = new Dictionary();
      
      private static var _properties:Dictionary = new Dictionary();
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PakProtocol2));
      
      public function getFilesIndex(param1:Uri) : Dictionary {
         var _loc2_:* = _indexes[param1.path];
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
         var fileStream:FileStream = null;
         var uri:Uri = param1;
         var observer:IResourceObserver = param2;
         var dispatchProgress:Boolean = param3;
         var cache:ICache = param4;
         var forcedAdapter:Class = param5;
         var uniqueFile:Boolean = param6;
         if(!_indexes[uri.path])
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
         fileStream = index.stream;
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
         var _loc6_:FileStream = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:uint = 0;
         var _loc18_:String = null;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc2_:Uri = param1;
         var _loc3_:File = _loc2_.toFile();
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:Dictionary = new Dictionary();
         _indexes[param1.path] = _loc4_;
         _properties[param1.path] = _loc5_;
         while((_loc3_) && (_loc3_.exists))
         {
            _loc6_ = new FileStream();
            _loc6_.open(_loc3_,FileMode.READ);
            _loc7_ = _loc6_.readUnsignedByte();
            _loc8_ = _loc6_.readUnsignedByte();
            if(!(_loc7_ == 2) || !(_loc8_ == 1))
            {
               return null;
            }
            _loc6_.position = _loc3_.size - 24;
            _loc9_ = _loc6_.readUnsignedInt();
            _loc10_ = _loc6_.readUnsignedInt();
            _loc11_ = _loc6_.readUnsignedInt();
            _loc12_ = _loc6_.readUnsignedInt();
            _loc13_ = _loc6_.readUnsignedInt();
            _loc14_ = _loc6_.readUnsignedInt();
            _loc6_.position = _loc13_;
            _loc3_ = null;
            _loc17_ = 0;
            while(_loc17_ < _loc14_)
            {
               _loc15_ = _loc6_.readUTF();
               _loc16_ = _loc6_.readUTF();
               _loc5_[_loc15_] = _loc16_;
               if(_loc15_ == "link")
               {
                  _loc21_ = _loc2_.path.lastIndexOf("/");
                  if(_loc21_ != -1)
                  {
                     _loc2_ = new Uri(_loc2_.path.substr(0,_loc21_) + "/" + _loc16_);
                  }
                  else
                  {
                     _loc2_ = new Uri(_loc16_);
                  }
                  _loc3_ = _loc2_.toFile();
               }
               _loc17_++;
            }
            _loc6_.position = _loc11_;
            _loc17_ = 0;
            while(_loc17_ < _loc12_)
            {
               _loc18_ = _loc6_.readUTF();
               _loc19_ = _loc6_.readInt();
               _loc20_ = _loc6_.readInt();
               _loc4_[_loc18_] = 
                  {
                     "o":_loc19_ + _loc9_,
                     "l":_loc20_,
                     "stream":_loc6_
                  };
               _loc17_++;
            }
         }
         return _loc6_;
      }
   }
}
