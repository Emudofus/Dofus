package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MapRunningFightDetailsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5750;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5750);
        }

        public function initMapRunningFightDetailsRequestMessage(fightId:uint=0):MapRunningFightDetailsRequestMessage
        {
            this.fightId = fightId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
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
            this.serializeAs_MapRunningFightDetailsRequestMessage(output);
        }

        public function serializeAs_MapRunningFightDetailsRequestMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeInt(this.fightId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapRunningFightDetailsRequestMessage(input);
        }

        public function deserializeAs_MapRunningFightDetailsRequestMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of MapRunningFightDetailsRequestMessage.fightId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

