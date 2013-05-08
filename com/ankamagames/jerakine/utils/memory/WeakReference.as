package com.ankamagames.jerakine.utils.memory
{
   import flash.utils.Dictionary;


   public class WeakReference extends Object
   {
         

      public function WeakReference(obj:*) {
         super();
         this.dictionary=new Dictionary(true);
         this.dictionary[obj]=null;
      }



      private var dictionary:Dictionary;

      public function get object() : * {
         var n:* = undefined;
         if(!(this.dictionary hasNext _loc2_))
         {
            return null;
         }
         n=nextName(_loc2_,_loc3_);
         return n;
      }

      public function destroy() : void {
         this.dictionary=null;
      }
   }

}