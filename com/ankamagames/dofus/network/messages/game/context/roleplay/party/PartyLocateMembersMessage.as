package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberGeoPosition;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5595;

        private var _isInitialized:Boolean = false;
        public var geopositions:Vector.<PartyMemberGeoPosition>;

        public function PartyLocateMembersMessage()
        {
            this.geopositions = new Vector.<PartyMemberGeoPosition>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5595);
        }

        public function initPartyLocateMembersMessage(partyId:uint=0, geopositions:Vector.<PartyMemberGeoPosition>=null):PartyLocateMembersMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.geopositions = geopositions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.geopositions = new Vector.<PartyMemberGeoPosition>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyLocateMembersMessage(output);
        }

        public function serializeAs_PartyLocateMembersMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeShort(this.geopositions.length);
            var _i1:uint;
            while (_i1 < this.geopositions.length)
            {
                (this.geopositions[_i1] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyLocateMembersMessage(input);
        }

        public function deserializeAs_PartyLocateMembersMessage(input:ICustomDataInput):void
        {
            var _item1:PartyMemberGeoPosition;
            super.deserialize(input);
            var _geopositionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _geopositionsLen)
            {
                _item1 = new PartyMemberGeoPosition();
                _item1.deserialize(input);
                this.geopositions.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

