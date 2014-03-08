package nochump.util.zip
{
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.events.ProgressEvent;
   import flash.events.Event;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   
   public class ZipFile extends EventDispatcher
   {
      
      public function ZipFile(param1:IDataInput) {
         super();
         this.buf = new ByteArray();
         this.buf.endian = Endian.LITTLE_ENDIAN;
         param1.readBytes(this.buf);
         this.readEntries();
      }
      
      private var buf:ByteArray;
      
      private var entryList:Array;
      
      private var entryTable:Dictionary;
      
      private var locOffsetTable:Dictionary;
      
      public function get entries() : Array {
         return this.entryList;
      }
      
      public function get size() : uint {
         return this.entryList.length;
      }
      
      public function getEntry(param1:String) : ZipEntry {
         return this.entryTable[param1];
      }
      
      public function getInput(param1:ZipEntry, param2:Function=null) : ByteArray {
         var _loc5_:ByteArray = null;
         var _loc6_:Inflater = null;
         this.buf.position = this.locOffsetTable[param1.name] + ZipConstants.LOCHDR - 2;
         var _loc3_:uint = this.buf.readShort();
         this.buf.position = this.buf.position + (param1.name.length + _loc3_);
         var _loc4_:ByteArray = new ByteArray();
         if(param1.compressedSize > 0)
         {
            this.buf.readBytes(_loc4_,0,param1.compressedSize);
         }
         switch(param1.method)
         {
            case ZipConstants.STORED:
               return _loc4_;
            case ZipConstants.DEFLATED:
               _loc5_ = new ByteArray();
               _loc6_ = new Inflater();
               _loc6_.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
               _loc6_.setInput(_loc4_);
               _loc6_.inflate(_loc5_,param2);
               if(param2 != null)
               {
                  return null;
               }
               return _loc5_;
            default:
               throw new ZipError("invalid compression method");
         }
      }
      
      private function onProgress(param1:Event) : void {
         dispatchEvent(param1);
      }
      
      private function readEntries() : void {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:ZipEntry = null;
         this.readEND();
         this.entryTable = new Dictionary();
         this.locOffsetTable = new Dictionary();
         var _loc1_:uint = 0;
         while(_loc1_ < this.entryList.length)
         {
            _loc2_ = new ByteArray();
            _loc2_.endian = Endian.LITTLE_ENDIAN;
            this.buf.readBytes(_loc2_,0,ZipConstants.CENHDR);
            if(_loc2_.readUnsignedInt() != ZipConstants.CENSIG)
            {
               throw new ZipError("invalid CEN header (bad signature)");
            }
            else
            {
               _loc2_.position = ZipConstants.CENNAM;
               _loc3_ = _loc2_.readUnsignedShort();
               if(_loc3_ == 0)
               {
                  throw new ZipError("missing entry name");
               }
               else
               {
                  _loc4_ = new ZipEntry(this.buf.readUTFBytes(_loc3_));
                  _loc3_ = _loc2_.readUnsignedShort();
                  _loc4_.extra = new ByteArray();
                  if(_loc3_ > 0)
                  {
                     this.buf.readBytes(_loc4_.extra,0,_loc3_);
                  }
                  this.buf.position = this.buf.position + _loc2_.readUnsignedShort();
                  _loc2_.position = ZipConstants.CENVER;
                  _loc4_.version = _loc2_.readUnsignedShort();
                  _loc4_.flag = _loc2_.readUnsignedShort();
                  if((_loc4_.flag & 1) == 1)
                  {
                     throw new ZipError("encrypted ZIP entry not supported");
                  }
                  else
                  {
                     _loc4_.method = _loc2_.readUnsignedShort();
                     _loc4_.dostime = _loc2_.readUnsignedInt();
                     _loc4_.crc = _loc2_.readUnsignedInt();
                     _loc4_.compressedSize = _loc2_.readUnsignedInt();
                     _loc4_.size = _loc2_.readUnsignedInt();
                     this.entryList[_loc1_] = _loc4_;
                     this.entryTable[_loc4_.name] = _loc4_;
                     _loc2_.position = ZipConstants.CENOFF;
                     this.locOffsetTable[_loc4_.name] = _loc2_.readUnsignedInt();
                     _loc1_++;
                     continue;
                  }
               }
            }
         }
      }
      
      private function readEND() : void {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         this.buf.position = this.findEND();
         this.buf.readBytes(_loc1_,0,ZipConstants.ENDHDR);
         _loc1_.position = ZipConstants.ENDTOT;
         this.entryList = new Array(_loc1_.readUnsignedShort());
         _loc1_.position = ZipConstants.ENDOFF;
         this.buf.position = _loc1_.readUnsignedInt();
      }
      
      private function findEND() : uint {
         var _loc1_:uint = this.buf.length - ZipConstants.ENDHDR;
         var _loc2_:uint = Math.max(0,_loc1_ - 65535);
         while(_loc1_ >= _loc2_)
         {
            if(this.buf[_loc1_] == 80)
            {
               this.buf.position = _loc1_;
               if(this.buf.readUnsignedInt() == ZipConstants.ENDSIG)
               {
                  return _loc1_;
               }
            }
            _loc1_--;
         }
         throw new ZipError("invalid zip");
      }
   }
}
