package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.interfaces.ISecurizable;
   import com.ankamagames.berilia.api.ReadOnlyObject;
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.interfaces.INoBoxing;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SecureCenter extends Object
   {
      
      public function SecureCenter() {
         super();
      }
      
      protected static var SharedSecureComponent:Class;
      
      protected static var SharedReadOnlyData:Class;
      
      protected static var DirectAccessObject:Class;
      
      public static const ACCESS_KEY:Object = new Object();
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SecureCenter));
      
      public static function init(param1:Object, param2:Object, param3:Object) : void {
         SharedSecureComponent = param1 as Class;
         SharedReadOnlyData = param2 as Class;
         DirectAccessObject = param3 as Class;
      }
      
      public static function destroy(param1:*) : void {
         switch(true)
         {
            case param1 is SharedSecureComponent:
               SharedSecureComponent["destroy"](param1,ACCESS_KEY);
               break;
         }
      }
      
      public static function secure(param1:*, param2:Boolean=false) : * {
         var iDataCenter:* = undefined;
         var iModuleUtil:* = undefined;
         var target:* = param1;
         var trusted:Boolean = param2;
         switch(true)
         {
            case target == null:
            case target is uint:
            case target is int:
            case target is Number:
            case target is String:
            case target is Boolean:
            case target == undefined:
            case target is Secure:
               return target;
         }
      }
      
      public static function secureContent(param1:Array, param2:Boolean=false) : Array {
         var _loc4_:* = undefined;
         var _loc3_:Array = [];
         for (_loc4_ in param1)
         {
            _loc3_[_loc4_] = secure(param1[_loc4_],param2);
         }
         return _loc3_;
      }
      
      public static function unsecure(param1:*) : * {
         var target:* = param1;
         switch(null)
         {
            case target is Secure && !(target is INoBoxing):
            case target is SharedSecureComponent:
            case target is SharedReadOnlyData:
            case target is DirectAccessObject:
               return target.getObject(ACCESS_KEY);
            case target is Function:
               return function(... rest):*
               {
                  var _loc2_:* = rest.length;
                  var _loc3_:* = 0;
                  while(_loc3_ < _loc2_)
                  {
                     rest[_loc3_] = secure(rest[_loc3_]);
                     _loc3_++;
                  }
                  var _loc4_:* = CallWithParameters.callR(target,rest);
                  return unsecure(_loc4_);
               };
            default:
               return target;
         }
      }
      
      public static function unsecureContent(param1:Array) : Array {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for (_loc3_ in param1)
         {
            _loc2_[_loc3_] = unsecure(param1[_loc3_]);
         }
         return _loc2_;
      }
      
      public static function checkAccessKey(param1:Object) : void {
         if(param1 != ACCESS_KEY)
         {
            throw new IllegalOperationError("Wrong access key");
         }
         else
         {
            return;
         }
      }
   }
}
