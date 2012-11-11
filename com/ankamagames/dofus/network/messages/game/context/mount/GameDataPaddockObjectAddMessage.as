package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameDataPaddockObjectAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paddockItemDescription:PaddockItem;
        public static const protocolId:uint = 5990;

        public function GameDataPaddockObjectAddMessage()
        {
            this.paddockItemDescription = new PaddockItem();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5990;
        }// end function

        public function initGameDataPaddockObjectAddMessage(param1:PaddockItem = null) : GameDataPaddockObjectAddMessage
        {
            this.paddockItemDescription = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.paddockItemDescription = new PaddockItem();
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
            this.serializeAs_GameDataPaddockObjectAddMessage(param1);
            return;
        }// end function

        public function serializeAs_GameDataPaddockObjectAddMessage(param1:IDataOutput) : void
        {
            this.paddockItemDescription.serializeAs_PaddockItem(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameDataPaddockObjectAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameDataPaddockObjectAddMessage(param1:IDataInput) : void
        {
            this.paddockItemDescription = new PaddockItem();
            this.paddockItemDescription.deserialize(param1);
            return;
        }// end function

    }
}
