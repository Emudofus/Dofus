package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceModificationNameAndTagValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6449;

        private var _isInitialized:Boolean = false;
        public var allianceName:String = "";
        public var allianceTag:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6449);
        }

        public function initAllianceModificationNameAndTagValidMessage(allianceName:String="", allianceTag:String=""):AllianceModificationNameAndTagValidMessage
        {
            this.allianceName = allianceName;
            this.allianceTag = allianceTag;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.allianceName = "";
            this.allianceTag = "";
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
            this.serializeAs_AllianceModificationNameAndTagValidMessage(output);
        }

        public function serializeAs_AllianceModificationNameAndTagValidMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.allianceName);
            output.writeUTF(this.allianceTag);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceModificationNameAndTagValidMessage(input);
        }

        public function deserializeAs_AllianceModificationNameAndTagValidMessage(input:ICustomDataInput):void
        {
            this.allianceName = input.readUTF();
            this.allianceTag = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

