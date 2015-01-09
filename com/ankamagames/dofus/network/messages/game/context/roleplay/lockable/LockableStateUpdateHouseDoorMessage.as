package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class LockableStateUpdateHouseDoorMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5668;

        private var _isInitialized:Boolean = false;
        public var houseId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5668);
        }

        public function initLockableStateUpdateHouseDoorMessage(locked:Boolean=false, houseId:int=0):LockableStateUpdateHouseDoorMessage
        {
            super.initLockableStateUpdateAbstractMessage(locked);
            this.houseId = houseId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.houseId = 0;
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
            this.serializeAs_LockableStateUpdateHouseDoorMessage(output);
        }

        public function serializeAs_LockableStateUpdateHouseDoorMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_LockableStateUpdateAbstractMessage(output);
            output.writeInt(this.houseId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_LockableStateUpdateHouseDoorMessage(input);
        }

        public function deserializeAs_LockableStateUpdateHouseDoorMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.houseId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable

