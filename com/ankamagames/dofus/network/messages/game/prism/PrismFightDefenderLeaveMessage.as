package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismFightDefenderLeaveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5892;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var fightId:uint = 0;
        public var fighterToRemoveId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5892);
        }

        public function initPrismFightDefenderLeaveMessage(subAreaId:uint=0, fightId:uint=0, fighterToRemoveId:uint=0):PrismFightDefenderLeaveMessage
        {
            this.subAreaId = subAreaId;
            this.fightId = fightId;
            this.fighterToRemoveId = fighterToRemoveId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
            this.fightId = 0;
            this.fighterToRemoveId = 0;
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
            this.serializeAs_PrismFightDefenderLeaveMessage(output);
        }

        public function serializeAs_PrismFightDefenderLeaveMessage(output:ICustomDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeVarShort(this.fightId);
            if (this.fighterToRemoveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fighterToRemoveId) + ") on element fighterToRemoveId.")));
            };
            output.writeVarInt(this.fighterToRemoveId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismFightDefenderLeaveMessage(input);
        }

        public function deserializeAs_PrismFightDefenderLeaveMessage(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightDefenderLeaveMessage.subAreaId.")));
            };
            this.fightId = input.readVarUhShort();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of PrismFightDefenderLeaveMessage.fightId.")));
            };
            this.fighterToRemoveId = input.readVarUhInt();
            if (this.fighterToRemoveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fighterToRemoveId) + ") on element of PrismFightDefenderLeaveMessage.fighterToRemoveId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

