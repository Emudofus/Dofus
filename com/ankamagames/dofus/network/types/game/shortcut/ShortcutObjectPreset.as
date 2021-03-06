﻿package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class ShortcutObjectPreset extends ShortcutObject implements INetworkType 
    {

        public static const protocolId:uint = 370;

        public var presetId:uint = 0;


        override public function getTypeId():uint
        {
            return (370);
        }

        public function initShortcutObjectPreset(slot:uint=0, presetId:uint=0):ShortcutObjectPreset
        {
            super.initShortcutObject(slot);
            this.presetId = presetId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.presetId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ShortcutObjectPreset(output);
        }

        public function serializeAs_ShortcutObjectPreset(output:ICustomDataOutput):void
        {
            super.serializeAs_ShortcutObject(output);
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element presetId.")));
            };
            output.writeByte(this.presetId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShortcutObjectPreset(input);
        }

        public function deserializeAs_ShortcutObjectPreset(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.presetId = input.readByte();
            if (this.presetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.presetId) + ") on element of ShortcutObjectPreset.presetId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.shortcut

