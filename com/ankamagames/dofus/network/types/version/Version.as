package com.ankamagames.dofus.network.types.version
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Version extends Object implements INetworkType
   {
      
      public function Version() {
         super();
      }
      
      public static const protocolId:uint = 11;
      
      public var major:uint = 0;
      
      public var minor:uint = 0;
      
      public var release:uint = 0;
      
      public var revision:uint = 0;
      
      public var patch:uint = 0;
      
      public var buildType:uint = 0;
      
      public function getTypeId() : uint {
         return 11;
      }
      
      public function initVersion(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0) : Version {
         this.major = param1;
         this.minor = param2;
         this.release = param3;
         this.revision = param4;
         this.patch = param5;
         this.buildType = param6;
         return this;
      }
      
      public function reset() : void {
         this.major = 0;
         this.minor = 0;
         this.release = 0;
         this.revision = 0;
         this.patch = 0;
         this.buildType = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_Version(param1);
      }
      
      public function serializeAs_Version(param1:IDataOutput) : void {
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element major.");
         }
         else
         {
            param1.writeByte(this.major);
            if(this.minor < 0)
            {
               throw new Error("Forbidden value (" + this.minor + ") on element minor.");
            }
            else
            {
               param1.writeByte(this.minor);
               if(this.release < 0)
               {
                  throw new Error("Forbidden value (" + this.release + ") on element release.");
               }
               else
               {
                  param1.writeByte(this.release);
                  if(this.revision < 0)
                  {
                     throw new Error("Forbidden value (" + this.revision + ") on element revision.");
                  }
                  else
                  {
                     param1.writeInt(this.revision);
                     if(this.patch < 0)
                     {
                        throw new Error("Forbidden value (" + this.patch + ") on element patch.");
                     }
                     else
                     {
                        param1.writeByte(this.patch);
                        param1.writeByte(this.buildType);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_Version(param1);
      }
      
      public function deserializeAs_Version(param1:IDataInput) : void {
         this.major = param1.readByte();
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element of Version.major.");
         }
         else
         {
            this.minor = param1.readByte();
            if(this.minor < 0)
            {
               throw new Error("Forbidden value (" + this.minor + ") on element of Version.minor.");
            }
            else
            {
               this.release = param1.readByte();
               if(this.release < 0)
               {
                  throw new Error("Forbidden value (" + this.release + ") on element of Version.release.");
               }
               else
               {
                  this.revision = param1.readInt();
                  if(this.revision < 0)
                  {
                     throw new Error("Forbidden value (" + this.revision + ") on element of Version.revision.");
                  }
                  else
                  {
                     this.patch = param1.readByte();
                     if(this.patch < 0)
                     {
                        throw new Error("Forbidden value (" + this.patch + ") on element of Version.patch.");
                     }
                     else
                     {
                        this.buildType = param1.readByte();
                        if(this.buildType < 0)
                        {
                           throw new Error("Forbidden value (" + this.buildType + ") on element of Version.buildType.");
                        }
                        else
                        {
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
