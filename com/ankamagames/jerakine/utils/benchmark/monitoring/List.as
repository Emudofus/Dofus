package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   public class List extends Object
   {
      
      public function List(pValue:Object, pNext:List=null) {
         super();
         this.value = pValue;
         this.next = pNext;
      }
      
      public var value:Object;
      
      public var next:List;
   }
}
