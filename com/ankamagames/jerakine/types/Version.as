package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Version extends Object implements IExternalizable
   {
      
      public function Version(... rest)
      {
         super();
         if(rest.length == 3)
         {
            this._major = uint(rest[0]);
            this._minor = uint(rest[1]);
            this._release = uint(rest[2]);
         }
      }
      
      public static function fromString(param1:String) : Version
      {
         var version:String = param1;
         var a:Array = version.split(".");
         if(a.length != 3)
         {
            throw new ArgumentError("Format de version invalide !");
         }
         else
         {
            try
            {
               return new Version(parseInt(a[0],10),parseInt(a[1],10),parseInt(a[2],10));
            }
            catch(e:*)
            {
               throw e;
            }
            return undefined;
         }
      }
      
      private var _major:uint;
      
      private var _minor:uint;
      
      private var _release:uint;
      
      private var _revision:uint;
      
      private var _patch:uint;
      
      private var _buildType:uint;
      
      public function get major() : uint
      {
         return this._major;
      }
      
      public function set major(param1:uint) : void
      {
         this._major = param1;
      }
      
      public function get minor() : uint
      {
         return this._minor;
      }
      
      public function set minor(param1:uint) : void
      {
         this._minor = param1;
      }
      
      public function get release() : uint
      {
         return this._release;
      }
      
      public function set release(param1:uint) : void
      {
         this._release = param1;
      }
      
      public function get revision() : uint
      {
         return this._revision;
      }
      
      public function set revision(param1:uint) : void
      {
         this._revision = param1;
      }
      
      public function get patch() : uint
      {
         return this._patch;
      }
      
      public function set patch(param1:uint) : void
      {
         this._patch = param1;
      }
      
      public function get buildType() : uint
      {
         return this._buildType;
      }
      
      public function set buildType(param1:uint) : void
      {
         this._buildType = param1;
      }
      
      public function toString() : String
      {
         return this._major + "." + this._minor + "." + this._release + "." + this._revision + "." + this._patch;
      }
      
      public function equals(param1:Version) : Boolean
      {
         return this._major == param1.major && this._minor == param1.minor && this._release == param1.release && this._buildType == param1.buildType;
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeByte(this.major);
         param1.writeByte(this.minor);
         param1.writeByte(this.release);
         param1.writeByte(this.buildType);
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.major = param1.readUnsignedByte();
         this.minor = param1.readUnsignedByte();
         this.release = param1.readUnsignedByte();
         this.buildType = param1.readUnsignedByte();
      }
   }
}
