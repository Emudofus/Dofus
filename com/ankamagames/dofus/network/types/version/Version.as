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
      
      public function initVersion(major:uint=0, minor:uint=0, release:uint=0, revision:uint=0, patch:uint=0, buildType:uint=0) : Version {
         this.major = major;
         this.minor = minor;
         this.release = release;
         this.revision = revision;
         this.patch = patch;
         this.buildType = buildType;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_Version(output);
      }
      
      public function serializeAs_Version(output:IDataOutput) : void {
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element major.");
         }
         else
         {
            output.writeByte(this.major);
            if(this.minor < 0)
            {
               throw new Error("Forbidden value (" + this.minor + ") on element minor.");
            }
            else
            {
               output.writeByte(this.minor);
               if(this.release < 0)
               {
                  throw new Error("Forbidden value (" + this.release + ") on element release.");
               }
               else
               {
                  output.writeByte(this.release);
                  if(this.revision < 0)
                  {
                     throw new Error("Forbidden value (" + this.revision + ") on element revision.");
                  }
                  else
                  {
                     output.writeInt(this.revision);
                     if(this.patch < 0)
                     {
                        throw new Error("Forbidden value (" + this.patch + ") on element patch.");
                     }
                     else
                     {
                        output.writeByte(this.patch);
                        output.writeByte(this.buildType);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_Version(input);
      }
      
      public function deserializeAs_Version(input:IDataInput) : void {
         this.major = input.readByte();
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element of Version.major.");
         }
         else
         {
            this.minor = input.readByte();
            if(this.minor < 0)
            {
               throw new Error("Forbidden value (" + this.minor + ") on element of Version.minor.");
            }
            else
            {
               this.release = input.readByte();
               if(this.release < 0)
               {
                  throw new Error("Forbidden value (" + this.release + ") on element of Version.release.");
               }
               else
               {
                  this.revision = input.readInt();
                  if(this.revision < 0)
                  {
                     throw new Error("Forbidden value (" + this.revision + ") on element of Version.revision.");
                  }
                  else
                  {
                     this.patch = input.readByte();
                     if(this.patch < 0)
                     {
                        throw new Error("Forbidden value (" + this.patch + ") on element of Version.patch.");
                     }
                     else
                     {
                        this.buildType = input.readByte();
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
