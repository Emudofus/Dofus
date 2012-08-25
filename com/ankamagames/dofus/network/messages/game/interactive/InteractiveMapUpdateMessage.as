package com.ankamagames.dofus.network.messages.game.interactive
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveMapUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var interactiveElements:Vector.<InteractiveElement>;
        public static const protocolId:uint = 5002;

        public function InteractiveMapUpdateMessage()
        {
            this.interactiveElements = new Vector.<InteractiveElement>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5002;
        }// end function

        public function initInteractiveMapUpdateMessage(param1:Vector.<InteractiveElement> = null) : InteractiveMapUpdateMessage
        {
            this.interactiveElements = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.interactiveElements = new Vector.<InteractiveElement>;
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
            this.serializeAs_InteractiveMapUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_InteractiveMapUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.interactiveElements.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.interactiveElements.length)
            {
                
                (this.interactiveElements[_loc_2] as InteractiveElement).serializeAs_InteractiveElement(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveMapUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveMapUpdateMessage(param1:IDataInput) : void
        {
            var _loc_4:InteractiveElement = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new InteractiveElement();
                _loc_4.deserialize(param1);
                this.interactiveElements.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
