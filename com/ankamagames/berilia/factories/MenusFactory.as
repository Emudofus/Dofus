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
      
      private static var _registeredMaker:Array;
      
      private static var _makerAssoc:Array;
      
      public static function registerMaker(makerName:String, maker:Class, scriptClass:Class = null) : void {
         _registeredMaker[makerName] = new MenuData(maker,scriptClass);
      }
      
      public static function registerAssoc(dataClass:*, makerName:String) : void {
         _makerAssoc[getQualifiedClassName(dataClass)] = makerName;
      }
      
      public static function unregister(dataType:Class, maker:Class) : void {
         if(MenuData(_registeredMaker[getQualifiedClassName(dataType)]).maker === maker)
         {
            delete _registeredMaker[getQualifiedClassName(dataType)];
         }
      }
      
      public static function create(data:*, makerName:String = null, makerParam:Object = null) : ContextMenuData {
         var td:MenuData = null;
         var maker:* = undefined;
         var tt:Array = null;
         if(!makerName)
         {
            makerName = _makerAssoc[getQualifiedClassName(data)];
         }
         if(makerName)
         {
            td = _registeredMaker[makerName];
         }
         if(td)
         {
            maker = new td.maker();
            tt = maker.createMenu(SecureCenter.secure(data),SecureCenter.secure(makerParam));
            return new ContextMenuData(data,makerName,tt);
         }
         if(makerParam is Array)
         {
            return new ContextMenuData(data,makerName,makerParam as Array);
         }
         return null;
      }
      
      public static function getMenuMaker(makerName:String) : Object {
         return _registeredMaker[makerName];
      }
      
      public static function existMakerAssoc(dataClass:*) : Boolean {
         return _makerAssoc[getQualifiedClassName(dataClass)]?true:false;
      }
   }
}
class MenuData extends Object
{
   
   function MenuData(maker:Class, scriptClass:Class) {
      super();
      this.maker = maker;
      this.scriptClass = scriptClass;
   }
   
   public var maker:Class;
   
   public var scriptClass:Class;
}
