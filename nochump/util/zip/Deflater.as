package nochump.util.zip
{
    import flash.utils.*;

    public class Deflater extends Object
    {
        private var buf:ByteArray;
        private var compressed:Boolean;
        private var totalIn:uint;
        private var totalOut:uint;

        public function Deflater()
        {
            this.reset();
            return;
        }// end function

        public function reset() : void
        {
            this.buf = new ByteArray();
            this.compressed = false;
            var _loc_1:* = 0;
            this.totalIn = 0;
            this.totalOut = _loc_1;
            return;
        }// end function

        public function setInput(param1:ByteArray) : void
        {
            this.buf.writeBytes(param1);
            this.totalIn = this.buf.length;
            return;
        }// end function

        public function deflate(param1:ByteArray) : uint
        {
            if (!this.compressed)
            {
                this.buf.compress();
                this.compressed = true;
            }
            param1.writeBytes(this.buf, 2, this.buf.length - 6);
            this.totalOut = param1.length;
            return 0;
        }// end function

        public function getBytesRead() : uint
        {
            return this.totalIn;
        }// end function

        public function getBytesWritten() : uint
        {
            return this.totalOut;
        }// end function

    }
}
