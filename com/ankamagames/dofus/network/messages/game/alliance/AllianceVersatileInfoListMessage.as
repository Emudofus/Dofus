package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class AllianceVersatileInfoListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6436;

        private var _isInitialized:Boolean = false;
        public var alliances:Vector.<AllianceVersatileInformations>;

        public function AllianceVersatileInfoListMessage()
        {
            this.alliances = new Vector.<AllianceVersatileInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6436);
        }

        public function initAllianceVersatileInfoListMessage(alliances:Vector.<AllianceVersatileInformations>=null):AllianceVersatileInfoListMessage
        {
            this.alliances = alliances;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.alliances = new Vector.<AllianceVersatileInformations>();
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

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AllianceVersatileInfoListMessage(output);
        }

        public function serializeAs_AllianceVersatileInfoListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.alliances.length);
            var _i1:uint;
            while (_i1 < this.alliances.length)
            {
                (this.alliances[_i1] as AllianceVersatileInformations).serializeAs_AllianceVersatileInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceVersatileInfoListMessage(input);
        }

        public function deserializeAs_AllianceVersatileInfoListMessage(input:ICustomDataInput):void
        {
            var _item1:AllianceVersatileInformations;
            var _alliancesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alliancesLen)
            {
                _item1 = new AllianceVersatileInformations();
                _item1.deserialize(input);
                this.alliances.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

