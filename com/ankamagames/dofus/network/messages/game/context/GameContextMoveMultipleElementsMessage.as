package com.ankamagames.dofus.network.messages.game.context
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameContextMoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var movements:Vector.<EntityMovementInformations>;
        public static const protocolId:uint = 254;

        public function GameContextMoveMultipleElementsMessage()
        {
            this.movements = new Vector.<EntityMovementInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 254;
        }// end function

        public function initGameContextMoveMultipleElementsMessage(param1:Vector.<EntityMovementInformations> = null) : GameContextMoveMultipleElementsMessage
        {
            this.movements = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.movements = new Vector.<EntityMovementInformations>;
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
            this.serializeAs_GameContextMoveMultipleElementsMessage(param1);
            return;
        }// end function

        public function serializeAs_GameContextMoveMultipleElementsMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.movements.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.movements.length)
            {
                
                (this.movements[_loc_2] as EntityMovementInformations).serializeAs_EntityMovementInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameContextMoveMultipleElementsMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameContextMoveMultipleElementsMessage(param1:IDataInput) : void
        {
            var _loc_4:EntityMovementInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new EntityMovementInformations();
                _loc_4.deserialize(param1);
                this.movements.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
