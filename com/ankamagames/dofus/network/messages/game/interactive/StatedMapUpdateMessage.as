package com.ankamagames.dofus.network.messages.game.interactive
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StatedMapUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var statedElements:Vector.<StatedElement>;
        public static const protocolId:uint = 5716;

        public function StatedMapUpdateMessage()
        {
            this.statedElements = new Vector.<StatedElement>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5716;
        }// end function

        public function initStatedMapUpdateMessage(param1:Vector.<StatedElement> = null) : StatedMapUpdateMessage
        {
            this.statedElements = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.statedElements = new Vector.<StatedElement>;
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
            this.serializeAs_StatedMapUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_StatedMapUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.statedElements.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.statedElements.length)
            {
                
                (this.statedElements[_loc_2] as StatedElement).serializeAs_StatedElement(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StatedMapUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_StatedMapUpdateMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new StatedElement();
                _loc_4.deserialize(param1);
                this.statedElements.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
