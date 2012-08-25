package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightEndMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var duration:uint = 0;
        public var ageBonus:int = 0;
        public var results:Vector.<FightResultListEntry>;
        public static const protocolId:uint = 720;

        public function GameFightEndMessage()
        {
            this.results = new Vector.<FightResultListEntry>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 720;
        }// end function

        public function initGameFightEndMessage(param1:uint = 0, param2:int = 0, param3:Vector.<FightResultListEntry> = null) : GameFightEndMessage
        {
            this.duration = param1;
            this.ageBonus = param2;
            this.results = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.duration = 0;
            this.ageBonus = 0;
            this.results = new Vector.<FightResultListEntry>;
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
            this.serializeAs_GameFightEndMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightEndMessage(param1:IDataOutput) : void
        {
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element duration.");
            }
            param1.writeInt(this.duration);
            param1.writeShort(this.ageBonus);
            param1.writeShort(this.results.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.results.length)
            {
                
                param1.writeShort((this.results[_loc_2] as FightResultListEntry).getTypeId());
                (this.results[_loc_2] as FightResultListEntry).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightEndMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightEndMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:FightResultListEntry = null;
            this.duration = param1.readInt();
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element of GameFightEndMessage.duration.");
            }
            this.ageBonus = param1.readShort();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(FightResultListEntry, _loc_4);
                _loc_5.deserialize(param1);
                this.results.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
