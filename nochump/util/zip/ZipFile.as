package nochump.util.zip
{
    import flash.events.*;
    import flash.utils.*;

    public class ZipFile extends EventDispatcher
    {
        private var buf:ByteArray;
        private var entryList:Array;
        private var entryTable:Dictionary;
        private var locOffsetTable:Dictionary;

        public function ZipFile(param1:IDataInput)
        {
            this.buf = new ByteArray();
            this.buf.endian = Endian.LITTLE_ENDIAN;
            param1.readBytes(this.buf);
            this.readEntries();
            return;
        }// end function

        public function get entries() : Array
        {
            return this.entryList;
        }// end function

        public function get size() : uint
        {
            return this.entryList.length;
        }// end function

        public function getEntry(param1:String) : ZipEntry
        {
            return this.entryTable[param1];
        }// end function

        public function getInput(param1:ZipEntry, param2:Function = null) : ByteArray
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.buf.position = this.locOffsetTable[param1.name] + ZipConstants.LOCHDR - 2;
            var _loc_3:* = this.buf.readShort();
            this.buf.position = this.buf.position + (param1.name.length + _loc_3);
            var _loc_4:* = new ByteArray();
            if (param1.compressedSize > 0)
            {
                this.buf.readBytes(_loc_4, 0, param1.compressedSize);
            }
            switch(param1.method)
            {
                case ZipConstants.STORED:
                {
                    return _loc_4;
                }
                case ZipConstants.DEFLATED:
                {
                    _loc_5 = new ByteArray();
                    _loc_6 = new Inflater();
                    _loc_6.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, true);
                    _loc_6.setInput(_loc_4);
                    _loc_6.inflate(_loc_5, param2);
                    if (param2 != null)
                    {
                        return null;
                    }
                    return _loc_5;
                }
                default:
                {
                    throw new ZipError("invalid compression method");
                    break;
                }
            }
        }// end function

        private function onProgress(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function readEntries() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this.readEND();
            this.entryTable = new Dictionary();
            this.locOffsetTable = new Dictionary();
            var _loc_1:* = 0;
            while (_loc_1 < this.entryList.length)
            {
                
                _loc_2 = new ByteArray();
                _loc_2.endian = Endian.LITTLE_ENDIAN;
                this.buf.readBytes(_loc_2, 0, ZipConstants.CENHDR);
                if (_loc_2.readUnsignedInt() != ZipConstants.CENSIG)
                {
                    throw new ZipError("invalid CEN header (bad signature)");
                }
                _loc_2.position = ZipConstants.CENNAM;
                _loc_3 = _loc_2.readUnsignedShort();
                if (_loc_3 == 0)
                {
                    throw new ZipError("missing entry name");
                }
                _loc_4 = new ZipEntry(this.buf.readUTFBytes(_loc_3));
                _loc_3 = _loc_2.readUnsignedShort();
                _loc_4.extra = new ByteArray();
                if (_loc_3 > 0)
                {
                    this.buf.readBytes(_loc_4.extra, 0, _loc_3);
                }
                this.buf.position = this.buf.position + _loc_2.readUnsignedShort();
                _loc_2.position = ZipConstants.CENVER;
                _loc_4.version = _loc_2.readUnsignedShort();
                _loc_4.flag = _loc_2.readUnsignedShort();
                if ((_loc_4.flag & 1) == 1)
                {
                    throw new ZipError("encrypted ZIP entry not supported");
                }
                _loc_4.method = _loc_2.readUnsignedShort();
                _loc_4.dostime = _loc_2.readUnsignedInt();
                _loc_4.crc = _loc_2.readUnsignedInt();
                _loc_4.compressedSize = _loc_2.readUnsignedInt();
                _loc_4.size = _loc_2.readUnsignedInt();
                this.entryList[_loc_1] = _loc_4;
                this.entryTable[_loc_4.name] = _loc_4;
                _loc_2.position = ZipConstants.CENOFF;
                this.locOffsetTable[_loc_4.name] = _loc_2.readUnsignedInt();
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function readEND() : void
        {
            var _loc_1:* = new ByteArray();
            _loc_1.endian = Endian.LITTLE_ENDIAN;
            this.buf.position = this.findEND();
            this.buf.readBytes(_loc_1, 0, ZipConstants.ENDHDR);
            _loc_1.position = ZipConstants.ENDTOT;
            this.entryList = new Array(_loc_1.readUnsignedShort());
            _loc_1.position = ZipConstants.ENDOFF;
            this.buf.position = _loc_1.readUnsignedInt();
            return;
        }// end function

        private function findEND() : uint
        {
            var _loc_1:* = this.buf.length - ZipConstants.ENDHDR;
            var _loc_2:* = Math.max(0, _loc_1 - 65535);
            while (_loc_1 >= _loc_2)
            {
                
                if (this.buf[_loc_1] != 80)
                {
                }
                else
                {
                    this.buf.position = _loc_1;
                    if (this.buf.readUnsignedInt() == ZipConstants.ENDSIG)
                    {
                        return _loc_1;
                    }
                }
                _loc_1 = _loc_1 - 1;
            }
            throw new ZipError("invalid zip");
        }// end function

    }
}
