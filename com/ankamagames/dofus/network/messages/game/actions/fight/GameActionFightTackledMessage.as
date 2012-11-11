package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightTackledMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var tacklersIds:Vector.<int>;
        public static const protocolId:uint = 1004;

        public function GameActionFightTackledMessage()
        {
            this.tacklersIds = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1004;
        }// end function

        public function initGameActionFightTackledMessage(param1:uint = 0, param2:int = 0, param3:Vector.<int> = null) : GameActionFightTackledMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.tacklersIds = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.tacklersIds = new Vector.<int>;
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
            this.serializeAs_GameActionFightTackledMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightTackledMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeShort(this.tacklersIds.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.tacklersIds.length)
            {
                
                param1.writeInt(this.tacklersIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightTackledMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightTackledMessage(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.tacklersIds.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
