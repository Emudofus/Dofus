package com.ankamagames.jerakine.utils.memory
{
   import flash.utils.Dictionary;
   
   public class WeakReference extends Object
   {
      
      public function WeakReference(param1:*) {
         super();
         this.dictionary = new Dictionary(true);
         this.dictionary[param1] = null;
      }
      
      private var dictionary:Dictionary;
      
      public function get object() : * {
         var _loc1_:* = undefined;
         for (_loc1_ in this.dictionary)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function destroy() : void {
         this.dictionary = null;
      }
   }
}
