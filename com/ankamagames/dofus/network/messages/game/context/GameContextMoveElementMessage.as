package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameContextMoveElementMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var movement:EntityMovementInformations;
        public static const protocolId:uint = 253;

        public function GameContextMoveElementMessage()
        {
            this.movement = new EntityMovementInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 253;
        }// end function

        public function initGameContextMoveElementMessage(param1:EntityMovementInformations = null) : GameContextMoveElementMessage
        {
            this.movement = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.movement = new EntityMovementInformations();
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
            this.serializeAs_GameContextMoveElementMessage(param1);
            return;
        }// end function

        public function serializeAs_GameContextMoveElementMessage(param1:IDataOutput) : void
        {
            this.movement.serializeAs_EntityMovementInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameContextMoveElementMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameContextMoveElementMessage(param1:IDataInput) : void
        {
            this.movement = new EntityMovementInformations();
            this.movement.deserialize(param1);
            return;
        }// end function

    }
}
