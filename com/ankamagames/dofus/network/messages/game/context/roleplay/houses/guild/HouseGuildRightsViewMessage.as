package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseGuildRightsViewMessage extends NetworkMessage implements INetworkMessage
    {
        public static const protocolId:uint = 5700;

        public function HouseGuildRightsViewMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return true;
        }// end function

        override public function getMessageId() : uint
        {
            return 5700;
        }// end function

        public function initHouseGuildRightsViewMessage() : HouseGuildRightsViewMessage
        {
            return this;
        }// end function

        override public function reset() : void
        {
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            return;
        }// end function

        public function serializeAs_HouseGuildRightsViewMessage(param1:IDataOutput) : void
        {
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            return;
        }// end function

        public function deserializeAs_HouseGuildRightsViewMessage(param1:IDataInput) : void
        {
            return;
        }// end function

    }
}
