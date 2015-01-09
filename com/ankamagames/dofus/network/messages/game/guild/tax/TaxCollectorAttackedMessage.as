package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TaxCollectorAttackedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5918;

        private var _isInitialized:Boolean = false;
        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var guild:BasicGuildInformations;

        public function TaxCollectorAttackedMessage()
        {
            this.guild = new BasicGuildInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5918);
        }

        public function initTaxCollectorAttackedMessage(firstNameId:uint=0, lastNameId:uint=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, guild:BasicGuildInformations=null):TaxCollectorAttackedMessage
        {
            this.firstNameId = firstNameId;
            this.lastNameId = lastNameId;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            this.guild = guild;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.guild = new BasicGuildInformations();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_TaxCollectorAttackedMessage(output);
        }

        public function serializeAs_TaxCollectorAttackedMessage(output:IDataOutput):void
        {
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element firstNameId.")));
            };
            output.writeShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element lastNameId.")));
            };
            output.writeShort(this.lastNameId);
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
            output.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
            this.guild.serializeAs_BasicGuildInformations(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TaxCollectorAttackedMessage(input);
        }

        public function deserializeAs_TaxCollectorAttackedMessage(input:IDataInput):void
        {
            this.firstNameId = input.readShort();
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element of TaxCollectorAttackedMessage.firstNameId.")));
            };
            this.lastNameId = input.readShort();
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element of TaxCollectorAttackedMessage.lastNameId.")));
            };
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of TaxCollectorAttackedMessage.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of TaxCollectorAttackedMessage.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of TaxCollectorAttackedMessage.subAreaId.")));
            };
            this.guild = new BasicGuildInformations();
            this.guild.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

