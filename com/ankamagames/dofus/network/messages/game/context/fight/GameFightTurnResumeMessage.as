package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightTurnResumeMessage extends GameFightTurnStartMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6307;

        private var _isInitialized:Boolean = false;
        public var remainingTime:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6307);
        }

        public function initGameFightTurnResumeMessage(id:int=0, waitTime:uint=0, remainingTime:uint=0):GameFightTurnResumeMessage
        {
            super.initGameFightTurnStartMessage(id, waitTime);
            this.remainingTime = remainingTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.remainingTime = 0;
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
            this.serializeAs_GameFightTurnResumeMessage(output);
        }

        public function serializeAs_GameFightTurnResumeMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightTurnStartMessage(output);
            if (this.remainingTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.remainingTime) + ") on element remainingTime.")));
            };
            output.writeVarInt(this.remainingTime);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightTurnResumeMessage(input);
        }

        public function deserializeAs_GameFightTurnResumeMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.remainingTime = input.readVarUhInt();
            if (this.remainingTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.remainingTime) + ") on element of GameFightTurnResumeMessage.remainingTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

