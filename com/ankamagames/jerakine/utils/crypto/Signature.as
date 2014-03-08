package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.utils.errors.SignatureError;
   
   public class Signature extends Object
   {
      
      public function Signature(key:SignatureKey) {
         super();
         if(!key)
         {
            throw ArgumentError("Key must be not null");
         }
         else
         {
            this._key = key;
            return;
         }
      }
      
      public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
      
      private var _key:SignatureKey;
      
      public function sign(data:IDataInput, includeData:Boolean=true) : ByteArray {
         var adaptedData:ByteArray = null;
         if(!this._key.canSign)
         {
            throw new Error("La clef fournit ne permet pas de signer des données");
         }
         else
         {
            if(data is ByteArray)
            {
               adaptedData = data as ByteArray;
            }
            else
            {
               adaptedData = new ByteArray();
               data.readBytes(adaptedData);
               adaptedData.position = 0;
            }
            startPos = adaptedData["position"];
            hash = new ByteArray();
            random = Math.random() * 255;
            hash.writeByte(random);
            hash.writeUnsignedInt(adaptedData.bytesAvailable);
            tH = getTimer();
            hash.writeUTFBytes(MD5.hash(adaptedData.readUTFBytes(adaptedData.bytesAvailable)));
            trace("Temps de hash pour signature : " + (getTimer() - tH) + " ms");
            i = 2;
            while(i < hash.length)
            {
               hash[i] = hash[i] ^ random;
               i++;
            }
            output = new ByteArray();
            hash.position = 0;
            this._key.sign(hash,output,hash.length);
            result = new ByteArray();
            result.writeUTF(ANKAMA_SIGNED_FILE_HEADER);
            result.writeShort(1);
            result.writeInt(output.length);
            output.position = 0;
            result.writeBytes(output);
            if(includeData)
            {
               adaptedData.position = startPos;
               result.writeBytes(adaptedData);
            }
            return result;
         }
      }
      
      public function verify(input:IDataInput, output:ByteArray) : Boolean {
         var header:String = null;
         var len:uint = 0;
         try
         {
            header = input.readUTF();
         }
         catch(e:Error)
         {
            throw new SignatureError("Invalid file format (can\'t read header)",SignatureError.INVALID_HEADER);
         }
         if(header != ANKAMA_SIGNED_FILE_HEADER)
         {
            throw new SignatureError("Invalid header",SignatureError.INVALID_HEADER);
         }
         else
         {
            formatVersion = input.readShort();
            sigData = new ByteArray();
            decryptedHash = new ByteArray();
            try
            {
               len = input.readInt();
               input.readBytes(sigData,0,len);
            }
            catch(e:Error)
            {
               throw new SignatureError("Invalid signature format, not enough data.",SignatureError.INVALID_SIGNATURE);
            }
            try
            {
               this._key.verify(sigData,decryptedHash,sigData.length);
            }
            catch(e:Error)
            {
               return false;
            }
            decryptedHash.position = 0;
            ramdomPart = decryptedHash.readByte();
            hash = new ByteArray();
            i = 2;
            while(i < decryptedHash.length)
            {
               decryptedHash[i] = decryptedHash[i] ^ ramdomPart;
               i++;
            }
            contentLen = decryptedHash.readUnsignedInt();
            testedContentLen = input.bytesAvailable;
            signHash = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
            input.readBytes(output);
            tH = getTimer();
            contentHash = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
            trace("Temps de hash pour validation de signature : " + (getTimer() - tH) + " ms");
            output.position = 0;
            return (signHash) && (signHash == contentHash) && (contentLen == testedContentLen);
         }
      }
      
      private function traceData(d:ByteArray) : void {
         var tmp:Array = [];
         var i:uint = 0;
         while(i < d.length)
         {
            tmp[i] = d[i];
            i++;
         }
         trace(tmp.join(","));
      }
   }
}
