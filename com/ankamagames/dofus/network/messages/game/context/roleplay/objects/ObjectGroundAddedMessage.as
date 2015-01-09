package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectGroundAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3017;

        private var _isInitialized:Boolean = false;
        public var cellId:uint = 0;
        public var objectGID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (3017);
        }

        public function initObjectGroundAddedMessage(cellId:uint=0, objectGID:uint=0):ObjectGroundAddedMessage
        {
            this.cellId = cellId;
            this.objectGID = objectGID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cellId = 0;
            this.objectGID = 0;
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
            this.serializeAs_ObjectGroundAddedMessage(output);
        }

        public function serializeAs_ObjectGroundAddedMessage(output:ICustomDataOutput):void
        {
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeVarShort(this.cellId);
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectGroundAddedMessage(input);
        }

        public function deserializeAs_ObjectGroundAddedMessage(input:ICustomDataInput):void
        {
            this.cellId = input.readVarUhShort();
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of ObjectGroundAddedMessage.cellId.")));
            };
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ObjectGroundAddedMessage.objectGID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.objects

