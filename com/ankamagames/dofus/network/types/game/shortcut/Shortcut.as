package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class Shortcut extends Object implements INetworkType
    {
        public var slot:uint = 0;
        public static const protocolId:uint = 369;

        public function Shortcut()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 369;
        }// end function

        public function initShortcut(param1:uint = 0) : Shortcut
        {
            this.slot = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.slot = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_Shortcut(param1);
            return;
        }// end function

        public function serializeAs_Shortcut(param1:IDataOutput) : void
        {
            if (this.slot < 0 || this.slot > 99)
            {
                throw new Error("Forbidden value (" + this.slot + ") on element slot.");
            }
            param1.writeInt(this.slot);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_Shortcut(param1);
            return;
        }// end function

        public function deserializeAs_Shortcut(param1:IDataInput) : void
        {
            this.slot = param1.readInt();
            if (this.slot < 0 || this.slot > 99)
            {
                throw new Error("Forbidden value (" + this.slot + ") on element of Shortcut.slot.");
            }
            return;
        }// end function

    }
}
