package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class RemodelingInformation implements INetworkType 
    {

        public static const protocolId:uint = 480;

        public var name:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var cosmeticId:uint = 0;
        public var colors:Vector.<int>;

        public function RemodelingInformation()
        {
            this.colors = new Vector.<int>();
            super();
        }

        public function getTypeId():uint
        {
            return (480);
        }

        public function initRemodelingInformation(name:String="", breed:int=0, sex:Boolean=false, cosmeticId:uint=0, colors:Vector.<int>=null):RemodelingInformation
        {
            this.name = name;
            this.breed = breed;
            this.sex = sex;
            this.cosmeticId = cosmeticId;
            this.colors = colors;
            return (this);
        }

        public function reset():void
        {
            this.name = "";
            this.breed = 0;
            this.sex = false;
            this.cosmeticId = 0;
            this.colors = new Vector.<int>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_RemodelingInformation(output);
        }

        public function serializeAs_RemodelingInformation(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            if (this.cosmeticId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cosmeticId) + ") on element cosmeticId.")));
            };
            output.writeVarShort(this.cosmeticId);
            output.writeShort(this.colors.length);
            var _i5:uint;
            while (_i5 < this.colors.length)
            {
                output.writeInt(this.colors[_i5]);
                _i5++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_RemodelingInformation(input);
        }

        public function deserializeAs_RemodelingInformation(input:ICustomDataInput):void
        {
            var _val5:int;
            this.name = input.readUTF();
            this.breed = input.readByte();
            this.sex = input.readBoolean();
            this.cosmeticId = input.readVarUhShort();
            if (this.cosmeticId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cosmeticId) + ") on element of RemodelingInformation.cosmeticId.")));
            };
            var _colorsLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _colorsLen)
            {
                _val5 = input.readInt();
                this.colors.push(_val5);
                _i5++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

