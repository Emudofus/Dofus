package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class DungeonPartyFinderAvailableDungeonsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6242;

        private var _isInitialized:Boolean = false;
        public var dungeonIds:Vector.<uint>;

        public function DungeonPartyFinderAvailableDungeonsMessage()
        {
            this.dungeonIds = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6242);
        }

        public function initDungeonPartyFinderAvailableDungeonsMessage(dungeonIds:Vector.<uint>=null):DungeonPartyFinderAvailableDungeonsMessage
        {
            this.dungeonIds = dungeonIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonIds = new Vector.<uint>();
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
            this.serializeAs_DungeonPartyFinderAvailableDungeonsMessage(output);
        }

        public function serializeAs_DungeonPartyFinderAvailableDungeonsMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.dungeonIds.length);
            var _i1:uint;
            while (_i1 < this.dungeonIds.length)
            {
                if (this.dungeonIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.dungeonIds[_i1]) + ") on element 1 (starting at 1) of dungeonIds.")));
                };
                output.writeVarShort(this.dungeonIds[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DungeonPartyFinderAvailableDungeonsMessage(input);
        }

        public function deserializeAs_DungeonPartyFinderAvailableDungeonsMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _dungeonIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _dungeonIdsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of dungeonIds.")));
                };
                this.dungeonIds.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

