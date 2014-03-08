package nochump.util.zip
{
   import flash.utils.ByteArray;
   
   public class Deflater extends Object
   {
      
      public function Deflater() {
         super();
         this.reset();
      }
      
      private var buf:ByteArray;
      
      private var compressed:Boolean;
      
      private var totalIn:uint;
      
      private var totalOut:uint;
      
      public function reset() : void {
         this.buf = new ByteArray();
         this.compressed = false;
         this.totalOut = this.totalIn = 0;
      }
      
      public function setInput(param1:ByteArray) : void {
         this.buf.writeBytes(param1);
         this.totalIn = this.buf.length;
      }
      
      public function deflate(param1:ByteArray) : uint {
         if(!this.compressed)
         {
            this.buf.compress();
            this.compressed = true;
         }
         param1.writeBytes(this.buf,2,this.buf.length - 6);
         this.totalOut = param1.length;
         return 0;
      }
      
      public function getBytesRead() : uint {
         return this.totalIn;
      }
      
      public function getBytesWritten() : uint {
         return this.totalOut;
      }
   }
}
