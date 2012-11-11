package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutEmote extends Shortcut implements INetworkType
    {
        public var emoteId:uint = 0;
        public static const protocolId:uint = 389;

        public function ShortcutEmote()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 389;
        }// end function

        public function initShortcutEmote(param1:uint = 0, param2:uint = 0) : ShortcutEmote
        {
            super.initShortcut(param1);
            this.emoteId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.emoteId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutEmote(param1);
            return;
        }// end function

        public function serializeAs_ShortcutEmote(param1:IDataOutput) : void
        {
            super.serializeAs_Shortcut(param1);
            if (this.emoteId < 0)
            {
                throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
            }
            param1.writeByte(this.emoteId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutEmote(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutEmote(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.emoteId = param1.readByte();
            if (this.emoteId < 0)
            {
                throw new Error("Forbidden value (" + this.emoteId + ") on element of ShortcutEmote.emoteId.");
            }
            return;
        }// end function

    }
}
