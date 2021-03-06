﻿package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ZaapListMessage extends TeleportDestinationsListMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1604;

        private var _isInitialized:Boolean = false;
        public var spawnMapId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (1604);
        }

        public function initZaapListMessage(teleporterType:uint=0, mapIds:Vector.<uint>=null, subAreaIds:Vector.<uint>=null, costs:Vector.<uint>=null, destTeleporterType:Vector.<uint>=null, spawnMapId:uint=0):ZaapListMessage
        {
            super.initTeleportDestinationsListMessage(teleporterType, mapIds, subAreaIds, costs, destTeleporterType);
            this.spawnMapId = spawnMapId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.spawnMapId = 0;
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
            this.serializeAs_ZaapListMessage(output);
        }

        public function serializeAs_ZaapListMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_TeleportDestinationsListMessage(output);
            if (this.spawnMapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spawnMapId) + ") on element spawnMapId.")));
            };
            output.writeInt(this.spawnMapId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ZaapListMessage(input);
        }

        public function deserializeAs_ZaapListMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.spawnMapId = input.readInt();
            if (this.spawnMapId < 0)
            {
                throw (new Error((("Forbidden value (" + this.spawnMapId) + ") on element of ZaapListMessage.spawnMapId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.zaap

