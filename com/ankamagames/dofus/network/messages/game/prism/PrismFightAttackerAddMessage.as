package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class PrismFightAttackerAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5893;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var fightId:Number = 0;
        public var attacker:CharacterMinimalPlusLookInformations;

        public function PrismFightAttackerAddMessage()
        {
            this.attacker = new CharacterMinimalPlusLookInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5893);
        }

        public function initPrismFightAttackerAddMessage(subAreaId:uint=0, fightId:Number=0, attacker:CharacterMinimalPlusLookInformations=null):PrismFightAttackerAddMessage
        {
            this.subAreaId = subAreaId;
            this.fightId = fightId;
            this.attacker = attacker;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
            this.fightId = 0;
            this.attacker = new CharacterMinimalPlusLookInformations();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PrismFightAttackerAddMessage(output);
        }

        public function serializeAs_PrismFightAttackerAddMessage(output:IDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
            if ((((this.fightId < -9007199254740992)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeDouble(this.fightId);
            output.writeShort(this.attacker.getTypeId());
            this.attacker.serialize(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PrismFightAttackerAddMessage(input);
        }

        public function deserializeAs_PrismFightAttackerAddMessage(input:IDataInput):void
        {
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightAttackerAddMessage.subAreaId.")));
            };
            this.fightId = input.readDouble();
            if ((((this.fightId < -9007199254740992)) || ((this.fightId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of PrismFightAttackerAddMessage.fightId.")));
            };
            var _id3:uint = input.readUnsignedShort();
            this.attacker = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id3);
            this.attacker.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

