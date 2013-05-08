package com.ankamagames.dofus.logic.shield
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import flash.utils.ByteArray;
   import com.ankamagames.dofus.network.types.secure.TrustCertificate;
   import by.blooddy.crypto.SHA256;
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.ECBMode;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import flash.system.Capabilities;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.filesystem.File;
   import flash.system.ApplicationDomain;
   import by.blooddy.crypto.MD5;


   public class ShieldCertifcate extends Object
   {
         

      public function ShieldCertifcate(version:uint=3) {
         super();
         switch(version)
         {
            case 1:
               this.useAdvancedNetworkInfo=false;
               this.useBasicNetworkInfo=false;
               this.useBasicInfo=false;
               this.useUserInfo=false;
               this.filterVirtualNetwork=false;
               break;
            case 2:
               this.useAdvancedNetworkInfo=true;
               this.useBasicNetworkInfo=true;
               this.useBasicInfo=true;
               this.useUserInfo=true;
               this.filterVirtualNetwork=false;
               break;
            case 3:
               this.useAdvancedNetworkInfo=false;
               this.useBasicNetworkInfo=true;
               this.useBasicInfo=true;
               this.useUserInfo=true;
               this.filterVirtualNetwork=true;
               break;
         }
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShieldCertifcate));

      public static const HEADER_BEGIN:String = "SV";

      public static const HEADER_V1:String = HEADER_BEGIN+"1";

      public static const HEADER_V2:String = HEADER_BEGIN+"2";

      public static const HEADER_V3:String = HEADER_BEGIN+"3";

      public static function fromRaw(data:IDataInput, output:ShieldCertifcate=null) : ShieldCertifcate {
         var infoLen:uint = 0;
         var i:uint = 0;
         var result:ShieldCertifcate = output?output:new ShieldCertifcate();
         data["position"]=0;
         var header:String = data.readUTFBytes(3);
         if(header.substr(0,2)!=HEADER_BEGIN)
         {
            header=HEADER_V1;
         }
         switch(header)
         {
            case HEADER_V1:
               result.version=1;
               data["position"]=0;
               result.id=data.readUnsignedInt();
               result.content=data.readUTF();
               result.useAdvancedNetworkInfo=false;
               result.useBasicNetworkInfo=false;
               result.useBasicInfo=false;
               result.useUserInfo=false;
               result.filterVirtualNetwork=false;
               break;
            case HEADER_V2:
               result.version=2;
               result.id=data.readUnsignedInt();
               result.useAdvancedNetworkInfo=true;
               result.useBasicNetworkInfo=true;
               result.useBasicInfo=true;
               result.useUserInfo=true;
               result.filterVirtualNetwork=false;
               result.content=result.decrypt(data);
               break;
            case HEADER_V3:
               result.version=3;
               result.id=data.readUnsignedInt();
               infoLen=data.readShort();
               i=0;
               while(i<infoLen)
               {
                  result[data.readUTF()]=data.readBoolean();
                  i++;
               }
               result.content=result.decrypt(data);
               break;
         }
         return result;
      }

      public var version:uint;

      public var id:uint;

      public var content:String;

      public var useBasicNetworkInfo:Boolean;

      public var useAdvancedNetworkInfo:Boolean;

      public var useBasicInfo:Boolean;

      public var useUserInfo:Boolean;

      public var filterVirtualNetwork:Boolean;

      public function set secureLevel(level:uint) : void {
         switch(level)
         {
            case ShieldSecureLevel.LOW:
               this.useAdvancedNetworkInfo=false;
               this.useBasicNetworkInfo=false;
               this.useBasicInfo=false;
               this.useUserInfo=false;
               this.filterVirtualNetwork=false;
               break;
            case ShieldSecureLevel.MEDIUM:
               this.useAdvancedNetworkInfo=false;
               this.useBasicNetworkInfo=false;
               this.useBasicInfo=true;
               this.useUserInfo=true;
               this.filterVirtualNetwork=false;
               break;
            case ShieldSecureLevel.MAX:
               this.useAdvancedNetworkInfo=true;
               this.useBasicNetworkInfo=true;
               this.useBasicInfo=true;
               this.useUserInfo=true;
               this.filterVirtualNetwork=true;
               break;
         }
      }

      public function get hash() : String {
         return this.getHash();
      }

      public function get reverseHash() : String {
         return this.getHash(true);
      }

      public function serialize() : ByteArray {
         var info:Array = null;
         var i:uint = 0;
         var result:ByteArray = new ByteArray();
         switch(this.version)
         {
            case 1:
               throw new Error("No more supported");
               break;
            case 2:
               result.writeUTFBytes(HEADER_V2);
               result.writeUnsignedInt(this.id);
               result.writeUTFBytes(this.content);
               break;
            case 3:
               result.writeUTFBytes(HEADER_V3);
               result.writeUnsignedInt(this.id);
               info=["useBasicInfo","useBasicNetworkInfo","useAdvancedNetworkInfo","useUserInfo"];
               result.writeShort(info.length);
               i=0;
               while(i<info.length)
               {
                  result.writeUTF(info[i]);
                  result.writeBoolean(this[info[i]]);
                  i++;
               }
               result.writeUTFBytes(this.content);
               break;
         }
         return result;
      }

      public function toNetwork() : TrustCertificate {
         var certif:TrustCertificate = new TrustCertificate();
         var hash:String = SHA256.hash(this.getHash()+this.content);
         certif.initTrustCertificate(this.id,hash);
         return certif;
      }

      private function decrypt(data:IDataInput) : String {
         if(!_loc5_)
         {
         }
         while(_loc5_)
         {
            if(!_loc5_)
            {
               continue;
            }
            while(_loc5_)
            {
               key=new ByteArray();
               if(!_loc5_)
               {
               }
               else
               {
                  if(_loc4_)
                  {
                     continue;
                  }
                  do
                  {
                     key.writeUTFBytes(this.getHash(true));
                     if(!_loc5_)
                     {
                     }
                     else
                     {
                        if(!_loc5_)
                        {
                           continue;
                        }
                     }
                  }
                  while(true);
               }
            }
         }
      }

      private function getHash(reverse:Boolean=false) : String {
         if(_loc6_)
         {
         }
         while(true)
         {
            if(_loc6_)
            {
               continue loop1;
            }
            while(true)
            {
               if(_loc5_)
               {
               }
               data=[];
               if(!_loc6_)
               {
                  if(_loc6_)
                  {
                     continue loop5;
                  }
                  if(_loc5_)
                  {
                     if(this.useBasicInfo)
                     {
                        if(_loc6_)
                        {
                           continue loop9;
                        }
                     }
                     else
                     {
                        continue loop20;
                     }
                  }
               }
               if(_loc6_)
               {
               }
               else
               {
                  if(_loc6_)
                  {
                     continue loop20;
                  }
                  if(_loc5_)
                  {
                     data.push(Capabilities.maxLevelIDC);
                     if(!_loc5_)
                     {
                        continue loop4;
                     }
                  }
               }
               continue loop7;
               continue loop8;
            }
         }
         {
            continue loop5;
         }
      }

      private function traceInfo(target:*, maxDepth:uint=5, inc:String="") : void {
         var _loc4_:* = true;
         var _loc5_:* = false;
         _log.info("-----------");
         _log.info("active : "+target.active);
         _log.info("hardwareAddress : "+target.hardwareAddress);
         _log.info("name : "+target.hardwareAddress);
         _log.info("displayName : "+target.displayName);
         _log.info("parent : "+target.parent);
         if((target.parent)&&(maxDepth))
         {
            this.traceInfo(target.parent,maxDepth--,inc+"...");
         }
      }
   }

}