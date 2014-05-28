package com.ankamagames.jerakine.utils.memory
{
   import flash.utils.Proxy;
   import flash.utils.Dictionary;
   import flash.utils.flash_proxy;
   
   public dynamic class WeakProxyReference extends Proxy
   {
      
      public function WeakProxyReference(p_object:Object) {
         super();
         this.dictionary = new Dictionary(true);
         this.dictionary[p_object] = null;
      }
      
      protected var dictionary:Dictionary;
      
      public function get object() : Object {
         var n:Object = null;
         for(n in this.dictionary)
         {
            return n;
         }
         return null;
      }
      
      private function getObject() : Object {
         var n:Object = null;
         for(n in this.dictionary)
         {
            return n;
         }
         throw new ReferenceError("Reference Error: Object is no longer available through WeakProxyReference, it may have been removed from memory.");
      }
      
      override flash_proxy function callProperty(p_methodName:*, ... p_args) : * {
         var funct:* = this.getObject()[p_methodName];
         if(!(funct is Function))
         {
            throw new TypeError("TypeError: Cannot call " + p_methodName.toString() + " through WeakProxyReference, it is not a function.");
         }
         else
         {
            return funct.apply(null,p_args);
         }
      }
      
      override flash_proxy function getProperty(p_propertyName:*) : * {
         return this.getObject()[p_propertyName];
      }
      
      override flash_proxy function setProperty(p_propertyName:*, p_value:*) : void {
         this.getObject()[p_propertyName] = p_value;
      }
      
      override flash_proxy function deleteProperty(p_propertyName:*) : Boolean {
         delete this.getObject()[p_propertyName];
         return true;
      }
   }
}
