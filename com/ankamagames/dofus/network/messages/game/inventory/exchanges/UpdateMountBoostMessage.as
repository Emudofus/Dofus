package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class UpdateMountBoostMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var rideId:Number = 0;
        public var boostToUpdateList:Vector.<UpdateMountBoost>;
        public static const protocolId:uint = 6179;

        public function UpdateMountBoostMessage()
        {
            this.boostToUpdateList = new Vector.<UpdateMountBoost>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6179;
        }// end function

        public function initUpdateMountBoostMessage(param1:Number = 0, param2:Vector.<UpdateMountBoost> = null) : UpdateMountBoostMessage
        {
            this.rideId = param1;
            this.boostToUpdateList = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.rideId = 0;
            this.boostToUpdateList = new Vector.<UpdateMountBoost>;
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
            this.serializeAs_UpdateMountBoostMessage(param1);
            return;
        }// end function

        public function serializeAs_UpdateMountBoostMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.rideId);
            param1.writeShort(this.boostToUpdateList.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.boostToUpdateList.length)
            {
                
                param1.writeShort((this.boostToUpdateList[_loc_2] as UpdateMountBoost).getTypeId());
                (this.boostToUpdateList[_loc_2] as UpdateMountBoost).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_UpdateMountBoostMessage(param1);
            return;
        }// end function

        public function deserializeAs_UpdateMountBoostMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:UpdateMountBoost = null;
            this.rideId = param1.readDouble();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(UpdateMountBoost, _loc_4);
                _loc_5.deserialize(param1);
                this.boostToUpdateList.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
