package com.ankamagames.dofus.network.types.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BasicGuildInformations extends Object implements INetworkType
    {
        public var guildId:uint = 0;
        public var guildName:String = "";
        public static const protocolId:uint = 365;

        public function BasicGuildInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 365;
        }// end function

        public function initBasicGuildInformations(param1:uint = 0, param2:String = "") : BasicGuildInformations
        {
            this.guildId = param1;
            this.guildName = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.guildId = 0;
            this.guildName = "";
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_BasicGuildInformations(param1);
            return;
        }// end function

        public function serializeAs_BasicGuildInformations(param1:IDataOutput) : void
        {
            if (this.guildId < 0)
            {
                throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
            }
            param1.writeInt(this.guildId);
            param1.writeUTF(this.guildName);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicGuildInformations(param1);
            return;
        }// end function

        public function deserializeAs_BasicGuildInformations(param1:IDataInput) : void
        {
            this.guildId = param1.readInt();
            if (this.guildId < 0)
            {
                throw new Error("Forbidden value (" + this.guildId + ") on element of BasicGuildInformations.guildId.");
            }
            this.guildName = param1.readUTF();
            return;
        }// end function

    }
}
