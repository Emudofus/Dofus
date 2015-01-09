package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightPlacementSwapPositionsOfferMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6542;

        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var requesterId:uint = 0;
        public var requesterCellId:uint = 0;
        public var requestedId:uint = 0;
        public var requestedCellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6542);
        }

        public function initGameFightPlacementSwapPositionsOfferMessage(requestId:uint=0, requesterId:uint=0, requesterCellId:uint=0, requestedId:uint=0, requestedCellId:uint=0):GameFightPlacementSwapPositionsOfferMessage
        {
            this.requestId = requestId;
            this.requesterId = requesterId;
            this.requesterCellId = requesterCellId;
            this.requestedId = requestedId;
            this.requestedCellId = requestedCellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.requestId = 0;
            this.requesterId = 0;
            this.requesterCellId = 0;
            this.requestedId = 0;
            this.requestedCellId = 0;
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
            this.serializeAs_GameFightPlacementSwapPositionsOfferMessage(output);
        }

        public function serializeAs_GameFightPlacementSwapPositionsOfferMessage(output:ICustomDataOutput):void
        {
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element requestId.")));
            };
            output.writeInt(this.requestId);
            if (this.requesterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requesterId) + ") on element requesterId.")));
            };
            output.writeVarInt(this.requesterId);
            if ((((this.requesterCellId < 0)) || ((this.requesterCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.requesterCellId) + ") on element requesterCellId.")));
            };
            output.writeVarShort(this.requesterCellId);
            if (this.requestedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestedId) + ") on element requestedId.")));
            };
            output.writeVarInt(this.requestedId);
            if ((((this.requestedCellId < 0)) || ((this.requestedCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.requestedCellId) + ") on element requestedCellId.")));
            };
            output.writeVarShort(this.requestedCellId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightPlacementSwapPositionsOfferMessage(input);
        }

        public function deserializeAs_GameFightPlacementSwapPositionsOfferMessage(input:ICustomDataInput):void
        {
            this.requestId = input.readInt();
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestId.")));
            };
            this.requesterId = input.readVarUhInt();
            if (this.requesterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requesterId) + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterId.")));
            };
            this.requesterCellId = input.readVarUhShort();
            if ((((this.requesterCellId < 0)) || ((this.requesterCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.requesterCellId) + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterCellId.")));
            };
            this.requestedId = input.readVarUhInt();
            if (this.requestedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestedId) + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedId.")));
            };
            this.requestedCellId = input.readVarUhShort();
            if ((((this.requestedCellId < 0)) || ((this.requestedCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.requestedCellId) + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedCellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

