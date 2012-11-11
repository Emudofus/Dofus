package com.ankamagames.jerakine.types
{
    import flash.utils.*;

    public class DefaultableColor extends Color implements IExternalizable
    {
        public var isDefault:Boolean = false;

        public function DefaultableColor(param1:uint = 0)
        {
            super(param1);
            return;
        }// end function

        override public function writeExternal(param1:IDataOutput) : void
        {
            super.writeExternal(param1);
            param1.writeBoolean(this.isDefault);
            return;
        }// end function

        override public function readExternal(param1:IDataInput) : void
        {
            super.readExternal(param1);
            this.isDefault = param1.readBoolean();
            return;
        }// end function

    }
}
