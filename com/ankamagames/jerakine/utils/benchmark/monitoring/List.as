package com.ankamagames.jerakine.utils.benchmark.monitoring
{

    public class List extends Object
    {
        public var value:Object;
        public var next:List;

        public function List(param1:Object, param2:List = null)
        {
            this.value = param1;
            this.next = param2;
            return;
        }// end function

    }
}
