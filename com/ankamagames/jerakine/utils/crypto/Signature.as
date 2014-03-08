package com.ankamagames.jerakine.utils.crypto
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.utils.errors.SignatureError;
   
   public class Signature extends Object
   {
      
      public function Signature(param1:SignatureKey) {
         super();
         if(!param1)
         {
            throw ArgumentError("Key must be not null");
         }
         else
         {
            this._key = param1;
            return;
         }
      }
      
      public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
      
      private var _key:SignatureKey;
      
      public function sign(param1:IDataInput, param2:Boolean=true) : ByteArray {
         var _loc3_:ByteArray = null;
         if(!this._key.canSign)
         {
            throw new Error("La clef fournit ne permet pas de signer des données");
         }
         else
         {
            if(param1 is ByteArray)
            {
               _loc3_ = param1 as ByteArray;
            }
            else
            {
               _loc3_ = new ByteArray();
               param1.readBytes(_loc3_);
               _loc3_.position = 0;
            }
            _loc4_ = _loc3_["position"];
            _loc5_ = new ByteArray();
            _loc6_ = Math.random() * 255;
            _loc5_.writeByte(_loc6_);
            _loc5_.writeUnsignedInt(_loc3_.bytesAvailable);
            _loc7_ = getTimer();
            _loc5_.writeUTFBytes(MD5.hash(_loc3_.readUTFBytes(_loc3_.bytesAvailable)));
            trace("Temps de hash pour signature : " + (getTimer() - _loc7_) + " ms");
            _loc8_ = 2;
            while(_loc8_ < _loc5_.length)
            {
               _loc5_[_loc8_] = _loc5_[_loc8_] ^ _loc6_;
               _loc8_++;
            }
            _loc9_ = new ByteArray();
            _loc5_.position = 0;
            this._key.sign(_loc5_,_loc9_,_loc5_.length);
            _loc10_ = new ByteArray();
            _loc10_.writeUTF(ANKAMA_SIGNED_FILE_HEADER);
            _loc10_.writeShort(1);
            _loc10_.writeInt(_loc9_.length);
            _loc9_.position = 0;
            _loc10_.writeBytes(_loc9_);
            if(param2)
            {
               _loc3_.position = _loc4_;
               _loc10_.writeBytes(_loc3_);
            }
            return _loc10_;
         }
      }
      
      public function verify(param1:IDataInput, param2:ByteArray) : Boolean {
         var header:String = null;
         var len:uint = 0;
         var input:IDataInput = param1;
         var output:ByteArray = param2;
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
            return (signHash) && signHash == contentHash && contentLen == testedContentLen;
         }
      }
      
      private function traceData(param1:ByteArray) : void {
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
         trace(_loc2_.join(","));
      }
   }
}
