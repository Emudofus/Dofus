package nochump.util.zip
{
   import flash.utils.Dictionary;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class ZipOutput extends Object
   {
      
      public function ZipOutput() {
         this._entries = [];
         this._names = new Dictionary();
         this._def = new Deflater();
         this._crc = new CRC32();
         this._buf = new ByteArray();
         super();
         this._buf.endian = Endian.LITTLE_ENDIAN;
      }
      
      private var _entry:ZipEntry;
      
      private var _entries:Array;
      
      private var _names:Dictionary;
      
      private var _def:Deflater;
      
      private var _crc:CRC32;
      
      private var _buf:ByteArray;
      
      private var _comment:String = "";
      
      public function get size() : uint {
         return this._entries.length;
      }
      
      public function get byteArray() : ByteArray {
         this._buf.position = 0;
         return this._buf;
      }
      
      public function set comment(param1:String) : void {
         this._comment = param1;
      }
      
      public function putNextEntry(param1:ZipEntry) : void {
         if(this._entry != null)
         {
            this.closeEntry();
         }
         if(param1.dostime == 0)
         {
            param1.time = new Date().time;
         }
         if(param1.method == -1)
         {
            param1.method = ZipConstants.DEFLATED;
         }
         switch(param1.method)
         {
            case ZipConstants.DEFLATED:
               if(param1.size == -1 || param1.compressedSize == -1 || param1.crc == 0)
               {
                  param1.flag = 8;
               }
               else
               {
                  if(!(param1.size == -1) && !(param1.compressedSize == -1) && !(param1.crc == 0))
                  {
                     param1.flag = 0;
                  }
                  else
                  {
                     throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
                  }
               }
               param1.version = 20;
               break;
            case ZipConstants.STORED:
               if(param1.size == -1)
               {
                  param1.size = param1.compressedSize;
               }
               else
               {
                  if(param1.compressedSize == -1)
                  {
                     param1.compressedSize = param1.size;
                  }
                  else
                  {
                     if(param1.size != param1.compressedSize)
                     {
                        throw new ZipError("STORED entry where compressed != uncompressed size");
                     }
                  }
               }
               if(param1.size == -1 || param1.crc == 0)
               {
                  throw new ZipError("STORED entry missing size, compressed size, or crc-32");
               }
               else
               {
                  param1.version = 10;
                  param1.flag = 0;
                  break;
               }
            default:
               throw new ZipError("unsupported compression method");
         }
         param1.offset = this._buf.position;
         if(this._names[param1.name] != null)
         {
            throw new ZipError("duplicate entry: " + param1.name);
         }
         else
         {
            this._names[param1.name] = param1;
            this.writeLOC(param1);
            this._entries.push(param1);
            this._entry = param1;
            return;
         }
      }
      
      public function write(param1:ByteArray) : void {
         var _loc2_:ByteArray = null;
         if(this._entry == null)
         {
            throw new ZipError("no current ZIP entry");
         }
         else
         {
            switch(this._entry.method)
            {
               case ZipConstants.DEFLATED:
                  _loc2_ = new ByteArray();
                  this._def.setInput(param1);
                  this._def.deflate(_loc2_);
                  this._buf.writeBytes(_loc2_);
                  break;
               case ZipConstants.STORED:
                  this._buf.writeBytes(param1);
                  break;
               default:
                  throw new Error("invalid compression method");
            }
            this._crc.update(param1);
            return;
         }
      }
      
      public function closeEntry() : void {
         var _loc1_:ZipEntry = this._entry;
         if(_loc1_ != null)
         {
            switch(_loc1_.method)
            {
               case ZipConstants.DEFLATED:
                  if((_loc1_.flag & 8) == 0)
                  {
                     if(_loc1_.size != this._def.getBytesRead())
                     {
                        throw new ZipError("invalid entry size (expected " + _loc1_.size + " but got " + this._def.getBytesRead() + " bytes)");
                     }
                     else
                     {
                        if(_loc1_.compressedSize != this._def.getBytesWritten())
                        {
                           throw new ZipError("invalid entry compressed size (expected " + _loc1_.compressedSize + " but got " + this._def.getBytesWritten() + " bytes)");
                        }
                        else
                        {
                           if(_loc1_.crc != this._crc.getValue())
                           {
                              throw new ZipError("invalid entry CRC-32 (expected 0x" + _loc1_.crc + " but got 0x" + this._crc.getValue() + ")");
                           }
                        }
                     }
                  }
                  else
                  {
                     _loc1_.size = this._def.getBytesRead();
                     _loc1_.compressedSize = this._def.getBytesWritten();
                     _loc1_.crc = this._crc.getValue();
                     this.writeEXT(_loc1_);
                  }
                  this._def.reset();
                  break;
               case ZipConstants.STORED:
                  break;
               default:
                  throw new Error("invalid compression method");
            }
            this._crc.reset();
            this._entry = null;
         }
      }
      
      public function finish() : void {
         if(this._entry != null)
         {
            this.closeEntry();
         }
         if(this._entries.length < 1)
         {
            throw new ZipError("ZIP file must have at least one entry");
         }
         else
         {
            _loc1_ = this._buf.position;
            _loc2_ = 0;
            while(_loc2_ < this._entries.length)
            {
               this.writeCEN(this._entries[_loc2_]);
               _loc2_++;
            }
            this.writeEND(_loc1_,this._buf.position - _loc1_);
            return;
         }
      }
      
      private function writeLOC(param1:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.LOCSIG);
         this._buf.writeShort(param1.version);
         this._buf.writeShort(param1.flag);
         this._buf.writeShort(param1.method);
         this._buf.writeUnsignedInt(param1.dostime);
         if((param1.flag & 8) == 8)
         {
            this._buf.writeUnsignedInt(0);
            this._buf.writeUnsignedInt(0);
            this._buf.writeUnsignedInt(0);
         }
         else
         {
            this._buf.writeUnsignedInt(param1.crc);
            this._buf.writeUnsignedInt(param1.compressedSize);
            this._buf.writeUnsignedInt(param1.size);
         }
         this._buf.writeShort(param1.name.length);
         this._buf.writeShort(param1.extra != null?param1.extra.length:0);
         this._buf.writeUTFBytes(param1.name);
         if(param1.extra != null)
         {
            this._buf.writeBytes(param1.extra);
         }
      }
      
      private function writeEXT(param1:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.EXTSIG);
         this._buf.writeUnsignedInt(param1.crc);
         this._buf.writeUnsignedInt(param1.compressedSize);
         this._buf.writeUnsignedInt(param1.size);
      }
      
      private function writeCEN(param1:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.CENSIG);
         this._buf.writeShort(param1.version);
         this._buf.writeShort(param1.version);
         this._buf.writeShort(param1.flag);
         this._buf.writeShort(param1.method);
         this._buf.writeUnsignedInt(param1.dostime);
         this._buf.writeUnsignedInt(param1.crc);
         this._buf.writeUnsignedInt(param1.compressedSize);
         this._buf.writeUnsignedInt(param1.size);
         this._buf.writeShort(param1.name.length);
         this._buf.writeShort(param1.extra != null?param1.extra.length:0);
         this._buf.writeShort(param1.comment != null?param1.comment.length:0);
         this._buf.writeShort(0);
         this._buf.writeShort(0);
         this._buf.writeUnsignedInt(0);
         this._buf.writeUnsignedInt(param1.offset);
         this._buf.writeUTFBytes(param1.name);
         if(param1.extra != null)
         {
            this._buf.writeBytes(param1.extra);
         }
         if(param1.comment != null)
         {
            this._buf.writeUTFBytes(param1.comment);
         }
      }
      
      private function writeEND(param1:uint, param2:uint) : void {
         this._buf.writeUnsignedInt(ZipConstants.ENDSIG);
         this._buf.writeShort(0);
         this._buf.writeShort(0);
         this._buf.writeShort(this._entries.length);
         this._buf.writeShort(this._entries.length);
         this._buf.writeUnsignedInt(param2);
         this._buf.writeUnsignedInt(param1);
         this._buf.writeUTF(this._comment);
      }
   }
}
