package com.ankamagames.dofus.network.types.game.shortcut
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class ShortcutSmiley extends Shortcut implements INetworkType 
    {

        public static const protocolId:uint = 388;

        public var smileyId:uint = 0;


        override public function getTypeId():uint
        {
            return (388);
        }

        public function initShortcutSmiley(slot:uint=0, smileyId:uint=0):ShortcutSmiley
        {
            super.initShortcut(slot);
            this.smileyId = smileyId;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.smileyId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ShortcutSmiley(output);
        }

        public function serializeAs_ShortcutSmiley(output:ICustomDataOutput):void
        {
            super.serializeAs_Shortcut(output);
            if (this.smileyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.smileyId) + ") on element smileyId.")));
            };
            output.writeByte(this.smileyId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShortcutSmiley(input);
        }

        public function deserializeAs_ShortcutSmiley(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.smileyId = input.readByte();
            if (this.smileyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.smileyId) + ") on element of ShortcutSmiley.smileyId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.shortcut

