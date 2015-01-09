package com.ankamagames.jerakine.utils.crypto
{
    import com.hurlant.crypto.rsa.RSAKey;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import by.blooddy.crypto.MD5;
    import flash.utils.IDataInput;
    import com.ankamagames.jerakine.utils.errors.SignatureError;
    import flash.filesystem.FileStream;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import by.blooddy.crypto.SHA256;

    public class Signature 
    {

        public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
        public static const SIGNATURE_HEADER:String = "AKSD";

        private var _key:SignatureKey;
        private var _keyV2:RSAKey;

        public function Signature(key:*)
        {
            if (!(key))
            {
                throw (new ArgumentError("Key must be not null"));
            };
            if ((key is SignatureKey))
            {
                this._key = key;
            }
            else
            {
                if ((key is RSAKey))
                {
                    this._keyV2 = key;
                }
                else
                {
                    throw (new ArgumentError("Invalid key type"));
                };
            };
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
            var headerPosition:int;
            header = input.readUTF();
            if (header != ANKAMA_SIGNED_FILE_HEADER)
            {
                input["position"] = 0;
                headerPosition = (input.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length);
                input["position"] = headerPosition;
                header = input.readUTFBytes(4);
                if (header == ANKAMA_SIGNED_FILE_HEADER)
                {
                    return (this.verifyV2Signature(input, output, headerPosition));
                };
            }
            else
            {
                return (this.verifyV1Signature(input, output));
            };
            throw (new SignatureError("Invalid header", SignatureError.INVALID_HEADER));
        }

        private function verifyV1Signature(input:IDataInput, output:ByteArray):Boolean
        {
            goto _label_5;
            
        _label_1: 
            var formatVersion:uint = input.readShort();
            for (;;)
            {
                goto _label_1;
                var _local_5 = _local_5;
                
            _label_2: 
                output = output;
                //unresolved jump
                
            _label_3: 
                var decryptedHash:ByteArray = new ByteArray();
                goto _label_6;
                continue;
                goto _label_2;
                var verifyV1Signature$0 = verifyV1Signature$0;
            };
            var _local_6 = _local_6;
            
        _label_4: 
            goto _label_3;
            
        _label_5: 
            var len:uint;
            //unresolved jump
            try
            {
                
            _label_6: 
                len = input.readInt();
                while (input.readBytes(sigData, 0, len), true)
                {
                    //unresolved jump
                };
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
            for (;;)
            {
                //unresolved jump
                continue;
                
            _label_7: 
                goto _label_8;
            };
            
        _label_8: 
            var i:uint = 2;
            _loop_1:
            for (;i < decryptedHash.length;i++)
            {
                while (true)
                {
                    decryptedHash[i] = (decryptedHash[i] ^ ramdomPart);
                    continue _loop_1;
                };
            };
            goto _label_18;
            
        _label_9: 
            while (trace((("Temps de hash pour validation de signature : " + (getTimer() - tH)) + " ms")), //unresolved jump
, //unresolved jump
, input.readBytes(output), //unresolved jump
, (var _local_0 = this), goto _label_17, (var tH:Number = getTimer()), true)
            {
                goto _label_13;
                
            _label_10: 
                var signHash:String = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
                goto _label_16;
                
            _label_11: 
                goto _label_15;
            };
            
        _label_12: 
            goto _label_10;
            var _local_4 = _local_4;
            
        _label_13: 
            var contentHash:String = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
            goto _label_9;
            
        _label_14: 
            goto _label_19;
            
        _label_15: 
            var testedContentLen:int = input.bytesAvailable;
            goto _label_12;
            
        _label_16: 
            //unresolved jump
            
        _label_17: 
            output.position = 0;
            goto _label_14;
            
        _label_18: 
            var contentLen:int = decryptedHash.readUnsignedInt();
            goto _label_11;
            
        _label_19: 
            var result:Boolean = ((((signHash) && ((signHash == contentHash)))) && ((contentLen == testedContentLen)));
            return (result);
        }

        private function verifyV2Signature(input:IDataInput, output:ByteArray, headerPosition:int):Boolean
        {
            //unresolved jump
            while (//unresolved jump
, goto _label_10, var sigDate:Date, //unresolved jump
, (var _local_7 = _local_7), var sigData:ByteArray, goto _label_5, var cryptedData:ByteArray, //unresolved jump
, (_local_7 = _local_7), //unresolved jump
, (var verifyV2Signature$0 = verifyV2Signature$0), var signedDataLenght:int, //unresolved jump
, (headerPosition = headerPosition), var sigFileLenght:uint, true)
            {
                var hashType:uint;
                goto _label_6;
                
            _label_1: 
                var sigHeader:String;
                goto _label_2;
            };
            
        _label_2: 
            var sigVersion:uint;
            //unresolved jump
            var _local_0 = this;
            
        _label_3: 
            var tsHash:uint;
            goto _label_7;
            
        _label_4: 
            //unresolved jump
            goto _label_4;
            
        _label_5: 
            var tsDecrypt:uint;
            goto _label_9;
            
        _label_6: 
            var sigHash:String;
            goto _label_3;
            var _local_6 = _local_6;
            
        _label_7: 
            var contentHash:String;
            //unresolved jump
            
        _label_8: 
            var fs:FileStream;
            goto _label_1;
            var _local_5 = _local_5;
            
        _label_9: 
            var f:File;
            goto _label_8;
            
        _label_10: 
            if (!(_local_0._keyV2))
            {
                throw (new SignatureError("No key for this signature version"));
            };
            try
            {
                input["position"] = (headerPosition - 4);
                while ((signedDataLenght = input.readShort()), goto _label_15, _local_0._keyV2.verify(cryptedData, sigData, cryptedData.length), //unresolved jump
, //unresolved jump
, //unresolved jump
, (verifyV2Signature$0 = verifyV2Signature$0), (sigData = new ByteArray()), goto _label_18, trace((("Décryptage en " + (getTimer() - tsDecrypt)) + " ms")), goto _label_11, (headerPosition = headerPosition), fs.close(), goto _label_24, //unresolved jump
, (_local_5 = _local_5), true)
                {
                    cryptedData = new ByteArray();
                    goto _label_14;
                    
                _label_11: 
                    goto _label_22;
                };
                
            _label_12: 
                tsDecrypt = getTimer();
                //unresolved jump
                
            _label_13: 
                sigHeader = sigData.readUTF();
                goto _label_25;
                
            _label_14: 
                goto _label_16;
                
            _label_15: 
                goto _label_21;
                
            _label_16: 
                input.readBytes(cryptedData, 0, signedDataLenght);
                //unresolved jump
                
            _label_17: 
                fs.open(f, FileMode.WRITE);
                //unresolved jump
                
            _label_18: 
                goto _label_12;
                
            _label_19: 
                fs = new FileStream();
                goto _label_17;
                
            _label_20: 
                sigData.position = 0;
                goto _label_23;
                
            _label_21: 
                input["position"] = ((headerPosition - 4) - signedDataLenght);
                //unresolved jump
                
            _label_22: 
                f = new File(File.applicationDirectory.resolvePath("log.bin").nativePath);
                while (goto _label_19, (output = output), true)
                {
                    fs.writeBytes(sigData);
                    //unresolved jump
                    
                _label_23: 
                    goto _label_13;
                };
                
            _label_24: 
                goto _label_20;
                
            _label_25: 
                if (sigHeader != SIGNATURE_HEADER)
                {
                    while (trace(((("Header crypté de signature incorrect, " + SIGNATURE_HEADER) + " attendu, lu :") + sigHeader)), true)
                    {
                        goto _label_26;
                    };
                    
                _label_26: 
                    return (false);
                };
                sigVersion = sigData.readByte();
                goto _label_30;
                
            _label_27: 
                while ((sigFileLenght = sigData.readInt()), goto _label_28, sigData.readInt(), true)
                {
                    goto _label_29;
                };
                
            _label_28: 
                goto _label_31;
                
            _label_29: 
                sigData.readInt();
                goto _label_27;
                
            _label_30: 
                //unresolved jump
                
            _label_31: 
                if (sigFileLenght != ((headerPosition - 4) - signedDataLenght))
                {
                    while (trace(((("Longueur de fichier incorrect, " + sigFileLenght) + " attendu, lu :") + ((headerPosition - 4) - signedDataLenght))), true)
                    {
                        goto _label_32;
                    };
                    
                _label_32: 
                    return (false);
                };
                hashType = sigData.readByte();
                //unresolved jump
                
            _label_33: 
                goto _label_36;
                
            _label_34: 
                input["position"] = 0;
                while (goto _label_35, (_local_5 = _local_5), true)
                {
                    sigHash = sigData.readUTF();
                    goto _label_34;
                    
                _label_35: 
                    input.readBytes(output, 0, ((headerPosition - 4) - signedDataLenght));
                    goto _label_33;
                    
                _label_36: 
                    tsHash = getTimer();
                    goto _label_37;
                };
                
            _label_37: 
                switch (hashType)
                {
                    case 0:
                        while ((contentHash = MD5.hashBytes(output)), true)
                        {
                            goto _label_38;
                        };
                        
                    _label_38: 
                        //unresolved jump
                    case 1:
                        contentHash = SHA256.hashBytes(output);
                        //unresolved jump
                    default:
                        return (false);
                };
                while ((output.position = 0), goto _label_43, trace((("Hash en " + (getTimer() - tsHash)) + " ms")), true)
                {
                    sigDate = new Date();
                    goto _label_41;
                    
                _label_39: 
                    sigDate.setTime(sigData.readDouble());
                    goto _label_40;
                };
                
            _label_40: 
                goto _label_42;
                
            _label_41: 
                goto _label_39;
                
            _label_42: 
                trace(sigDate);
                goto _label_44;
                
            _label_43: 
                //unresolved jump
                
            _label_44: 
                if (sigHash != contentHash)
                {
                    while (trace(((("Hash incorrect, " + sigHash) + " attendu, lu :") + contentHash)), true)
                    {
                        goto _label_45;
                    };
                    
                _label_45: 
                    return (false);
                };
            }
            catch(e:Error)
            {
                while (trace(e.getStackTrace()), true)
                {
                    goto _label_46;
                };
                
            _label_46: 
                return (false);
            };
            return (true);
        }

        public function verifySeparatedSignature(swfContent:IDataInput, signatureFile:ByteArray, output:ByteArray):Boolean
        {
            var headerPosition:int;
            var header:String;
            var signedDataLenght:int;
            var cryptedData:ByteArray;
            var sigData:ByteArray;
            var tsDecrypt:uint;
            var f:File;
            var fs:FileStream;
            var sigHeader:String;
            var sigVersion:uint;
            var sigFileLenght:uint;
            var hashType:uint;
            var sigHash:String;
            var tsHash:uint;
            var contentHash:String;
            var sigDate:Date;
            if (!(this._keyV2))
            {
                throw (new SignatureError("No key for this signature version"));
            };
            try
            {
                headerPosition = (signatureFile.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length);
                signatureFile["position"] = headerPosition;
                header = signatureFile.readUTFBytes(4);
                if (header != ANKAMA_SIGNED_FILE_HEADER)
                {
                    return (false);
                };
                signatureFile["position"] = (headerPosition - 4);
                signedDataLenght = signatureFile.readShort();
                signatureFile["position"] = ((headerPosition - 4) - signedDataLenght);
                cryptedData = new ByteArray();
                signatureFile.readBytes(cryptedData, 0, signedDataLenght);
                sigData = new ByteArray();
                tsDecrypt = getTimer();
                this._keyV2.verify(cryptedData, sigData, cryptedData.length);
                trace((("Décryptage en " + (getTimer() - tsDecrypt)) + " ms"));
                f = new File(File.applicationDirectory.resolvePath("log.bin").nativePath);
                fs = new FileStream();
                fs.open(f, FileMode.WRITE);
                fs.writeBytes(sigData);
                fs.close();
                sigData.position = 0;
                sigHeader = sigData.readUTF();
                if (sigHeader != SIGNATURE_HEADER)
                {
                    trace(((("Header crypté de signature incorrect, " + SIGNATURE_HEADER) + " attendu, lu :") + sigHeader));
                    return (false);
                };
                sigVersion = sigData.readByte();
                sigData.readInt();
                sigData.readInt();
                sigFileLenght = sigData.readInt();
                if (sigFileLenght != (swfContent as ByteArray).length)
                {
                    trace(((("Longueur de fichier incorrect, " + sigFileLenght) + " attendu, lu :") + (swfContent as ByteArray).length));
                    return (false);
                };
                hashType = sigData.readByte();
                sigHash = sigData.readUTF();
                swfContent["position"] = 0;
                swfContent.readBytes(output, 0, swfContent.bytesAvailable);
                tsHash = getTimer();
                switch (hashType)
                {
                    case 0:
                        contentHash = MD5.hashBytes(output);
                        break;
                    case 1:
                        contentHash = SHA256.hashBytes(output);
                        break;
                    default:
                        return (false);
                };
                output.position = 0;
                trace((("Hash en " + (getTimer() - tsHash)) + " ms"));
                sigDate = new Date();
                sigDate.setTime(sigData.readDouble());
                trace(sigDate);
                if (sigHash != contentHash)
                {
                    trace(((("Hash incorrect, " + sigHash) + " attendu, lu :") + contentHash));
                    return (false);
                };
            }
            catch(e:Error)
            {
                trace(e.getStackTrace());
                return (false);
            };
            return (true);
        }

        private function traceData(d:ByteArray):void
        {
            while (true)
            {
                goto _label_1;
            };
            var _local_5 = _local_5;
            
        _label_1: 
            var tmp:Array = [];
            var i:uint;
            while (i < d.length)
            {
                while (true)
                {
                    tmp[i] = d[i];
                    goto _label_3;
                };
                
            _label_2: 
                i++;
                continue;
                
            _label_3: 
                goto _label_2;
            };
            while (trace(tmp.join(",")), true)
            {
                return;
            };
            var _local_0 = this;
            return;
        }


    }
}//package com.ankamagames.jerakine.utils.crypto

