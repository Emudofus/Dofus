package com.hurlant.util.der
{
    import flash.utils.ByteArray;

    public class DER 
    {

        public static var indent:String = "";


        public static function parse(der:ByteArray, structure:*=null):IAsn1Type
        {
            var type:int;
            var len:int;
            var b:ByteArray;
            var count:int;
            var _local_8:int;
            var _local_9:Sequence;
            var _local_10:Array;
            var _local_11:Set;
            var _local_12:ByteString;
            var _local_13:PrintableString;
            var _local_14:UTCTime;
            var tmpStruct:Object;
            var wantConstructed:Boolean;
            var isConstructed:Boolean;
            var name:String;
            var value:*;
            var obj:IAsn1Type;
            var size:int;
            var ba:ByteArray;
            type = der.readUnsignedByte();
            var constructed:Boolean = !(((type & 32) == 0));
            type = (type & 31);
            len = der.readUnsignedByte();
            if (len >= 128)
            {
                count = (len & 127);
                len = 0;
                while (count > 0)
                {
                    len = ((len << 8) | der.readUnsignedByte());
                    count--;
                };
            };
            switch (type)
            {
                case 0:
                case 16:
                    _local_8 = der.position;
                    _local_9 = new Sequence(type, len);
                    _local_10 = (structure as Array);
                    if (_local_10 != null)
                    {
                        _local_10 = _local_10.concat();
                    };
                    while (der.position < (_local_8 + len))
                    {
                        tmpStruct = null;
                        if (_local_10 != null)
                        {
                            tmpStruct = _local_10.shift();
                        };
                        if (tmpStruct != null)
                        {
                            while (((tmpStruct) && (tmpStruct.optional)))
                            {
                                wantConstructed = (tmpStruct.value is Array);
                                isConstructed = isConstructedType(der);
                                if (wantConstructed != isConstructed)
                                {
                                    _local_9.push(tmpStruct.defaultValue);
                                    _local_9[tmpStruct.name] = tmpStruct.defaultValue;
                                    tmpStruct = _local_10.shift();
                                }
                                else
                                {
                                    break;
                                };
                            };
                        };
                        if (tmpStruct != null)
                        {
                            name = tmpStruct.name;
                            value = tmpStruct.value;
                            if (tmpStruct.extract)
                            {
                                size = getLengthOfNextElement(der);
                                ba = new ByteArray();
                                ba.writeBytes(der, der.position, size);
                                _local_9[(name + "_bin")] = ba;
                            };
                            obj = DER.parse(der, value);
                            _local_9.push(obj);
                            _local_9[name] = obj;
                        }
                        else
                        {
                            _local_9.push(DER.parse(der));
                        };
                    };
                    return (_local_9);
                case 17:
                    _local_8 = der.position;
                    _local_11 = new Set(type, len);
                    while (der.position < (_local_8 + len))
                    {
                        _local_11.push(DER.parse(der));
                    };
                    return (_local_11);
                case 2:
                    b = new ByteArray();
                    der.readBytes(b, 0, len);
                    b.position = 0;
                    return (new Integer(type, len, b));
                case 6:
                    b = new ByteArray();
                    der.readBytes(b, 0, len);
                    b.position = 0;
                    return (new ObjectIdentifier(type, len, b));
                default:
                    trace(("I DONT KNOW HOW TO HANDLE DER stuff of TYPE " + type));
                case 3:
                    if (der[der.position] == 0)
                    {
                        der.position++;
                        len--;
                    };
                case 4:
                    _local_12 = new ByteString(type, len);
                    der.readBytes(_local_12, 0, len);
                    return (_local_12);
                case 5:
                    return (null);
                case 19:
                    _local_13 = new PrintableString(type, len);
                    _local_13.setString(der.readMultiByte(len, "US-ASCII"));
                    return (_local_13);
                case 34:
                case 20:
                    _local_13 = new PrintableString(type, len);
                    _local_13.setString(der.readMultiByte(len, "latin1"));
                    return (_local_13);
                case 23:
                    _local_14 = new UTCTime(type, len);
                    _local_14.setUTCTime(der.readMultiByte(len, "US-ASCII"));
                    return (_local_14);
            };
        }

        private static function getLengthOfNextElement(b:ByteArray):int
        {
            var count:int;
            var p:uint = b.position;
            b.position++;
            var len:int = b.readUnsignedByte();
            if (len >= 128)
            {
                count = (len & 127);
                len = 0;
                while (count > 0)
                {
                    len = ((len << 8) | b.readUnsignedByte());
                    count--;
                };
            };
            len = (len + (b.position - p));
            b.position = p;
            return (len);
        }

        private static function isConstructedType(b:ByteArray):Boolean
        {
            var type:int = b[b.position];
            return (!(((type & 32) == 0)));
        }

        public static function wrapDER(type:int, data:ByteArray):ByteArray
        {
            var d:ByteArray = new ByteArray();
            d.writeByte(type);
            var len:int = data.length;
            if (len < 128)
            {
                d.writeByte(len);
            }
            else
            {
                if (len < 0x0100)
                {
                    d.writeByte((1 | 128));
                    d.writeByte(len);
                }
                else
                {
                    if (len < 65536)
                    {
                        d.writeByte((2 | 128));
                        d.writeByte((len >> 8));
                        d.writeByte(len);
                    }
                    else
                    {
                        if (len < (65536 * 0x0100))
                        {
                            d.writeByte((3 | 128));
                            d.writeByte((len >> 16));
                            d.writeByte((len >> 8));
                            d.writeByte(len);
                        }
                        else
                        {
                            d.writeByte((4 | 128));
                            d.writeByte((len >> 24));
                            d.writeByte((len >> 16));
                            d.writeByte((len >> 8));
                            d.writeByte(len);
                        };
                    };
                };
            };
            d.writeBytes(data);
            d.position = 0;
            return (d);
        }


    }
}//package com.hurlant.util.der

