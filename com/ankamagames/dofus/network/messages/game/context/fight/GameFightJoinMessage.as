package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;

    [Trusted]
    public class GameFightJoinMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 702;

        private var _isInitialized:Boolean = false;
        public var canBeCancelled:Boolean = false;
        public var canSayReady:Boolean = false;
        public var isFightStarted:Boolean = false;
        public var timeMaxBeforeFightStart:uint = 0;
        public var fightType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (702);
        }

        public function initGameFightJoinMessage(canBeCancelled:Boolean=false, canSayReady:Boolean=false, isFightStarted:Boolean=false, timeMaxBeforeFightStart:uint=0, fightType:uint=0):GameFightJoinMessage
        {
            this.canBeCancelled = canBeCancelled;
            this.canSayReady = canSayReady;
            this.isFightStarted = isFightStarted;
            this.timeMaxBeforeFightStart = timeMaxBeforeFightStart;
            this.fightType = fightType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.canBeCancelled = false;
            this.canSayReady = false;
            this.isFightStarted = false;
            this.timeMaxBeforeFightStart = 0;
            this.fightType = 0;
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
            this.serializeAs_GameFightJoinMessage(output);
        }

        public function serializeAs_GameFightJoinMessage(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.canBeCancelled);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.canSayReady);
            _box0 = BooleanByteWrapper.setFlag(_box0, 2, this.isFightStarted);
            output.writeByte(_box0);
            if (this.timeMaxBeforeFightStart < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeMaxBeforeFightStart) + ") on element timeMaxBeforeFightStart.")));
            };
            output.writeInt(this.timeMaxBeforeFightStart);
            output.writeByte(this.fightType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightJoinMessage(input);
        }

        public function deserializeAs_GameFightJoinMessage(input:ICustomDataInput):void
        {
            var _box0:uint = input.readByte();
            this.canBeCancelled = BooleanByteWrapper.getFlag(_box0, 0);
            this.canSayReady = BooleanByteWrapper.getFlag(_box0, 1);
            this.isFightStarted = BooleanByteWrapper.getFlag(_box0, 2);
            this.timeMaxBeforeFightStart = input.readInt();
            if (this.timeMaxBeforeFightStart < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeMaxBeforeFightStart) + ") on element of GameFightJoinMessage.timeMaxBeforeFightStart.")));
            };
            this.fightType = input.readByte();
            if (this.fightType < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightType) + ") on element of GameFightJoinMessage.fightType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

