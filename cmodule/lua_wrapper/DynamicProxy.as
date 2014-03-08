package cmodule.lua_wrapper
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_delegate;
   use namespace flash_proxy;
   
   public dynamic class DynamicProxy extends Proxy
   {
      
      public function DynamicProxy() {
         super();
      }
      
      flash_delegate var nextValue:Function;
      
      flash_delegate var getProperty:Function;
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return this.hasProperty(param1);
      }
      
      flash_delegate var isAttribute:Function;
      
      override flash_proxy function callProperty(param1:*, ... rest) : * {
         return this.callProperty(param1,rest);
      }
      
      flash_delegate var nextNameIndex:Function;
      
      flash_delegate var hasProperty:Function;
      
      override flash_proxy function setProperty(param1:*, param2:*) : void {
         this.setProperty(param1,param2);
      }
      
      override flash_proxy function isAttribute(param1:*) : Boolean {
         return this.isAttribute(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         return this.getProperty(param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int {
         return this.nextNameIndex(param1);
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean {
         return this.deleteProperty(param1);
      }
      
      flash_delegate var callProperty:Function;
      
      override flash_proxy function nextName(param1:int) : String {
         return this.nextName(param1);
      }
      
      override flash_proxy function getDescendants(param1:*) : * {
         return this.getDescendants(param1);
      }
      
      flash_delegate var nextName:Function;
      
      flash_delegate var getDescendants:Function;
      
      flash_delegate var deleteProperty:Function;
      
      flash_delegate var setProperty:Function;
      
      override flash_proxy function nextValue(param1:int) : * {
         return this.nextValue(param1);
      }
   }
}
