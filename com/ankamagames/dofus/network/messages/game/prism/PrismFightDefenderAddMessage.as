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
    public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5895;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var fightId:uint = 0;
        public var defender:CharacterMinimalPlusLookInformations;

        public function PrismFightDefenderAddMessage()
        {
            this.defender = new CharacterMinimalPlusLookInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5895);
        }

        public function initPrismFightDefenderAddMessage(subAreaId:uint=0, fightId:uint=0, defender:CharacterMinimalPlusLookInformations=null):PrismFightDefenderAddMessage
        {
            this.subAreaId = subAreaId;
            this.fightId = fightId;
            this.defender = defender;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
            this.fightId = 0;
            this.defender = new CharacterMinimalPlusLookInformations();
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
            this.serializeAs_PrismFightDefenderAddMessage(output);
        }

        public function serializeAs_PrismFightDefenderAddMessage(output:ICustomDataOutput):void
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
            output.writeShort(this.defender.getTypeId());
            this.defender.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismFightDefenderAddMessage(input);
        }

        public function deserializeAs_PrismFightDefenderAddMessage(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightDefenderAddMessage.subAreaId.")));
            };
            this.fightId = input.readVarUhShort();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of PrismFightDefenderAddMessage.fightId.")));
            };
            var _id3:uint = input.readUnsignedShort();
            this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations, _id3);
            this.defender.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

