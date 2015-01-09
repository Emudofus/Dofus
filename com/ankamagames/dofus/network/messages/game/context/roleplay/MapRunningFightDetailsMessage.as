package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterLightInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class MapRunningFightDetailsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5751;

        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var attackers:Vector.<GameFightFighterLightInformations>;
        public var defenders:Vector.<GameFightFighterLightInformations>;

        public function MapRunningFightDetailsMessage()
        {
            this.attackers = new Vector.<GameFightFighterLightInformations>();
            this.defenders = new Vector.<GameFightFighterLightInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5751);
        }

        public function initMapRunningFightDetailsMessage(fightId:uint=0, attackers:Vector.<GameFightFighterLightInformations>=null, defenders:Vector.<GameFightFighterLightInformations>=null):MapRunningFightDetailsMessage
        {
            this.fightId = fightId;
            this.attackers = attackers;
            this.defenders = defenders;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.attackers = new Vector.<GameFightFighterLightInformations>();
            this.defenders = new Vector.<GameFightFighterLightInformations>();
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
            this.serializeAs_MapRunningFightDetailsMessage(output);
        }

        public function serializeAs_MapRunningFightDetailsMessage(output:ICustomDataOutput):void
        {
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element fightId.")));
            };
            output.writeInt(this.fightId);
            output.writeShort(this.attackers.length);
            var _i2:uint;
            while (_i2 < this.attackers.length)
            {
                output.writeShort((this.attackers[_i2] as GameFightFighterLightInformations).getTypeId());
                (this.attackers[_i2] as GameFightFighterLightInformations).serialize(output);
                _i2++;
            };
            output.writeShort(this.defenders.length);
            var _i3:uint;
            while (_i3 < this.defenders.length)
            {
                output.writeShort((this.defenders[_i3] as GameFightFighterLightInformations).getTypeId());
                (this.defenders[_i3] as GameFightFighterLightInformations).serialize(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapRunningFightDetailsMessage(input);
        }

        public function deserializeAs_MapRunningFightDetailsMessage(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:GameFightFighterLightInformations;
            var _id3:uint;
            var _item3:GameFightFighterLightInformations;
            this.fightId = input.readInt();
            if (this.fightId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightId) + ") on element of MapRunningFightDetailsMessage.fightId.")));
            };
            var _attackersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _attackersLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations, _id2);
                _item2.deserialize(input);
                this.attackers.push(_item2);
                _i2++;
            };
            var _defendersLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _defendersLen)
            {
                _id3 = input.readUnsignedShort();
                _item3 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations, _id3);
                _item3.deserialize(input);
                this.defenders.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

