package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LifePointsRegenEndMessage extends UpdateLifePointsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5686;

        private var _isInitialized:Boolean = false;
        public var lifePointsGained:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5686);
        }

        public function initLifePointsRegenEndMessage(lifePoints:uint=0, maxLifePoints:uint=0, lifePointsGained:uint=0):LifePointsRegenEndMessage
        {
            super.initUpdateLifePointsMessage(lifePoints, maxLifePoints);
            this.lifePointsGained = lifePointsGained;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.lifePointsGained = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_LifePointsRegenEndMessage(output);
        }

        public function serializeAs_LifePointsRegenEndMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_UpdateLifePointsMessage(output);
            if (this.lifePointsGained < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePointsGained) + ") on element lifePointsGained.")));
            };
            output.writeVarInt(this.lifePointsGained);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LifePointsRegenEndMessage(input);
        }

        public function deserializeAs_LifePointsRegenEndMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.lifePointsGained = input.readVarUhInt();
            if (this.lifePointsGained < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePointsGained) + ") on element of LifePointsRegenEndMessage.lifePointsGained.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.stats

