package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildHousesInformationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5919;

        private var _isInitialized:Boolean = false;
        public var housesInformations:Vector.<HouseInformationsForGuild>;

        public function GuildHousesInformationMessage()
        {
            this.housesInformations = new Vector.<HouseInformationsForGuild>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5919);
        }

        public function initGuildHousesInformationMessage(housesInformations:Vector.<HouseInformationsForGuild>=null):GuildHousesInformationMessage
        {
            this.housesInformations = housesInformations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.housesInformations = new Vector.<HouseInformationsForGuild>();
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
            this.serializeAs_GuildHousesInformationMessage(output);
        }

        public function serializeAs_GuildHousesInformationMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.housesInformations.length);
            var _i1:uint;
            while (_i1 < this.housesInformations.length)
            {
                (this.housesInformations[_i1] as HouseInformationsForGuild).serializeAs_HouseInformationsForGuild(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildHousesInformationMessage(input);
        }

        public function deserializeAs_GuildHousesInformationMessage(input:ICustomDataInput):void
        {
            var _item1:HouseInformationsForGuild;
            var _housesInformationsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _housesInformationsLen)
            {
                _item1 = new HouseInformationsForGuild();
                _item1.deserialize(input);
                this.housesInformations.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

