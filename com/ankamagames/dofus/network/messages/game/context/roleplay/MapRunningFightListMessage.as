﻿package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class MapRunningFightListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5743;

        private var _isInitialized:Boolean = false;
        public var fights:Vector.<FightExternalInformations>;

        public function MapRunningFightListMessage()
        {
            this.fights = new Vector.<FightExternalInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5743);
        }

        public function initMapRunningFightListMessage(fights:Vector.<FightExternalInformations>=null):MapRunningFightListMessage
        {
            this.fights = fights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fights = new Vector.<FightExternalInformations>();
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
            this.serializeAs_MapRunningFightListMessage(output);
        }

        public function serializeAs_MapRunningFightListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.fights.length);
            var _i1:uint;
            while (_i1 < this.fights.length)
            {
                (this.fights[_i1] as FightExternalInformations).serializeAs_FightExternalInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapRunningFightListMessage(input);
        }

        public function deserializeAs_MapRunningFightListMessage(input:ICustomDataInput):void
        {
            var _item1:FightExternalInformations;
            var _fightsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _fightsLen)
            {
                _item1 = new FightExternalInformations();
                _item1.deserialize(input);
                this.fights.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

