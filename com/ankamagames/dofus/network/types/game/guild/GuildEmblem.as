package com.ankamagames.dofus.network.types.game.guild
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class GuildEmblem implements INetworkType 
    {

        public static const protocolId:uint = 87;

        public var symbolShape:uint = 0;
        public var symbolColor:int = 0;
        public var backgroundShape:uint = 0;
        public var backgroundColor:int = 0;


        public function getTypeId():uint
        {
            return (87);
        }

        public function initGuildEmblem(symbolShape:uint=0, symbolColor:int=0, backgroundShape:uint=0, backgroundColor:int=0):GuildEmblem
        {
            this.symbolShape = symbolShape;
            this.symbolColor = symbolColor;
            this.backgroundShape = backgroundShape;
            this.backgroundColor = backgroundColor;
            return (this);
        }

        public function reset():void
        {
            this.symbolShape = 0;
            this.symbolColor = 0;
            this.backgroundShape = 0;
            this.backgroundColor = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildEmblem(output);
        }

        public function serializeAs_GuildEmblem(output:ICustomDataOutput):void
        {
            if (this.symbolShape < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbolShape) + ") on element symbolShape.")));
            };
            output.writeVarShort(this.symbolShape);
            output.writeInt(this.symbolColor);
            if (this.backgroundShape < 0)
            {
                throw (new Error((("Forbidden value (" + this.backgroundShape) + ") on element backgroundShape.")));
            };
            output.writeByte(this.backgroundShape);
            output.writeInt(this.backgroundColor);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildEmblem(input);
        }

        public function deserializeAs_GuildEmblem(input:ICustomDataInput):void
        {
            this.symbolShape = input.readVarUhShort();
            if (this.symbolShape < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbolShape) + ") on element of GuildEmblem.symbolShape.")));
            };
            this.symbolColor = input.readInt();
            this.backgroundShape = input.readByte();
            if (this.backgroundShape < 0)
            {
                throw (new Error((("Forbidden value (" + this.backgroundShape) + ") on element of GuildEmblem.backgroundShape.")));
            };
            this.backgroundColor = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild

