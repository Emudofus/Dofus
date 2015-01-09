package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class PrismFightAttackerAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5893;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var fightId:uint = 0;
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

        public function initPrismFightAttackerAddMessage(subAreaId:uint=0, fightId:uint=0, attacker:CharacterMinimalPlusLookInformations=null):PrismFightAttackerAddMessage
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
            this.serializeAs_PrismFightAttackerAddMessage(output);
        }

        public function serializeAs_PrismFightAttackerAddMessage(output:ICustomDataOutput):void
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
            output.writeShort(this.attacker.getTypeId());
            this.attacker.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismFightAttackerAddMessage(input);
        }

        public function deserializeAs_PrismFightAttackerAddMessage(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightAttackerAddMessage.subAreaId.")));
            };
            this.fightId = input.readVarUhShort();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of PrismFightAttackerAddMessage.fightId.")));
            };
            var _id3:uint = input.readUnsignedShort();
            this.attacker = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id3);
            this.attacker.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

