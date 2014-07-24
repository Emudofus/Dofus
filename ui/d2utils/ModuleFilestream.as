package d2utils
{
   import flash.utils.ByteArray;
   
   public class ModuleFilestream extends Object
   {
      
      public function ModuleFilestream() {
         super();
      }
      
      public function get endian() : String {
         return null;
      }
      
      public function get path() : String {
         return null;
      }
      
      public function set endian(type:String) : void {
      }
      
      public function get bytesAvailable() : uint {
         return 0;
      }
      
      public function get position() : uint {
         return 0;
      }
      
      public function set position(offset:uint) : void {
      }
      
      public function close() : void {
      }
      
      public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void {
      }
      
      public function readBoolean() : Boolean {
         return false;
      }
      
      public function readByte() : int {
         return 0;
      }
      
      public function readUnsignedByte() : uint {
         return 0;
      }
      
      public function readShort() : int {
         return 0;
      }
      
      public function readUnsignedShort() : uint {
         return 0;
      }
      
      public function readInt() : int {
         return 0;
      }
      
      public function readUnsignedInt() : uint {
         return 0;
      }
      
      public function readFloat() : Number {
         return 0;
      }
      
      public function readDouble() : Number {
         return 0;
      }
      
      public function readUTF() : String {
         return null;
      }
      
      public function readUTFBytes(length:uint) : String {
         return null;
      }
      
      public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void {
      }
      
      public function writeBoolean(value:Boolean) : void {
      }
      
      public function writeByte(value:int) : void {
      }
      
      public function writeShort(value:int) : void {
      }
      
      public function writeInt(value:int) : void {
      }
      
      public function writeUnsignedInt(value:uint) : void {
      }
      
      public function writeFloat(value:Number) : void {
      }
      
      public function writeDouble(value:Number) : void {
      }
      
      public function writeUTF(value:String) : void {
      }
      
      public function writeUTFBytes(value:String) : void {
      }
   }
}
