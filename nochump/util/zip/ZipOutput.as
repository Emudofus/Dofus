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
      
      public function set comment(value:String) : void {
         this._comment = value;
      }
      
      public function putNextEntry(e:ZipEntry) : void {
         if(this._entry != null)
         {
            this.closeEntry();
         }
         if(e.dostime == 0)
         {
            e.time = new Date().time;
         }
         if(e.method == -1)
         {
            e.method = ZipConstants.DEFLATED;
         }
         switch(e.method)
         {
            case ZipConstants.DEFLATED:
               if((e.size == -1) || (e.compressedSize == -1) || (e.crc == 0))
               {
                  e.flag = 8;
               }
               else
               {
                  if((!(e.size == -1)) && (!(e.compressedSize == -1)) && (!(e.crc == 0)))
                  {
                     e.flag = 0;
                  }
                  else
                  {
                     throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
                  }
               }
               e.version = 20;
               break;
            case ZipConstants.STORED:
               if(e.size == -1)
               {
                  e.size = e.compressedSize;
               }
               else
               {
                  if(e.compressedSize == -1)
                  {
                     e.compressedSize = e.size;
                  }
                  else
                  {
                     if(e.size != e.compressedSize)
                     {
                        throw new ZipError("STORED entry where compressed != uncompressed size");
                     }
                  }
               }
               if((e.size == -1) || (e.crc == 0))
               {
                  throw new ZipError("STORED entry missing size, compressed size, or crc-32");
               }
               else
               {
                  e.version = 10;
                  e.flag = 0;
                  break;
               }
         }
         e.offset = this._buf.position;
         if(this._names[e.name] != null)
         {
            throw new ZipError("duplicate entry: " + e.name);
         }
         else
         {
            this._names[e.name] = e;
            this.writeLOC(e);
            this._entries.push(e);
            this._entry = e;
            return;
         }
      }
      
      public function write(b:ByteArray) : void {
         var cb:ByteArray = null;
         if(this._entry == null)
         {
            throw new ZipError("no current ZIP entry");
         }
         else
         {
            switch(this._entry.method)
            {
               case ZipConstants.DEFLATED:
                  cb = new ByteArray();
                  this._def.setInput(b);
                  this._def.deflate(cb);
                  this._buf.writeBytes(cb);
                  break;
               case ZipConstants.STORED:
                  this._buf.writeBytes(b);
                  break;
            }
            this._crc.update(b);
            return;
         }
      }
      
      public function closeEntry() : void {
         var e:ZipEntry = this._entry;
         if(e != null)
         {
            switch(e.method)
            {
               case ZipConstants.DEFLATED:
                  if((e.flag & 8) == 0)
                  {
                     if(e.size != this._def.getBytesRead())
                     {
                        throw new ZipError("invalid entry size (expected " + e.size + " but got " + this._def.getBytesRead() + " bytes)");
                     }
                     else
                     {
                        if(e.compressedSize != this._def.getBytesWritten())
                        {
                           throw new ZipError("invalid entry compressed size (expected " + e.compressedSize + " but got " + this._def.getBytesWritten() + " bytes)");
                        }
                        else
                        {
                           if(e.crc != this._crc.getValue())
                           {
                              throw new ZipError("invalid entry CRC-32 (expected 0x" + e.crc + " but got 0x" + this._crc.getValue() + ")");
                           }
                        }
                     }
                  }
                  else
                  {
                     e.size = this._def.getBytesRead();
                     e.compressedSize = this._def.getBytesWritten();
                     e.crc = this._crc.getValue();
                     this.writeEXT(e);
                  }
                  this._def.reset();
                  break;
               case ZipConstants.STORED:
                  break;
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
            off = this._buf.position;
            i = 0;
            while(i < this._entries.length)
            {
               this.writeCEN(this._entries[i]);
               i++;
            }
            this.writeEND(off,this._buf.position - off);
            return;
         }
      }
      
      private function writeLOC(e:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.LOCSIG);
         this._buf.writeShort(e.version);
         this._buf.writeShort(e.flag);
         this._buf.writeShort(e.method);
         this._buf.writeUnsignedInt(e.dostime);
         if((e.flag & 8) == 8)
         {
            this._buf.writeUnsignedInt(0);
            this._buf.writeUnsignedInt(0);
            this._buf.writeUnsignedInt(0);
         }
         else
         {
            this._buf.writeUnsignedInt(e.crc);
            this._buf.writeUnsignedInt(e.compressedSize);
            this._buf.writeUnsignedInt(e.size);
         }
         this._buf.writeShort(e.name.length);
         this._buf.writeShort(!(e.extra == null)?e.extra.length:0);
         this._buf.writeUTFBytes(e.name);
         if(e.extra != null)
         {
            this._buf.writeBytes(e.extra);
         }
      }
      
      private function writeEXT(e:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.EXTSIG);
         this._buf.writeUnsignedInt(e.crc);
         this._buf.writeUnsignedInt(e.compressedSize);
         this._buf.writeUnsignedInt(e.size);
      }
      
      private function writeCEN(e:ZipEntry) : void {
         this._buf.writeUnsignedInt(ZipConstants.CENSIG);
         this._buf.writeShort(e.version);
         this._buf.writeShort(e.version);
         this._buf.writeShort(e.flag);
         this._buf.writeShort(e.method);
         this._buf.writeUnsignedInt(e.dostime);
         this._buf.writeUnsignedInt(e.crc);
         this._buf.writeUnsignedInt(e.compressedSize);
         this._buf.writeUnsignedInt(e.size);
         this._buf.writeShort(e.name.length);
         this._buf.writeShort(!(e.extra == null)?e.extra.length:0);
         this._buf.writeShort(!(e.comment == null)?e.comment.length:0);
         this._buf.writeShort(0);
         this._buf.writeShort(0);
         this._buf.writeUnsignedInt(0);
         this._buf.writeUnsignedInt(e.offset);
         this._buf.writeUTFBytes(e.name);
         if(e.extra != null)
         {
            this._buf.writeBytes(e.extra);
         }
         if(e.comment != null)
         {
            this._buf.writeUTFBytes(e.comment);
         }
      }
      
      private function writeEND(off:uint, len:uint) : void {
         this._buf.writeUnsignedInt(ZipConstants.ENDSIG);
         this._buf.writeShort(0);
         this._buf.writeShort(0);
         this._buf.writeShort(this._entries.length);
         this._buf.writeShort(this._entries.length);
         this._buf.writeUnsignedInt(len);
         this._buf.writeUnsignedInt(off);
         this._buf.writeUTF(this._comment);
      }
   }
}
