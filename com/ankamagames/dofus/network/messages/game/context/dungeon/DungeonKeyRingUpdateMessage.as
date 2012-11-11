package com.ankamagames.dofus.network.messages.game.context.dungeon
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DungeonKeyRingUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var available:Boolean = false;
        public static const protocolId:uint = 6296;

        public function DungeonKeyRingUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6296;
        }// end function

        public function initDungeonKeyRingUpdateMessage(param1:uint = 0, param2:Boolean = false) : DungeonKeyRingUpdateMessage
        {
            this.dungeonId = param1;
            this.available = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.available = false;
            this._isInitialized = false;
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
            this.serializeAs_DungeonKeyRingUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_DungeonKeyRingUpdateMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            param1.writeBoolean(this.available);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DungeonKeyRingUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_DungeonKeyRingUpdateMessage(param1:IDataInput) : void
        {
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonKeyRingUpdateMessage.dungeonId.");
            }
            this.available = param1.readBoolean();
            return;
        }// end function

    }
}
