package com.ankamagames.jerakine.utils.crypto
{
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import by.blooddy.crypto.MD5;
    import flash.utils.IDataInput;
    import com.ankamagames.jerakine.utils.errors.SignatureError;

    public class Signature 
    {

        public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";

        private var _key:SignatureKey;

        public function Signature(key:SignatureKey)
        {
            if (!(key))
            {
                throw (ArgumentError("Key must be not null"));
            };
            this._key = key;
        }

        public function sign(data:IDataInput, includeData:Boolean=true):ByteArray
        {
            var adaptedData:ByteArray;
            if (!(this._key.canSign))
            {
                throw (new Error("La clef fournit ne permet pas de signer des données"));
            };
            if ((data is ByteArray))
            {
                adaptedData = (data as ByteArray);
            }
            else
            {
                adaptedData = new ByteArray();
                data.readBytes(adaptedData);
                adaptedData.position = 0;
            };
            var startPos:uint = adaptedData["position"];
            var hash:ByteArray = new ByteArray();
            var random:uint = (Math.random() * 0xFF);
            hash.writeByte(random);
            hash.writeUnsignedInt(adaptedData.bytesAvailable);
            var tH:Number = getTimer();
            hash.writeUTFBytes(MD5.hash(adaptedData.readUTFBytes(adaptedData.bytesAvailable)));
            trace((("Temps de hash pour signature : " + (getTimer() - tH)) + " ms"));
            var i:uint = 2;
            while (i < hash.length)
            {
                hash[i] = (hash[i] ^ random);
                i++;
            };
            var output:ByteArray = new ByteArray();
            hash.position = 0;
            this._key.sign(hash, output, hash.length);
            var result:ByteArray = new ByteArray();
            result.writeUTF(ANKAMA_SIGNED_FILE_HEADER);
            result.writeShort(1);
            result.writeInt(output.length);
            output.position = 0;
            result.writeBytes(output);
            if (includeData)
            {
                adaptedData.position = startPos;
                result.writeBytes(adaptedData);
            };
            return (result);
        }

        public function verify(input:IDataInput, output:ByteArray):Boolean
        {
            var header:String;
            var len:uint;
            try
            {
                header = input.readUTF();
            }
            catch(e:Error)
            {
                throw (new SignatureError("Invalid file format (can't read header)", SignatureError.INVALID_HEADER));
            };
            if (header != ANKAMA_SIGNED_FILE_HEADER)
            {
                throw (new SignatureError("Invalid header", SignatureError.INVALID_HEADER));
            };
            var formatVersion:uint = input.readShort();
            var sigData:ByteArray = new ByteArray();
            var decryptedHash:ByteArray = new ByteArray();
            try
            {
                len = input.readInt();
                input.readBytes(sigData, 0, len);
            }
            catch(e:Error)
            {
                throw (new SignatureError("Invalid signature format, not enough data.", SignatureError.INVALID_SIGNATURE));
            };
            try
            {
                this._key.verify(sigData, decryptedHash, sigData.length);
            }
            catch(e:Error)
            {
                return (false);
            };
            decryptedHash.position = 0;
            var ramdomPart:int = decryptedHash.readByte();
            var hash:ByteArray = new ByteArray();
            var i:uint = 2;
            while (i < decryptedHash.length)
            {
                decryptedHash[i] = (decryptedHash[i] ^ ramdomPart);
                i++;
            };
            var contentLen:int = decryptedHash.readUnsignedInt();
            var testedContentLen:int = input.bytesAvailable;
            var signHash:String = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
            input.readBytes(output);
            var tH:Number = getTimer();
            var contentHash:String = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
            trace((("Temps de hash pour validation de signature : " + (getTimer() - tH)) + " ms"));
            output.position = 0;
            return (((((signHash) && ((signHash == contentHash)))) && ((contentLen == testedContentLen))));
        }

        private function traceData(d:ByteArray):void
        {
            while (true)
            {
                goto _label_1;
            };
            var _local_0 = this;
            
        _label_1: 
            var tmp:Array = [];
            var i:uint;
            while (i < d.length)
            {
                goto _label_4;
                
            _label_2: 
                i++;
                continue;
                
            _label_3: 
                tmp[i] = d[i];
                goto _label_2;
                
            _label_4: 
                goto _label_3;
            };
            while (trace(tmp.join(",")), true)
            {
                return;
            };
            return;
        }


    }
}//package com.ankamagames.jerakine.utils.crypto

