package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StatsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5610;

        private var _isInitialized:Boolean = false;
        public var useAdditionnal:Boolean = false;
        public var statId:uint = 11;
        public var boostPoint:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5610);
        }

        public function initStatsUpgradeRequestMessage(useAdditionnal:Boolean=false, statId:uint=11, boostPoint:uint=0):StatsUpgradeRequestMessage
        {
            this.useAdditionnal = useAdditionnal;
            this.statId = statId;
            this.boostPoint = boostPoint;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.useAdditionnal = false;
            this.statId = 11;
            this.boostPoint = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_StatsUpgradeRequestMessage(output);
        }

        public function serializeAs_StatsUpgradeRequestMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.useAdditionnal);
            output.writeByte(this.statId);
            if (this.boostPoint < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoint) + ") on element boostPoint.")));
            };
            output.writeVarShort(this.boostPoint);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StatsUpgradeRequestMessage(input);
        }

        public function deserializeAs_StatsUpgradeRequestMessage(input:ICustomDataInput):void
        {
            this.useAdditionnal = input.readBoolean();
            this.statId = input.readByte();
            if (this.statId < 0)
            {
                throw (new Error((("Forbidden value (" + this.statId) + ") on element of StatsUpgradeRequestMessage.statId.")));
            };
            this.boostPoint = input.readVarUhShort();
            if (this.boostPoint < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoint) + ") on element of StatsUpgradeRequestMessage.boostPoint.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.stats

