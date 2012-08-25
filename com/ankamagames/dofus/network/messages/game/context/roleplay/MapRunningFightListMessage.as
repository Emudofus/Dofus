package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapRunningFightListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fights:Vector.<FightExternalInformations>;
        public static const protocolId:uint = 5743;

        public function MapRunningFightListMessage()
        {
            this.fights = new Vector.<FightExternalInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5743;
        }// end function

        public function initMapRunningFightListMessage(param1:Vector.<FightExternalInformations> = null) : MapRunningFightListMessage
        {
            this.fights = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fights = new Vector.<FightExternalInformations>;
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
            this.serializeAs_MapRunningFightListMessage(param1);
            return;
        }// end function

        public function serializeAs_MapRunningFightListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.fights.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.fights.length)
            {
                
                (this.fights[_loc_2] as FightExternalInformations).serializeAs_FightExternalInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapRunningFightListMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapRunningFightListMessage(param1:IDataInput) : void
        {
            var _loc_4:FightExternalInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new FightExternalInformations();
                _loc_4.deserialize(param1);
                this.fights.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
