package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Version extends Object implements IExternalizable
   {
      
      public function Version(... args) {
         super();
         if(args.length == 3)
         {
            this._major = uint(args[0]);
            this._minor = uint(args[1]);
            this._release = uint(args[2]);
         }
      }
      
      public static function fromString(version:String) : Version {
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
      
      public function get major() : uint {
         return this._major;
      }
      
      public function set major(value:uint) : void {
         this._major = value;
      }
      
      public function get minor() : uint {
         return this._minor;
      }
      
      public function set minor(value:uint) : void {
         this._minor = value;
      }
      
      public function get release() : uint {
         return this._release;
      }
      
      public function set release(value:uint) : void {
         this._release = value;
      }
      
      public function get revision() : uint {
         return this._revision;
      }
      
      public function set revision(value:uint) : void {
         this._revision = value;
      }
      
      public function get patch() : uint {
         return this._patch;
      }
      
      public function set patch(value:uint) : void {
         this._patch = value;
      }
      
      public function get buildType() : uint {
         return this._buildType;
      }
      
      public function set buildType(value:uint) : void {
         this._buildType = value;
      }
      
      public function toString() : String {
         return this._major + "." + this._minor + "." + this._release + "." + this._revision + "." + this._patch;
      }
      
      public function equals(otherVersion:Version) : Boolean {
         return (this._major == otherVersion.major) && (this._minor == otherVersion.minor) && (this._release == otherVersion.release) && (this._buildType == otherVersion.buildType);
      }
      
      public function writeExternal(output:IDataOutput) : void {
         output.writeByte(this.major);
         output.writeByte(this.minor);
         output.writeByte(this.release);
         output.writeByte(this.buildType);
      }
      
      public function readExternal(input:IDataInput) : void {
         this.major = input.readUnsignedByte();
         this.minor = input.readUnsignedByte();
         this.release = input.readUnsignedByte();
         this.buildType = input.readUnsignedByte();
      }
   }
}
