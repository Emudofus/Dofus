package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SetUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var setId:uint = 0;
        public var setObjects:Vector.<uint>;
        public var setEffects:Vector.<ObjectEffect>;
        public static const protocolId:uint = 5503;

        public function SetUpdateMessage()
        {
            this.setObjects = new Vector.<uint>;
            this.setEffects = new Vector.<ObjectEffect>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5503;
        }// end function

        public function initSetUpdateMessage(param1:uint = 0, param2:Vector.<uint> = null, param3:Vector.<ObjectEffect> = null) : SetUpdateMessage
        {
            this.setId = param1;
            this.setObjects = param2;
            this.setEffects = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.setId = 0;
            this.setObjects = new Vector.<uint>;
            this.setEffects = new Vector.<ObjectEffect>;
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
            this.serializeAs_SetUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_SetUpdateMessage(param1:IDataOutput) : void
        {
            if (this.setId < 0)
            {
                throw new Error("Forbidden value (" + this.setId + ") on element setId.");
            }
            param1.writeShort(this.setId);
            param1.writeShort(this.setObjects.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.setObjects.length)
            {
                
                if (this.setObjects[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.setObjects[_loc_2] + ") on element 2 (starting at 1) of setObjects.");
                }
                param1.writeShort(this.setObjects[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.setEffects.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.setEffects.length)
            {
                
                param1.writeShort((this.setEffects[_loc_3] as ObjectEffect).getTypeId());
                (this.setEffects[_loc_3] as ObjectEffect).serialize(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SetUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_SetUpdateMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_8:ObjectEffect = null;
            this.setId = param1.readShort();
            if (this.setId < 0)
            {
                throw new Error("Forbidden value (" + this.setId + ") on element of SetUpdateMessage.setId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of setObjects.");
                }
                this.setObjects.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readUnsignedShort();
                _loc_8 = ProtocolTypeManager.getInstance(ObjectEffect, _loc_7);
                _loc_8.deserialize(param1);
                this.setEffects.push(_loc_8);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
