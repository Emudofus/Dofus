package com.ankamagames.jerakine.utils.crypto
{
   import com.hurlant.crypto.rsa.RSAKey;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.getTimer;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.utils.errors.SignatureError;
   import by.blooddy.crypto.SHA256;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   
   public class Signature extends Object
   {
      
      public function Signature(... rest)
      {
         var _loc2_:* = undefined;
         super();
         if(rest.length == 0)
         {
            throw new ArgumentError("You must provide at least one key");
         }
         else
         {
            for each(_loc2_ in rest)
            {
               if(_loc2_ is SignatureKey)
               {
                  this._key = _loc2_;
                  continue;
               }
               if(_loc2_ is RSAKey)
               {
                  this._keyV2 = _loc2_;
                  continue;
               }
               throw new ArgumentError("Invalid key type");
            }
            return;
         }
      }
      
      public static const ANKAMA_SIGNED_FILE_HEADER:String = "AKSF";
      
      public static const SIGNATURE_HEADER:String = "AKSD";
      
      private var _key:SignatureKey;
      
      private var _keyV2:RSAKey;
      
      public function sign(param1:IDataInput, param2:Boolean = true) : ByteArray
      {
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
            var _loc4_:uint = _loc3_["position"];
            var _loc5_:ByteArray = new ByteArray();
            var _loc6_:uint = Math.random() * 255;
            _loc5_.writeByte(_loc6_);
            _loc5_.writeUnsignedInt(_loc3_.bytesAvailable);
            var _loc7_:Number = getTimer();
            _loc5_.writeUTFBytes(MD5.hash(_loc3_.readUTFBytes(_loc3_.bytesAvailable)));
            trace("Temps de hash pour signature : " + (getTimer() - _loc7_) + " ms");
            var _loc8_:uint = 2;
            while(_loc8_ < _loc5_.length)
            {
               _loc5_[_loc8_] = _loc5_[_loc8_] ^ _loc6_;
               _loc8_++;
            }
            var _loc9_:ByteArray = new ByteArray();
            _loc5_.position = 0;
            this._key.sign(_loc5_,_loc9_,_loc5_.length);
            var _loc10_:ByteArray = new ByteArray();
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
      
      public function verify(param1:IDataInput, param2:ByteArray) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:* = 0;
         _loc3_ = param1.readUTF();
         if(_loc3_ != ANKAMA_SIGNED_FILE_HEADER)
         {
            param1["position"] = 0;
            _loc4_ = param1.bytesAvailable - ANKAMA_SIGNED_FILE_HEADER.length;
            param1["position"] = _loc4_;
            _loc3_ = param1.readUTFBytes(4);
            if(_loc3_ == ANKAMA_SIGNED_FILE_HEADER)
            {
               return this.verifyV2Signature(param1,param2,_loc4_);
            }
            throw new SignatureError("Invalid header",SignatureError.INVALID_HEADER);
         }
         return this.verifyV1Signature(param1,param2);
      }
      
      private function verifyV1Signature(param1:IDataInput, param2:ByteArray) : Boolean
      {
         /*
          * Erreur de décompilation
          * Le code est probablement obsfusqué
          * Astuce : Vous pouvez tenter d'activer la "désobfuscation automatique" dans les paramètres
          * Type d'erreur: EmptyStackException
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car il y a des erreurs");
      }
      
      private function verifyV2Signature(param1:IDataInput, param2:ByteArray, param3:int) : Boolean
      {
         /*
          * Erreur de décompilation
          * Le délais dattente de ({0}) est expiré
          */
         throw new flash.errors.IllegalOperationError("Non décompilé car le délais d'attente a été atteint");
      }
      
      public function verifySeparatedSignature(param1:IDataInput, param2:ByteArray, param3:ByteArray) : Boolean
      {
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
         var swfContent:IDataInput = param1;
         var signatureFile:ByteArray = param2;
         var output:ByteArray = param3;
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
      
      private function traceData(param1:ByteArray) : void
      {
         var _loc4_:* = false;
         var _loc5_:* = true;
         if(_loc4_)
         {
         }
         var _loc2_:* = [];
         if(_loc5_)
         {
         }
         var _loc3_:uint = 0;
         if(!_loc4_)
         {
            while(_loc3_ < param1.length)
            {
               _loc2_[_loc3_] = param1[_loc3_];
               if(!_loc4_)
               {
                  if(_loc4_)
                  {
                  }
                  _loc3_ = _loc3_;
               }
            }
            if(_loc4_)
            {
            }
            return;
         }
         trace(_loc2_.join(","));
      }
   }
}
