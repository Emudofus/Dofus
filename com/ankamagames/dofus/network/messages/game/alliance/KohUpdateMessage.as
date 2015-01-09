package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class KohUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6439;

        private var _isInitialized:Boolean = false;
        public var alliances:Vector.<AllianceInformations>;
        public var allianceNbMembers:Vector.<uint>;
        public var allianceRoundWeigth:Vector.<uint>;
        public var allianceMatchScore:Vector.<uint>;
        public var allianceMapWinner:BasicAllianceInformations;
        public var allianceMapWinnerScore:uint = 0;
        public var allianceMapMyAllianceScore:uint = 0;
        public var nextTickTime:Number = 0;

        public function KohUpdateMessage()
        {
            this.alliances = new Vector.<AllianceInformations>();
            this.allianceNbMembers = new Vector.<uint>();
            this.allianceRoundWeigth = new Vector.<uint>();
            this.allianceMatchScore = new Vector.<uint>();
            this.allianceMapWinner = new BasicAllianceInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6439);
        }

        public function initKohUpdateMessage(alliances:Vector.<AllianceInformations>=null, allianceNbMembers:Vector.<uint>=null, allianceRoundWeigth:Vector.<uint>=null, allianceMatchScore:Vector.<uint>=null, allianceMapWinner:BasicAllianceInformations=null, allianceMapWinnerScore:uint=0, allianceMapMyAllianceScore:uint=0, nextTickTime:Number=0):KohUpdateMessage
        {
            this.alliances = alliances;
            this.allianceNbMembers = allianceNbMembers;
            this.allianceRoundWeigth = allianceRoundWeigth;
            this.allianceMatchScore = allianceMatchScore;
            this.allianceMapWinner = allianceMapWinner;
            this.allianceMapWinnerScore = allianceMapWinnerScore;
            this.allianceMapMyAllianceScore = allianceMapMyAllianceScore;
            this.nextTickTime = nextTickTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.alliances = new Vector.<AllianceInformations>();
            this.allianceNbMembers = new Vector.<uint>();
            this.allianceRoundWeigth = new Vector.<uint>();
            this.allianceMatchScore = new Vector.<uint>();
            this.allianceMapWinner = new BasicAllianceInformations();
            this.allianceMapMyAllianceScore = 0;
            this.nextTickTime = 0;
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
            this.serializeAs_KohUpdateMessage(output);
        }

        public function serializeAs_KohUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.alliances.length);
            var _i1:uint;
            while (_i1 < this.alliances.length)
            {
                (this.alliances[_i1] as AllianceInformations).serializeAs_AllianceInformations(output);
                _i1++;
            };
            output.writeShort(this.allianceNbMembers.length);
            var _i2:uint;
            while (_i2 < this.allianceNbMembers.length)
            {
                if (this.allianceNbMembers[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceNbMembers[_i2]) + ") on element 2 (starting at 1) of allianceNbMembers.")));
                };
                output.writeVarShort(this.allianceNbMembers[_i2]);
                _i2++;
            };
            output.writeShort(this.allianceRoundWeigth.length);
            var _i3:uint;
            while (_i3 < this.allianceRoundWeigth.length)
            {
                if (this.allianceRoundWeigth[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceRoundWeigth[_i3]) + ") on element 3 (starting at 1) of allianceRoundWeigth.")));
                };
                output.writeVarInt(this.allianceRoundWeigth[_i3]);
                _i3++;
            };
            output.writeShort(this.allianceMatchScore.length);
            var _i4:uint;
            while (_i4 < this.allianceMatchScore.length)
            {
                if (this.allianceMatchScore[_i4] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.allianceMatchScore[_i4]) + ") on element 4 (starting at 1) of allianceMatchScore.")));
                };
                output.writeByte(this.allianceMatchScore[_i4]);
                _i4++;
            };
            this.allianceMapWinner.serializeAs_BasicAllianceInformations(output);
            if (this.allianceMapWinnerScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapWinnerScore) + ") on element allianceMapWinnerScore.")));
            };
            output.writeVarInt(this.allianceMapWinnerScore);
            if (this.allianceMapMyAllianceScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapMyAllianceScore) + ") on element allianceMapMyAllianceScore.")));
            };
            output.writeVarInt(this.allianceMapMyAllianceScore);
            if ((((this.nextTickTime < 0)) || ((this.nextTickTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.nextTickTime) + ") on element nextTickTime.")));
            };
            output.writeDouble(this.nextTickTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KohUpdateMessage(input);
        }

        public function deserializeAs_KohUpdateMessage(input:ICustomDataInput):void
        {
            var _item1:AllianceInformations;
            var _val2:uint;
            var _val3:uint;
            var _val4:uint;
            var _alliancesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _alliancesLen)
            {
                _item1 = new AllianceInformations();
                _item1.deserialize(input);
                this.alliances.push(_item1);
                _i1++;
            };
            var _allianceNbMembersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _allianceNbMembersLen)
            {
                _val2 = input.readVarUhShort();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of allianceNbMembers.")));
                };
                this.allianceNbMembers.push(_val2);
                _i2++;
            };
            var _allianceRoundWeigthLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _allianceRoundWeigthLen)
            {
                _val3 = input.readVarUhInt();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of allianceRoundWeigth.")));
                };
                this.allianceRoundWeigth.push(_val3);
                _i3++;
            };
            var _allianceMatchScoreLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _allianceMatchScoreLen)
            {
                _val4 = input.readByte();
                if (_val4 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of allianceMatchScore.")));
                };
                this.allianceMatchScore.push(_val4);
                _i4++;
            };
            this.allianceMapWinner = new BasicAllianceInformations();
            this.allianceMapWinner.deserialize(input);
            this.allianceMapWinnerScore = input.readVarUhInt();
            if (this.allianceMapWinnerScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapWinnerScore) + ") on element of KohUpdateMessage.allianceMapWinnerScore.")));
            };
            this.allianceMapMyAllianceScore = input.readVarUhInt();
            if (this.allianceMapMyAllianceScore < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceMapMyAllianceScore) + ") on element of KohUpdateMessage.allianceMapMyAllianceScore.")));
            };
            this.nextTickTime = input.readDouble();
            if ((((this.nextTickTime < 0)) || ((this.nextTickTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.nextTickTime) + ") on element of KohUpdateMessage.nextTickTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

