package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class AccountHouseMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6315;

        private var _isInitialized:Boolean = false;
        public var houses:Vector.<AccountHouseInformations>;

        public function AccountHouseMessage()
        {
            this.houses = new Vector.<AccountHouseInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6315);
        }

        public function initAccountHouseMessage(houses:Vector.<AccountHouseInformations>=null):AccountHouseMessage
        {
            this.houses = houses;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houses = new Vector.<AccountHouseInformations>();
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
            this.serializeAs_AccountHouseMessage(output);
        }

        public function serializeAs_AccountHouseMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.houses.length);
            var _i1:uint;
            while (_i1 < this.houses.length)
            {
                (this.houses[_i1] as AccountHouseInformations).serializeAs_AccountHouseInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AccountHouseMessage(input);
        }

        public function deserializeAs_AccountHouseMessage(input:ICustomDataInput):void
        {
            var _item1:AccountHouseInformations;
            var _housesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _housesLen)
            {
                _item1 = new AccountHouseInformations();
                _item1.deserialize(input);
                this.houses.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

