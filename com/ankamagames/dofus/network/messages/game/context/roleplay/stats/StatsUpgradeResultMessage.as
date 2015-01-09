package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StatsUpgradeResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5609;

        private var _isInitialized:Boolean = false;
        public var result:int = 0;
        public var nbCharacBoost:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5609);
        }

        public function initStatsUpgradeResultMessage(result:int=0, nbCharacBoost:uint=0):StatsUpgradeResultMessage
        {
            this.result = result;
            this.nbCharacBoost = nbCharacBoost;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.result = 0;
            this.nbCharacBoost = 0;
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
            this.serializeAs_StatsUpgradeResultMessage(output);
        }

        public function serializeAs_StatsUpgradeResultMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.result);
            if (this.nbCharacBoost < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbCharacBoost) + ") on element nbCharacBoost.")));
            };
            output.writeVarShort(this.nbCharacBoost);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StatsUpgradeResultMessage(input);
        }

        public function deserializeAs_StatsUpgradeResultMessage(input:ICustomDataInput):void
        {
            this.result = input.readByte();
            this.nbCharacBoost = input.readVarUhShort();
            if (this.nbCharacBoost < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbCharacBoost) + ") on element of StatsUpgradeResultMessage.nbCharacBoost.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.stats

