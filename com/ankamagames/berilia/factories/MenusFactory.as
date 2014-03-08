package com.ankamagames.berilia.factories
{
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.managers.SecureCenter;
   
   public class MenusFactory extends Object
   {
      
      public function MenusFactory() {
         super();
      }
      
      private static var _registeredMaker:Array = new Array();
      
      private static var _makerAssoc:Array = new Array();
      
      public static function registerMaker(param1:String, param2:Class, param3:Class=null) : void {
         _registeredMaker[param1] = new MenuData(param2,param3);
      }
      
      public static function registerAssoc(param1:*, param2:String) : void {
         _makerAssoc[getQualifiedClassName(param1)] = param2;
      }
      
      public static function unregister(param1:Class, param2:Class) : void {
         if(MenuData(_registeredMaker[getQualifiedClassName(param1)]).maker === param2)
         {
            delete _registeredMaker[[getQualifiedClassName(param1)]];
         }
      }
      
      public static function create(param1:*, param2:String=null, param3:Object=null) : ContextMenuData {
         var _loc4_:MenuData = null;
         var _loc5_:* = undefined;
         var _loc6_:Array = null;
         if(!param2)
         {
            param2 = _makerAssoc[getQualifiedClassName(param1)];
         }
         if(param2)
         {
            _loc4_ = _registeredMaker[param2];
         }
         if(_loc4_)
         {
            _loc5_ = new _loc4_.maker();
            _loc6_ = _loc5_.createMenu(SecureCenter.secure(param1),SecureCenter.secure(param3));
            return new ContextMenuData(param1,param2,_loc6_);
         }
         if(param3 is Array)
         {
            return new ContextMenuData(param1,param2,param3 as Array);
         }
         return null;
      }
      
      public static function getMenuMaker(param1:String) : Object {
         return _registeredMaker[param1];
      }
      
      public static function existMakerAssoc(param1:*) : Boolean {
         return _makerAssoc[getQualifiedClassName(param1)]?true:false;
      }
   }
}
class MenuData extends Object
{
   
   function MenuData(param1:Class, param2:Class) {
      super();
      this.maker = param1;
      this.scriptClass = param2;
   }
   
   public var maker:Class;
   
   public var scriptClass:Class;
}
