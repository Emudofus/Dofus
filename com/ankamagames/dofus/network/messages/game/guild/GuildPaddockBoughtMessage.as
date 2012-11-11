package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildPaddockBoughtMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paddockInfo:PaddockContentInformations;
        public static const protocolId:uint = 5952;

        public function GuildPaddockBoughtMessage()
        {
            this.paddockInfo = new PaddockContentInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5952;
        }// end function

        public function initGuildPaddockBoughtMessage(param1:PaddockContentInformations = null) : GuildPaddockBoughtMessage
        {
            this.paddockInfo = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.paddockInfo = new PaddockContentInformations();
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
            this.serializeAs_GuildPaddockBoughtMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildPaddockBoughtMessage(param1:IDataOutput) : void
        {
            this.paddockInfo.serializeAs_PaddockContentInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildPaddockBoughtMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildPaddockBoughtMessage(param1:IDataInput) : void
        {
            this.paddockInfo = new PaddockContentInformations();
            this.paddockInfo.deserialize(param1);
            return;
        }// end function

    }
}
