package com.ankamagames.dofus.network.types.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildEmblem extends Object implements INetworkType
    {
        public var symbolShape:int = 0;
        public var symbolColor:int = 0;
        public var backgroundShape:int = 0;
        public var backgroundColor:int = 0;
        public static const protocolId:uint = 87;

        public function GuildEmblem()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 87;
        }// end function

        public function initGuildEmblem(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : GuildEmblem
        {
            this.symbolShape = param1;
            this.symbolColor = param2;
            this.backgroundShape = param3;
            this.backgroundColor = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.symbolShape = 0;
            this.symbolColor = 0;
            this.backgroundShape = 0;
            this.backgroundColor = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GuildEmblem(param1);
            return;
        }// end function

        public function serializeAs_GuildEmblem(param1:IDataOutput) : void
        {
            param1.writeShort(this.symbolShape);
            param1.writeInt(this.symbolColor);
            param1.writeShort(this.backgroundShape);
            param1.writeInt(this.backgroundColor);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildEmblem(param1);
            return;
        }// end function

        public function deserializeAs_GuildEmblem(param1:IDataInput) : void
        {
            this.symbolShape = param1.readShort();
            this.symbolColor = param1.readInt();
            this.backgroundShape = param1.readShort();
            this.backgroundColor = param1.readInt();
            return;
        }// end function

    }
}
