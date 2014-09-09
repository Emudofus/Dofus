package com.ankamagames.jerakine.utils.crypto
{
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.utils.errors.SignatureError;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   import by.blooddy.crypto.SHA256;
   
   public class Signature extends Object
   {
      
      public function Signature(key:*) {
         super();
         if(!key)
         {
            throw new ArgumentError("Key must be not null");
         }
         else
         {
            if(key is SignatureKey)
            {
               this._key = key;
            }
            else if(key is RSAKey)
            {
               this._keyV2 = key;
            }
            else
            {
               throw new ArgumentError("Invalid key type");
            }
            
            return;
         }
      }
      
      public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
      
      public static const SIGNATURE_HEADER:String = "AKSD";
      
      private var _key:SignatureKey;
      
      private var _keyV2:RSAKey;
      
      public function sign(data:IDataInput, includeData:Boolean = true) : ByteArray {
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
         var headerPosition:* = 0;
         header = input.readUTF();
         if(header != ANKAMA_SIGNED_FILE_HEADER)
         {
            input["position"] = 0;
            headerPosition = input.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length;
            input["position"] = headerPosition;
            header = input.readUTFBytes(4);
            if(header == ANKAMA_SIGNED_FILE_HEADER)
            {
               return this.verifyV2Signature(input,output,headerPosition);
            }
            throw new SignatureError("Invalid header",SignatureError.INVALID_HEADER);
         }
         return this.verifyV1Signature(input,output);
      }
      
      private function verifyV1Signature(input:IDataInput, output:ByteArray) : Boolean {
         var _loc5_:* = true;
         var _loc6_:* = false;
         var len:uint = 0;
         var formatVersion:uint = input.readShort();
         var sigData:ByteArray = new ByteArray();
         var decryptedHash:ByteArray = new ByteArray();
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
         var ramdomPart:int = decryptedHash.readByte();
         var hash:ByteArray = new ByteArray();
         var i:uint = 2;
         while(i < decryptedHash.length)
         {
            decryptedHash[i] = decryptedHash[i] ^ ramdomPart;
            i++;
         }
         var contentLen:int = decryptedHash.readUnsignedInt();
         var testedContentLen:int = input.bytesAvailable;
         var signHash:String = decryptedHash.readUTFBytes(decryptedHash.bytesAvailable).substr(1);
         input.readBytes(output);
         var tH:Number = getTimer();
         var contentHash:String = MD5.hash(output.readUTFBytes(output.bytesAvailable)).substr(1);
         trace("Temps de hash pour validation de signature : " + (getTimer() - tH) + " ms");
         output.position = 0;
         var result:Boolean = (signHash) && (signHash == contentHash) && (contentLen == testedContentLen);
         return result;
      }
      
      private function verifyV2Signature(input:IDataInput, output:ByteArray, headerPosition:int) : Boolean {
         var _loc6_:* = true;
         var _loc7_:* = false;
         var signedDataLenght:int = 0;
         var cryptedData:ByteArray = null;
         var sigData:ByteArray = null;
         var tsDecrypt:uint = 0;
         var f:File = null;
         var fs:FileStream = null;
         var sigHeader:String = null;
         var sigVersion:uint = 0;
         var sigFileLenght:uint = 0;
         var hashType:uint = 0;
         var sigHash:String = null;
         var tsHash:uint = 0;
         var contentHash:String = null;
         var sigDate:Date = null;
         if(!this._keyV2)
         {
            throw new SignatureError("No key for this signature version");
         }
         else
         {
            try
            {
               input["position"] = headerPosition - 4;
               signedDataLenght = input.readShort();
               input["position"] = headerPosition - 4 - signedDataLenght;
               cryptedData = new ByteArray();
               input.readBytes(cryptedData,0,signedDataLenght);
               sigData = new ByteArray();
               tsDecrypt = getTimer();
               this._keyV2.verify(cryptedData,sigData,cryptedData.length);
               trace("Décryptage en " + (getTimer() - tsDecrypt) + " ms");
               f = new File(File.applicationDirectory.resolvePath("log.bin").nativePath);
               fs = new FileStream();
               fs.open(f,FileMode.WRITE);
               fs.writeBytes(sigData);
               fs.close();
               sigData.position = 0;
               sigHeader = sigData.readUTF();
               if(sigHeader != SIGNATURE_HEADER)
               {
                  trace("Header crypté de signature incorrect, " + SIGNATURE_HEADER + " attendu, lu :" + sigHeader);
                  return false;
               }
               sigVersion = sigData.readByte();
               sigData.readInt();
               sigData.readInt();
               sigFileLenght = sigData.readInt();
               if(sigFileLenght != headerPosition - 4 - signedDataLenght)
               {
                  trace("Longueur de fichier incorrect, " + sigFileLenght + " attendu, lu :" + (headerPosition - 4 - signedDataLenght));
                  return false;
               }
               hashType = sigData.readByte();
               sigHash = sigData.readUTF();
               input["position"] = 0;
               input.readBytes(output,0,headerPosition - 4 - signedDataLenght);
               tsHash = getTimer();
            }
            catch(e:Error)
            {
               if(!_loc7_)
               {
                  if(!_loc6_)
                  {
                     while(!_loc6_)
                     {
                        break;
                     }
                     return false;
                  }
                  while(true)
                  {
                     trace(e.getStackTrace());
                  }
               }
               while(true)
               {
                  if(_loc6_)
                  {
                     if(!_loc6_)
                     {
                        trace(e.getStackTrace());
                        continue;
                     }
                  }
                  return false;
               }
            }
            return true;
         }
      }
      
      public function verifySeparatedSignature(swfContent:IDataInput, signatureFile:ByteArray, output:ByteArray) : Boolean {
         var headerPosition:int = 0;
         var header:String = null;
         var signedDataLenght:int = 0;
         var cryptedData:ByteArray = null;
         var sigData:ByteArray = null;
         var tsDecrypt:uint = 0;
         var f:File = null;
         var fs:FileStream = null;
         var sigHeader:String = null;
         var sigVersion:uint = 0;
         var sigFileLenght:uint = 0;
         var hashType:uint = 0;
         var sigHash:String = null;
         var tsHash:uint = 0;
         var contentHash:String = null;
         var sigDate:Date = null;
         if(!this._keyV2)
         {
            throw new SignatureError("No key for this signature version");
         }
         else
         {
            try
            {
               headerPosition = signatureFile.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length;
               signatureFile["position"] = headerPosition;
               header = signatureFile.readUTFBytes(4);
               if(header != ANKAMA_SIGNED_FILE_HEADER)
               {
                  return false;
               }
               signatureFile["position"] = headerPosition - 4;
               signedDataLenght = signatureFile.readShort();
               signatureFile["position"] = headerPosition - 4 - signedDataLenght;
               cryptedData = new ByteArray();
               signatureFile.readBytes(cryptedData,0,signedDataLenght);
               sigData = new ByteArray();
               tsDecrypt = getTimer();
               this._keyV2.verify(cryptedData,sigData,cryptedData.length);
               trace("Décryptage en " + (getTimer() - tsDecrypt) + " ms");
               f = new File(File.applicationDirectory.resolvePath("log.bin").nativePath);
               fs = new FileStream();
               fs.open(f,FileMode.WRITE);
               fs.writeBytes(sigData);
               fs.close();
               sigData.position = 0;
               sigHeader = sigData.readUTF();
               if(sigHeader != SIGNATURE_HEADER)
               {
                  trace("Header crypté de signature incorrect, " + SIGNATURE_HEADER + " attendu, lu :" + sigHeader);
                  return false;
               }
               sigVersion = sigData.readByte();
               sigData.readInt();
               sigData.readInt();
               sigFileLenght = sigData.readInt();
               if(sigFileLenght != (swfContent as ByteArray).length)
               {
                  trace("Longueur de fichier incorrect, " + sigFileLenght + " attendu, lu :" + (swfContent as ByteArray).length);
                  return false;
               }
               hashType = sigData.readByte();
               sigHash = sigData.readUTF();
               swfContent["position"] = 0;
               swfContent.readBytes(output,0,swfContent.bytesAvailable);
               tsHash = getTimer();
               switch(hashType)
               {
                  case 0:
                     contentHash = MD5.hashBytes(output);
                     break;
                  case 1:
                     contentHash = SHA256.hashBytes(output);
                     break;
                  default:
                     return false;
               }
               output.position = 0;
               trace("Hash en " + (getTimer() - tsHash) + " ms");
               sigDate = new Date();
               sigDate.setTime(sigData.readDouble());
               trace(sigDate);
               if(sigHash != contentHash)
               {
                  trace("Hash incorrect, " + sigHash + " attendu, lu :" + contentHash);
                  return false;
               }
            }
            catch(e:Error)
            {
               trace(e.getStackTrace());
               return false;
            }
            return true;
         }
      }
      
      private function traceData(d:ByteArray) : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
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
