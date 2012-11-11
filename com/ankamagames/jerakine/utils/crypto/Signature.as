package com.ankamagames.jerakine.utils.crypto
{
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class Signature extends Object
    {
        private var _key:SignatureKey;
        public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";

        public function Signature(param1:SignatureKey)
        {
            if (!param1)
            {
                throw ArgumentError("Key must be not null");
            }
            this._key = param1;
            return;
        }// end function

        public function sign(param1:IDataInput) : ByteArray
        {
            var _loc_2:* = null;
            if (!this._key.canSign)
            {
                throw new Error("La clef fournit ne permet pas de signer des données");
            }
            if (param1 is ByteArray)
            {
                _loc_2 = param1 as ByteArray;
            }
            else
            {
                _loc_2 = new ByteArray();
                param1.readBytes(_loc_2);
                _loc_2.position = 0;
            }
            var _loc_3:* = _loc_2["position"];
            var _loc_4:* = new ByteArray();
            var _loc_5:* = Math.random() * 255;
            _loc_4.writeByte(_loc_5);
            _loc_4.writeUnsignedInt(_loc_2.bytesAvailable);
            var _loc_6:* = getTimer();
            _loc_4.writeUTFBytes(MD5.hash(_loc_2.readUTFBytes(_loc_2.bytesAvailable)));
            trace("Temps de hash pour signature : " + (getTimer() - _loc_6) + " ms");
            var _loc_7:* = 2;
            while (_loc_7 < _loc_4.length)
            {
                
                _loc_4[_loc_7] = _loc_4[_loc_7] ^ _loc_5;
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = new ByteArray();
            _loc_4.position = 0;
            this._key.sign(_loc_4, _loc_8, _loc_4.length);
            var _loc_9:* = new ByteArray();
            new ByteArray().writeUTF(ANKAMA_SIGNED_FILE_HEADER);
            _loc_9.writeShort(1);
            _loc_9.writeInt(_loc_8.length);
            _loc_8.position = 0;
            _loc_9.writeBytes(_loc_8);
            _loc_2.position = _loc_3;
            _loc_9.writeBytes(_loc_2);
            return _loc_9;
        }// end function

        public function verify(param1:IDataInput, param2:ByteArray) : Boolean
        {
            var header:String;
            var len:uint;
            var input:* = param1;
            var output:* = param2;
            try
            {
                header = input.readUTF();
            }
            catch (e:Error)
            {
                throw new SignatureError("Invalid file format (can\'t read header)", SignatureError.INVALID_HEADER);
            }
            if (header != ANKAMA_SIGNED_FILE_HEADER)
            {
                throw new SignatureError("Invalid header", SignatureError.INVALID_HEADER);
            }
            var formatVersion:* = input.readShort();
            var sigData:* = new ByteArray();
            var decryptedHash:* = new ByteArray();
            try
            {
                len = input.readInt();
                input.readBytes(sigData, 0, len);
            }
            catch (e:Error)
            {
                throw new SignatureError("Invalid signature format, not enough data.", SignatureError.INVALID_SIGNATURE);
                try
                {
                }
                this._key.verify(sigData, decryptedHash, sigData.length);
            }
            catch (e:Error)
            {
                return false;
            }
            decryptedHash.position = 0;
            var ramdomPart:* = decryptedHash.readByte();
            var hash:* = new ByteArray();
            var i:uint;
            while (i < decryptedHash.length)
            {
                
                decryptedHash[i] = decryptedHash[i] ^ ramdomPart;
                i = (i + 1);
            }
            var contentLen:* = decryptedHash.readUnsignedInt();
            var testedContentLen:* = input.bytesAvailable;
            var signHash:* = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
            input.readBytes(output);
            var tH:* = getTimer();
            var contentHash:* = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
            trace("Temps de hash pour validation de signature : " + (getTimer() - tH) + " ms");
            output.position = 0;
            return signHash && signHash == contentHash && contentLen == testedContentLen;
        }// end function

        private function traceData(param1:ByteArray) : void
        {
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_2[_loc_3] = param1[_loc_3];
                _loc_3 = _loc_3 + 1;
            }
            trace(_loc_2.join(","));
            return;
        }// end function

    }
}
