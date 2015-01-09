package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ActorOrientation implements INetworkType 
    {

        public static const protocolId:uint = 353;

        public var id:int = 0;
        public var direction:uint = 1;


        public function getTypeId():uint
        {
            return (353);
        }

        public function initActorOrientation(id:int=0, direction:uint=1):ActorOrientation
        {
            this.id = id;
            this.direction = direction;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.direction = 1;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ActorOrientation(output);
        }

        public function serializeAs_ActorOrientation(output:ICustomDataOutput):void
        {
            output.writeInt(this.id);
            output.writeByte(this.direction);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ActorOrientation(input);
        }

        public function deserializeAs_ActorOrientation(input:ICustomDataInput):void
        {
            this.id = input.readInt();
            this.direction = input.readByte();
            if (this.direction < 0)
            {
                throw (new Error((("Forbidden value (" + this.direction) + ") on element of ActorOrientation.direction.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

