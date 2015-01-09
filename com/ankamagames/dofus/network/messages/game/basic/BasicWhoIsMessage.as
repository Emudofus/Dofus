package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class BasicWhoIsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 180;

        private var _isInitialized:Boolean = false;
        public var self:Boolean = false;
        public var position:int = -1;
        public var accountNickname:String = "";
        public var accountId:uint = 0;
        public var playerName:String = "";
        public var playerId:uint = 0;
        public var areaId:int = 0;
        public var socialGroups:Vector.<AbstractSocialGroupInfos>;
        public var verbose:Boolean = false;
        public var playerState:uint = 99;

        public function BasicWhoIsMessage()
        {
            this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (180);
        }

        public function initBasicWhoIsMessage(self:Boolean=false, position:int=-1, accountNickname:String="", accountId:uint=0, playerName:String="", playerId:uint=0, areaId:int=0, socialGroups:Vector.<AbstractSocialGroupInfos>=null, verbose:Boolean=false, playerState:uint=99):BasicWhoIsMessage
        {
            this.self = self;
            this.position = position;
            this.accountNickname = accountNickname;
            this.accountId = accountId;
            this.playerName = playerName;
            this.playerId = playerId;
            this.areaId = areaId;
            this.socialGroups = socialGroups;
            this.verbose = verbose;
            this.playerState = playerState;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.self = false;
            this.position = -1;
            this.accountNickname = "";
            this.accountId = 0;
            this.playerName = "";
            this.playerId = 0;
            this.areaId = 0;
            this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
            this.verbose = false;
            this.playerState = 99;
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
            this.serializeAs_BasicWhoIsMessage(output);
        }

        public function serializeAs_BasicWhoIsMessage(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.self);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.verbose);
            output.writeByte(_box0);
            output.writeByte(this.position);
            output.writeUTF(this.accountNickname);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            output.writeUTF(this.playerName);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeShort(this.areaId);
            output.writeShort(this.socialGroups.length);
            var _i8:uint;
            while (_i8 < this.socialGroups.length)
            {
                output.writeShort((this.socialGroups[_i8] as AbstractSocialGroupInfos).getTypeId());
                (this.socialGroups[_i8] as AbstractSocialGroupInfos).serialize(output);
                _i8++;
            };
            output.writeByte(this.playerState);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicWhoIsMessage(input);
        }

        public function deserializeAs_BasicWhoIsMessage(input:ICustomDataInput):void
        {
            var _id8:uint;
            var _item8:AbstractSocialGroupInfos;
            var _box0:uint = input.readByte();
            this.self = BooleanByteWrapper.getFlag(_box0, 0);
            this.verbose = BooleanByteWrapper.getFlag(_box0, 1);
            this.position = input.readByte();
            this.accountNickname = input.readUTF();
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of BasicWhoIsMessage.accountId.")));
            };
            this.playerName = input.readUTF();
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of BasicWhoIsMessage.playerId.")));
            };
            this.areaId = input.readShort();
            var _socialGroupsLen:uint = input.readUnsignedShort();
            var _i8:uint;
            while (_i8 < _socialGroupsLen)
            {
                _id8 = input.readUnsignedShort();
                _item8 = ProtocolTypeManager.getInstance(AbstractSocialGroupInfos, _id8);
                _item8.deserialize(input);
                this.socialGroups.push(_item8);
                _i8++;
            };
            this.playerState = input.readByte();
            if (this.playerState < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerState) + ") on element of BasicWhoIsMessage.playerState.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

