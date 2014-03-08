package cmodule.lua_wrapper
{
   class CHeapAllocator extends Object implements ICAllocator
   {
      
      function CHeapAllocator() {
         super();
      }
      
      public function free(param1:int) : void {
         if(this.pfree == null)
         {
            this.pfree = new CProcTypemap(CHeapAllocator.VoidType,[CHeapAllocator.PtrType]).fromC([CHeapAllocator]);
         }
         this.pfree(param1);
      }
      
      public function alloc(param1:int) : int {
         var _loc2_:* = 0;
         if(this.pmalloc == null)
         {
            this.pmalloc = new CProcTypemap(CHeapAllocator.PtrType,[CHeapAllocator.IntType]).fromC([CHeapAllocator]);
         }
         _loc2_ = this.pmalloc(param1);
         return _loc2_;
      }
      
      private var pmalloc:Function;
      
      private var pfree:Function;
   }
}
