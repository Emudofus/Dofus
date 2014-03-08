package com.ankamagames.berilia.api
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   
   use namespace flash_proxy;
   
   public class ModuleReference extends Proxy implements Secure
   {
      
      public function ModuleReference(param1:Object, param2:Object) {
         super();
         SecureCenter.checkAccessKey(param2);
         this._object = new WeakReference(param1);
      }
      
      private var _object:WeakReference;
      
      public function getObject(param1:Object) : * {
         if(param1 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            return this._object.object;
         }
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : * {
         var _loc3_:* = this._object.object[param1].apply(this,rest);
         this.verify(_loc3_);
         return _loc3_;
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         var _loc2_:* = this._object.object[param1];
         if(_loc2_ is Function)
         {
            return _loc2_;
         }
         throw new IllegalOperationError("You cannot access to property. You have access only to functions");
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void {
         throw new IllegalOperationError("You cannot access to property. You have access only to functions");
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return this._object.object.hasOwnProperty(param1);
      }
      
      private function verify(param1:*) : void {
         var _loc2_:String = getQualifiedClassName(param1);
         if(_loc2_.indexOf("d2api") == 0)
         {
            throw new IllegalOperationError("You cannot get API from an other module");
         }
         else
         {
            return;
         }
      }
   }
}
