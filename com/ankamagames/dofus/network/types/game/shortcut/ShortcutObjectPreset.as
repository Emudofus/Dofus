package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutObjectPreset extends ShortcutObject implements INetworkType
    {
        public var presetId:uint = 0;
        public static const protocolId:uint = 370;

        public function ShortcutObjectPreset()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 370;
        }// end function

        public function initShortcutObjectPreset(param1:uint = 0, param2:uint = 0) : ShortcutObjectPreset
        {
            super.initShortcutObject(param1);
            this.presetId = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.presetId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShortcutObjectPreset(param1);
            return;
        }// end function

        public function serializeAs_ShortcutObjectPreset(param1:IDataOutput) : void
        {
            super.serializeAs_ShortcutObject(param1);
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
            }
            param1.writeByte(this.presetId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutObjectPreset(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutObjectPreset(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.presetId = param1.readByte();
            if (this.presetId < 0)
            {
                throw new Error("Forbidden value (" + this.presetId + ") on element of ShortcutObjectPreset.presetId.");
            }
            return;
        }// end function

    }
}
