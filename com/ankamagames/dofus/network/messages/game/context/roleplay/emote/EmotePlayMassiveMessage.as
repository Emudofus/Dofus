package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EmotePlayMassiveMessage extends EmotePlayAbstractMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actorIds:Vector.<int>;
        public static const protocolId:uint = 5691;

        public function EmotePlayMassiveMessage()
        {
            this.actorIds = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5691;
        }// end function

        public function initEmotePlayMassiveMessage(param1:uint = 0, param2:Number = 0, param3:Vector.<int> = null) : EmotePlayMassiveMessage
        {
            super.initEmotePlayAbstractMessage(param1, param2);
            this.actorIds = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.actorIds = new Vector.<int>;
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
            this.serializeAs_EmotePlayMassiveMessage(param1);
            return;
        }// end function

        public function serializeAs_EmotePlayMassiveMessage(param1:IDataOutput) : void
        {
            super.serializeAs_EmotePlayAbstractMessage(param1);
            param1.writeShort(this.actorIds.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.actorIds.length)
            {
                
                param1.writeInt(this.actorIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EmotePlayMassiveMessage(param1);
            return;
        }// end function

        public function deserializeAs_EmotePlayMassiveMessage(param1:IDataInput) : void
        {
            var _loc_4:int = 0;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.actorIds.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
