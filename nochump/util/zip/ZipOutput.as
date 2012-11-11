package nochump.util.zip
{
    import flash.utils.*;

    public class ZipOutput extends Object
    {
        private var _entry:ZipEntry;
        private var _entries:Array;
        private var _names:Dictionary;
        private var _def:Deflater;
        private var _crc:CRC32;
        private var _buf:ByteArray;
        private var _comment:String = "";

        public function ZipOutput()
        {
            this._entries = [];
            this._names = new Dictionary();
            this._def = new Deflater();
            this._crc = new CRC32();
            this._buf = new ByteArray();
            this._buf.endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public function get size() : uint
        {
            return this._entries.length;
        }// end function

        public function get byteArray() : ByteArray
        {
            this._buf.position = 0;
            return this._buf;
        }// end function

        public function set comment(param1:String) : void
        {
            this._comment = param1;
            return;
        }// end function

        public function putNextEntry(param1:ZipEntry) : void
        {
            if (this._entry != null)
            {
                this.closeEntry();
            }
            if (param1.dostime == 0)
            {
                param1.time = new Date().time;
            }
            if (param1.method == -1)
            {
                param1.method = ZipConstants.DEFLATED;
            }
            switch(param1.method)
            {
                case ZipConstants.DEFLATED:
                {
                    if (param1.size == -1 || param1.compressedSize == -1 || param1.crc == 0)
                    {
                        param1.flag = 8;
                    }
                    else if (param1.size != -1 && param1.compressedSize != -1 && param1.crc != 0)
                    {
                        param1.flag = 0;
                    }
                    else
                    {
                        throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
                    }
                    param1.version = 20;
                    break;
                }
                case ZipConstants.STORED:
                {
                    if (param1.size == -1)
                    {
                        param1.size = param1.compressedSize;
                    }
                    else if (param1.compressedSize == -1)
                    {
                        param1.compressedSize = param1.size;
                    }
                    else if (param1.size != param1.compressedSize)
                    {
                        throw new ZipError("STORED entry where compressed != uncompressed size");
                    }
                    if (param1.size == -1 || param1.crc == 0)
                    {
                        throw new ZipError("STORED entry missing size, compressed size, or crc-32");
                    }
                    param1.version = 10;
                    param1.flag = 0;
                    break;
                }
                default:
                {
                    throw new ZipError("unsupported compression method");
                    break;
                }
            }
            param1.offset = this._buf.position;
            if (this._names[param1.name] != null)
            {
                throw new ZipError("duplicate entry: " + param1.name);
            }
            this._names[param1.name] = param1;
            this.writeLOC(param1);
            this._entries.push(param1);
            this._entry = param1;
            return;
        }// end function

        public function write(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            if (this._entry == null)
            {
                throw new ZipError("no current ZIP entry");
            }
            switch(this._entry.method)
            {
                case ZipConstants.DEFLATED:
                {
                    _loc_2 = new ByteArray();
                    this._def.setInput(param1);
                    this._def.deflate(_loc_2);
                    this._buf.writeBytes(_loc_2);
                    break;
                }
                case ZipConstants.STORED:
                {
                    this._buf.writeBytes(param1);
                    break;
                }
                default:
                {
                    throw new Error("invalid compression method");
                    break;
                }
            }
            this._crc.update(param1);
            return;
        }// end function

        public function closeEntry() : void
        {
            var _loc_1:* = this._entry;
            if (_loc_1 != null)
            {
                switch(_loc_1.method)
                {
                    case ZipConstants.DEFLATED:
                    {
                        if ((_loc_1.flag & 8) == 0)
                        {
                            if (_loc_1.size != this._def.getBytesRead())
                            {
                                throw new ZipError("invalid entry size (expected " + _loc_1.size + " but got " + this._def.getBytesRead() + " bytes)");
                            }
                            if (_loc_1.compressedSize != this._def.getBytesWritten())
                            {
                                throw new ZipError("invalid entry compressed size (expected " + _loc_1.compressedSize + " but got " + this._def.getBytesWritten() + " bytes)");
                            }
                            if (_loc_1.crc != this._crc.getValue())
                            {
                                throw new ZipError("invalid entry CRC-32 (expected 0x" + _loc_1.crc + " but got 0x" + this._crc.getValue() + ")");
                            }
                        }
                        else
                        {
                            _loc_1.size = this._def.getBytesRead();
                            _loc_1.compressedSize = this._def.getBytesWritten();
                            _loc_1.crc = this._crc.getValue();
                            this.writeEXT(_loc_1);
                        }
                        this._def.reset();
                        break;
                    }
                    case ZipConstants.STORED:
                    {
                        break;
                    }
                    default:
                    {
                        throw new Error("invalid compression method");
                        break;
                    }
                }
                this._crc.reset();
                this._entry = null;
            }
            return;
        }// end function

        public function finish() : void
        {
            if (this._entry != null)
            {
                this.closeEntry();
            }
            if (this._entries.length < 1)
            {
                throw new ZipError("ZIP file must have at least one entry");
            }
            var _loc_1:* = this._buf.position;
            var _loc_2:* = 0;
            while (_loc_2 < this._entries.length)
            {
                
                this.writeCEN(this._entries[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            this.writeEND(_loc_1, this._buf.position - _loc_1);
            return;
        }// end function

        private function writeLOC(param1:ZipEntry) : void
        {
            this._buf.writeUnsignedInt(ZipConstants.LOCSIG);
            this._buf.writeShort(param1.version);
            this._buf.writeShort(param1.flag);
            this._buf.writeShort(param1.method);
            this._buf.writeUnsignedInt(param1.dostime);
            if ((param1.flag & 8) == 8)
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
            this._buf.writeShort(param1.extra != null ? (param1.extra.length) : (0));
            this._buf.writeUTFBytes(param1.name);
            if (param1.extra != null)
            {
                this._buf.writeBytes(param1.extra);
            }
            return;
        }// end function

        private function writeEXT(param1:ZipEntry) : void
        {
            this._buf.writeUnsignedInt(ZipConstants.EXTSIG);
            this._buf.writeUnsignedInt(param1.crc);
            this._buf.writeUnsignedInt(param1.compressedSize);
            this._buf.writeUnsignedInt(param1.size);
            return;
        }// end function

        private function writeCEN(param1:ZipEntry) : void
        {
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
            this._buf.writeShort(param1.extra != null ? (param1.extra.length) : (0));
            this._buf.writeShort(param1.comment != null ? (param1.comment.length) : (0));
            this._buf.writeShort(0);
            this._buf.writeShort(0);
            this._buf.writeUnsignedInt(0);
            this._buf.writeUnsignedInt(param1.offset);
            this._buf.writeUTFBytes(param1.name);
            if (param1.extra != null)
            {
                this._buf.writeBytes(param1.extra);
            }
            if (param1.comment != null)
            {
                this._buf.writeUTFBytes(param1.comment);
            }
            return;
        }// end function

        private function writeEND(param1:uint, param2:uint) : void
        {
            this._buf.writeUnsignedInt(ZipConstants.ENDSIG);
            this._buf.writeShort(0);
            this._buf.writeShort(0);
            this._buf.writeShort(this._entries.length);
            this._buf.writeShort(this._entries.length);
            this._buf.writeUnsignedInt(param2);
            this._buf.writeUnsignedInt(param1);
            this._buf.writeUTF(this._comment);
            return;
        }// end function

    }
}
