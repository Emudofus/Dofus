package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    public class List 
    {

        public var value:Object;
        public var next:List;

        public function List(pValue:Object, pNext:List=null)
        {
            this.value = pValue;
            this.next = pNext;
        }

    }
}//package com.ankamagames.jerakine.utils.benchmark.monitoring

