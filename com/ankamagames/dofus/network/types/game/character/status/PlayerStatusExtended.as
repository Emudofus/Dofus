package com.ankamagames.dofus.network.types.game.character.status
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PlayerStatusExtended extends PlayerStatus implements INetworkType 
    {

        public static const protocolId:uint = 414;

        public var message:String = "";


        override public function getTypeId():uint
        {
            return (414);
        }

        public function initPlayerStatusExtended(statusId:uint=1, message:String=""):PlayerStatusExtended
        {
            super.initPlayerStatus(statusId);
            this.message = message;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.message = "";
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PlayerStatusExtended(output);
        }

        public function serializeAs_PlayerStatusExtended(output:ICustomDataOutput):void
        {
            super.serializeAs_PlayerStatus(output);
            output.writeUTF(this.message);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PlayerStatusExtended(input);
        }

        public function deserializeAs_PlayerStatusExtended(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.message = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.status

