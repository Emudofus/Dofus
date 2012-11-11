package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShowCellSpectatorMessage extends ShowCellMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerName:String = "";
        public static const protocolId:uint = 6158;

        public function ShowCellSpectatorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6158;
        }// end function

        public function initShowCellSpectatorMessage(param1:int = 0, param2:uint = 0, param3:String = "") : ShowCellSpectatorMessage
        {
            super.initShowCellMessage(param1, param2);
            this.playerName = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.playerName = "";
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ShowCellSpectatorMessage(param1);
            return;
        }// end function

        public function serializeAs_ShowCellSpectatorMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ShowCellMessage(param1);
            param1.writeUTF(this.playerName);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShowCellSpectatorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShowCellSpectatorMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.playerName = param1.readUTF();
            return;
        }// end function

    }
}
