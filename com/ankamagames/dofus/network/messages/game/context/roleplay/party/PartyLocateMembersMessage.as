package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var geopositions:Vector.<PartyMemberGeoPosition>;
        public static const protocolId:uint = 5595;

        public function PartyLocateMembersMessage()
        {
            this.geopositions = new Vector.<PartyMemberGeoPosition>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5595;
        }// end function

        public function initPartyLocateMembersMessage(param1:uint = 0, param2:Vector.<PartyMemberGeoPosition> = null) : PartyLocateMembersMessage
        {
            super.initAbstractPartyMessage(param1);
            this.geopositions = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.geopositions = new Vector.<PartyMemberGeoPosition>;
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
            this.serializeAs_PartyLocateMembersMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyLocateMembersMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeShort(this.geopositions.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.geopositions.length)
            {
                
                (this.geopositions[_loc_2] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyLocateMembersMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyLocateMembersMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new PartyMemberGeoPosition();
                _loc_4.deserialize(param1);
                this.geopositions.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
