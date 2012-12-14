package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HumanOptionEmote extends HumanOption implements INetworkType
    {
        public var emoteId:int = 0;
        public var emoteStartTime:Number = 0;
        public static const protocolId:uint = 407;

        public function HumanOptionEmote()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 407;
        }// end function

        public function initHumanOptionEmote(param1:int = 0, param2:Number = 0) : HumanOptionEmote
        {
            this.emoteId = param1;
            this.emoteStartTime = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            this.emoteId = 0;
            this.emoteStartTime = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HumanOptionEmote(param1);
            return;
        }// end function

        public function serializeAs_HumanOptionEmote(param1:IDataOutput) : void
        {
            super.serializeAs_HumanOption(param1);
            param1.writeByte(this.emoteId);
            param1.writeDouble(this.emoteStartTime);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HumanOptionEmote(param1);
            return;
        }// end function

        public function deserializeAs_HumanOptionEmote(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.emoteId = param1.readByte();
            this.emoteStartTime = param1.readDouble();
            return;
        }// end function

    }
}
