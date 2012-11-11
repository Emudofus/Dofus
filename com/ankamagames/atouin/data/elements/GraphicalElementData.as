package com.ankamagames.atouin.data.elements
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class GraphicalElementData extends Object
    {
        public var id:int;
        public var type:int;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicalElementData));

        public function GraphicalElementData(param1:int, param2:int)
        {
            this.id = param1;
            this.type = param2;
            return;
        }// end function

        public function fromRaw(param1:IDataInput, param2:int) : void
        {
            throw new AbstractMethodCallError();
        }// end function

    }
}
