package com.ankamagames.dofus.network.types.web.krosmaster
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class KrosmasterFigure implements INetworkType 
    {

        public static const protocolId:uint = 397;

        public var uid:String = "";
        public var figure:uint = 0;
        public var pedestal:uint = 0;
        public var bound:Boolean = false;


        public function getTypeId():uint
        {
            return (397);
        }

        public function initKrosmasterFigure(uid:String="", figure:uint=0, pedestal:uint=0, bound:Boolean=false):KrosmasterFigure
        {
            this.uid = uid;
            this.figure = figure;
            this.pedestal = pedestal;
            this.bound = bound;
            return (this);
        }

        public function reset():void
        {
            this.uid = "";
            this.figure = 0;
            this.pedestal = 0;
            this.bound = false;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_KrosmasterFigure(output);
        }

        public function serializeAs_KrosmasterFigure(output:ICustomDataOutput):void
        {
            output.writeUTF(this.uid);
            if (this.figure < 0)
            {
                throw (new Error((("Forbidden value (" + this.figure) + ") on element figure.")));
            };
            output.writeVarShort(this.figure);
            if (this.pedestal < 0)
            {
                throw (new Error((("Forbidden value (" + this.pedestal) + ") on element pedestal.")));
            };
            output.writeVarShort(this.pedestal);
            output.writeBoolean(this.bound);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KrosmasterFigure(input);
        }

        public function deserializeAs_KrosmasterFigure(input:ICustomDataInput):void
        {
            this.uid = input.readUTF();
            this.figure = input.readVarUhShort();
            if (this.figure < 0)
            {
                throw (new Error((("Forbidden value (" + this.figure) + ") on element of KrosmasterFigure.figure.")));
            };
            this.pedestal = input.readVarUhShort();
            if (this.pedestal < 0)
            {
                throw (new Error((("Forbidden value (" + this.pedestal) + ") on element of KrosmasterFigure.pedestal.")));
            };
            this.bound = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.web.krosmaster

