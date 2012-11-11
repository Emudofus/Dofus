package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.types.*;

    public class ChunkData extends Object
    {
        public var name:String;
        public var uri:Uri;

        public function ChunkData(param1:String, param2:Uri)
        {
            this.name = param1;
            this.uri = param2;
            return;
        }// end function

    }
}
