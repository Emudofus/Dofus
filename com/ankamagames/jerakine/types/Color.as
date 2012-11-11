package com.ankamagames.jerakine.types
{
    import flash.utils.*;

    public class Color extends Object implements IExternalizable
    {
        public var red:uint;
        public var green:uint;
        public var blue:uint;

        public function Color(param1:uint = 0)
        {
            this.parseColor(param1);
            return;
        }// end function

        public function get color() : uint
        {
            return (this.red & 255) << 16 | (this.green & 255) << 8 | this.blue & 255;
        }// end function

        public function set color(param1:uint) : void
        {
            this.parseColor(param1);
            return;
        }// end function

        public function readExternal(param1:IDataInput) : void
        {
            this.red = param1.readUnsignedByte();
            this.green = param1.readUnsignedByte();
            this.blue = param1.readUnsignedByte();
            return;
        }// end function

        public function writeExternal(param1:IDataOutput) : void
        {
            param1.writeByte(this.red);
            param1.writeByte(this.green);
            param1.writeByte(this.blue);
            return;
        }// end function

        public function toString() : String
        {
            return "[AdvancedColor(R=\"" + this.red + "\",G=\"" + this.green + "\",B=\"" + this.blue + "\")]";
        }// end function

        public function release() : void
        {
            var _loc_1:* = 0;
            this.blue = 0;
            this.green = _loc_1;
            this.red = _loc_1;
            return;
        }// end function

        public function adjustDarkness(param1:Number) : void
        {
            this.red = (1 - param1) * this.red;
            this.green = (1 - param1) * this.green;
            this.blue = (1 - param1) * this.blue;
            return;
        }// end function

        public function adjustLight(param1:Number) : void
        {
            this.red = this.red + param1 * (255 - this.red);
            this.green = this.green + param1 * (255 - this.green);
            this.blue = this.blue + param1 * (255 - this.blue);
            return;
        }// end function

        private function parseColor(param1:uint) : void
        {
            this.red = (param1 & 16711680) >> 16;
            this.green = (param1 & 65280) >> 8;
            this.blue = param1 & 255;
            return;
        }// end function

    }
}
