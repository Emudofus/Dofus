package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapFightCountMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightCount:uint = 0;
        public static const protocolId:uint = 210;

        public function MapFightCountMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 210;
        }// end function

        public function initMapFightCountMessage(param1:uint = 0) : MapFightCountMessage
        {
            this.fightCount = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightCount = 0;
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
            this.serializeAs_MapFightCountMessage(param1);
            return;
        }// end function

        public function serializeAs_MapFightCountMessage(param1:IDataOutput) : void
        {
            if (this.fightCount < 0)
            {
                throw new Error("Forbidden value (" + this.fightCount + ") on element fightCount.");
            }
            param1.writeShort(this.fightCount);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapFightCountMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapFightCountMessage(param1:IDataInput) : void
        {
            this.fightCount = param1.readShort();
            if (this.fightCount < 0)
            {
                throw new Error("Forbidden value (" + this.fightCount + ") on element of MapFightCountMessage.fightCount.");
            }
            return;
        }// end function

    }
}
