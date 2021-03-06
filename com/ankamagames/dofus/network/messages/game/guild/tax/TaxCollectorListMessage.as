﻿package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
    import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class TaxCollectorListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5930;

        private var _isInitialized:Boolean = false;
        public var nbcollectorMax:uint = 0;
        public var informations:Vector.<TaxCollectorInformations>;
        public var fightersInformations:Vector.<TaxCollectorFightersInformation>;

        public function TaxCollectorListMessage()
        {
            this.informations = new Vector.<TaxCollectorInformations>();
            this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5930);
        }

        public function initTaxCollectorListMessage(nbcollectorMax:uint=0, informations:Vector.<TaxCollectorInformations>=null, fightersInformations:Vector.<TaxCollectorFightersInformation>=null):TaxCollectorListMessage
        {
            this.nbcollectorMax = nbcollectorMax;
            this.informations = informations;
            this.fightersInformations = fightersInformations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.nbcollectorMax = 0;
            this.informations = new Vector.<TaxCollectorInformations>();
            this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
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
            this.serializeAs_TaxCollectorListMessage(output);
        }

        public function serializeAs_TaxCollectorListMessage(output:ICustomDataOutput):void
        {
            if (this.nbcollectorMax < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbcollectorMax) + ") on element nbcollectorMax.")));
            };
            output.writeByte(this.nbcollectorMax);
            output.writeShort(this.informations.length);
            var _i2:uint;
            while (_i2 < this.informations.length)
            {
                output.writeShort((this.informations[_i2] as TaxCollectorInformations).getTypeId());
                (this.informations[_i2] as TaxCollectorInformations).serialize(output);
                _i2++;
            };
            output.writeShort(this.fightersInformations.length);
            var _i3:uint;
            while (_i3 < this.fightersInformations.length)
            {
                (this.fightersInformations[_i3] as TaxCollectorFightersInformation).serializeAs_TaxCollectorFightersInformation(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorListMessage(input);
        }

        public function deserializeAs_TaxCollectorListMessage(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:TaxCollectorInformations;
            var _item3:TaxCollectorFightersInformation;
            this.nbcollectorMax = input.readByte();
            if (this.nbcollectorMax < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbcollectorMax) + ") on element of TaxCollectorListMessage.nbcollectorMax.")));
            };
            var _informationsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _informationsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(TaxCollectorInformations, _id2);
                _item2.deserialize(input);
                this.informations.push(_item2);
                _i2++;
            };
            var _fightersInformationsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _fightersInformationsLen)
            {
                _item3 = new TaxCollectorFightersInformation();
                _item3.deserialize(input);
                this.fightersInformations.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild.tax

