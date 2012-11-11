package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutSmiley extends Shortcut implements INetworkType
    {
        public var smileyId:uint = 0;
        public static const protocolId:uint = 388;

        public function ShortcutSmiley()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 388;
        }// end function

        public function initShortcutSmiley(param1:uint = 0, param2:uint = 0) : ShortcutSmiley
        {
            super.initShortcut(param1);
            this.smileyId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.smileyId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutSmiley(param1);
            return;
        }// end function

        public function serializeAs_ShortcutSmiley(param1:IDataOutput) : void
        {
            super.serializeAs_Shortcut(param1);
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
            }
            param1.writeByte(this.smileyId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutSmiley(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutSmiley(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.smileyId = param1.readByte();
            if (this.smileyId < 0)
            {
                throw new Error("Forbidden value (" + this.smileyId + ") on element of ShortcutSmiley.smileyId.");
            }
            return;
        }// end function

    }
}
