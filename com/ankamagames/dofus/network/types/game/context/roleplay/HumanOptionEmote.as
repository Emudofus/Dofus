package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HumanOptionEmote extends HumanOption implements INetworkType 
    {

        public static const protocolId:uint = 407;

        public var emoteId:uint = 0;
        public var emoteStartTime:Number = 0;


        override public function getTypeId():uint
        {
            return (407);
        }

        public function initHumanOptionEmote(emoteId:uint=0, emoteStartTime:Number=0):HumanOptionEmote
        {
            this.emoteId = emoteId;
            this.emoteStartTime = emoteStartTime;
            return (this);
        }

        override public function reset():void
        {
            this.emoteId = 0;
            this.emoteStartTime = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HumanOptionEmote(output);
        }

        public function serializeAs_HumanOptionEmote(output:ICustomDataOutput):void
        {
            super.serializeAs_HumanOption(output);
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element emoteId.")));
            };
            output.writeByte(this.emoteId);
            if ((((this.emoteStartTime < -9007199254740992)) || ((this.emoteStartTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.emoteStartTime) + ") on element emoteStartTime.")));
            };
            output.writeDouble(this.emoteStartTime);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HumanOptionEmote(input);
        }

        public function deserializeAs_HumanOptionEmote(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.emoteId = input.readUnsignedByte();
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element of HumanOptionEmote.emoteId.")));
            };
            this.emoteStartTime = input.readDouble();
            if ((((this.emoteStartTime < -9007199254740992)) || ((this.emoteStartTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.emoteStartTime) + ") on element of HumanOptionEmote.emoteStartTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay

